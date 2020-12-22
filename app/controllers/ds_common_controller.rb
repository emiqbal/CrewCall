class DsCommonController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def ds_must_authenticate
    if Rails.configuration.quickstart == "true"
      redirect_to('auth/docusign')
    end
    @title = 'Authenticate with DocuSign'
    @show_doc = Rails.application.config.documentation

    if params[:auth] == 'grand-auth'
      redirect_to('/auth/docusign')
    elsif params[:auth] == 'jwt-auth'
      if JwtAuth::JwtCreator.new(session).check_jwt_token
        url = root_path
      else
        url = JwtAuth::JwtCreator.consent_url
      redirect_to root_path if session[:token].present?
      end
      if Rails.configuration.examples_API == 'Rooms'
        configuration = DocuSign_Rooms::Configuration.new
        api_client = DocuSign_Rooms::ApiClient.new(configuration)
      elsif Rails.configuration.examples_API == 'eSignature'
        configuration = DocuSign_eSign::Configuration.new
        api_client = DocuSign_eSign::ApiClient.new(configuration)
      end
      resp = ::JwtAuth::JwtCreator.new(session, api_client).check_jwt_token
      if resp.is_a? String
        redirect_to resp
      end
      redirect_to url
    end
  end

  def create_session
    # reset the session
    internal_destroy

    Rails.logger.debug "\n==> DocuSign callback Authentication response:\n#{auth_hash.to_yaml}\n"
    Rails.logger.info "==> Login: New token for admin user which will expire at: #{Time.at(auth_hash.credentials['expires_at'])}"
    store_auth_hash_from_docusign_callback
    user_job = UserJob.find(session[:ds_user_job_to_sign])
    redirect_to job_user_job_path(user_job.job, user_job) # how do we get the right job and the right user
  end

  private

  def internal_destroy
    session.delete :ds_expires_at
    session.delete :ds_user_name
    session.delete :ds_access_token
    session.delete :ds_account_id
    session.delete :ds_account_name
    session.delete :ds_base_path
    session.delete 'omniauth.state'
    session.delete 'omniauth.params'
    session.delete 'omniauth.origin'
    session.delete :envelope_id
    session.delete :envelope_documents
    session.delete :template_id
  end

  def store_auth_hash_from_docusign_callback
    session[:ds_expires_at]   = auth_hash.credentials['expires_at']
    session[:ds_user_name]    = auth_hash.info.name
    session[:ds_access_token] = auth_hash.credentials.token
    session[:ds_account_id]   = auth_hash.extra.account_id
    session[:ds_account_name] = auth_hash.extra.account_name
    session[:ds_base_path]    = auth_hash.extra.base_uri
  end

  def auth_hash
    @auth_hash ||= request.env['omniauth.auth']
  end
end
