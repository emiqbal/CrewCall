require 'nokogiri'
require 'open-uri'

def scraping_project

  project_title = []
  project_description = []
  project_photo_url = []
  project_hash = []

  # file = open('https://www.littleredants.com.sg/works/').read
  # doc = Nokogiri::HTML(file)

  doc = Nokogiri::HTML(File.open("db/redants.html"))

  doc.search('h3.post-title').each do |element|

    project_title << element.text.strip

    description_url = element.search('a').attribute('href').value

    html_file = open(description_url).read
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('span.proj-details-meta').each do |e|
    project_description << e.text
    end
  end
  doc.search('img.attachment-post-thumbnail').each do |element|
      project_photo_url << element.attribute('src').value
      end

  project_title.each_with_index do |project, index|
    project_hash << { title: project,
      description: project_description[index],
      photo_url: project_photo_url[index] }
  end
  project_hash
end
