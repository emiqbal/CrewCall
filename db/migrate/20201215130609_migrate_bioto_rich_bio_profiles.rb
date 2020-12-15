class MigrateBiotoRichBioProfiles < ActiveRecord::Migration[6.0]
  def up
    Profile.find_each do |profile|
      profile.update(rich_bio: profile.bio)
    end
  end

  def down
    Profile.find_each do |profile|
      profile.update(bio: profile.rich_bio)
      profile.update(rich_bio: nil)
    end
  end
end
