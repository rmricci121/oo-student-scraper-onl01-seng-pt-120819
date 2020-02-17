require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
 
index_url = open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")
 
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    
    new_student = []
    doc.css("div.roster-cards-container").each do |student|
    student.css(".student-card").each do |s|
      #binding.pry
    name = s.css("a .student-name").text
    location  = s.css("a .student-location").text
    profile_url = s.css("a").attribute("href").value
    student_info = {:name => name,
                :location => location,
                :profile_url => profile_url}
    new_student << student_info
    end
  end
  new_student
  end

  
  def self.scrape_profile_page(profile_url)
      profile_info = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
   
    
      social = doc.css(".vitals-container .social-icon-container a").each 
      social.each do |element|
        
        if element.attr("href").include?("twitter")
          profile_info[:twitter] = element.attribute("href").value
        elsif element.attr("href").include?("linkedin")
          profile_info[:linkedin] = element.attribute("href").value
        elsif element.attr("href").include?("github")
          profile_info[:github] = element.attribute("href").value
        elsif element.attr("href").include?(".com")
         profile_info[:blog] = element.attribute("href").value
      end
    end
      profile_info[:profile_quote] = doc.css(".profile-quote").text
      profile_info[:bio] = doc.css(".description-holder p").text
      profile_info
    #binding.pry
  end

end

