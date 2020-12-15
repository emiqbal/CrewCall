module ApplicationHelper
  def video_embed(video_url)

    # REGEX EXTRACT VIDEO ID
    regex_id = /(?:youtube(?:-nocookie)?\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/|vimeo\.com\/)([a-zA-Z0-9_-]{8,11})/
    match_id = regex_id.match(video_url)
    video_id = ""
    if match_id && !match_id[1].blank?
      video_id = match_id[1]
    end

    # REGEX EXTRACT PROVIDER - YOUTUBE OR VIMEO
    regex_prov = /(youtube|youtu\.be|vimeo)/
    match_prov = regex_prov.match(video_url)
    video_prov = ""
    if match_prov && !match_prov[1].blank?
      video_prov = case match_prov[1]
                     when "youtube"
                       :youtube
                     when "youtu.be"
                       :youtube
                     when "vimeo"
                       :vimeo
      end
    end

    case video_prov
      when :youtube
        "https://www.youtube.com/embed/#{video_id}"
      when :vimeo
        "https://player.vimeo.com/video/#{video_id}"
    end

  end
end
