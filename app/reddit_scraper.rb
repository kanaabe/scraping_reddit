require_relative '../config/environment.rb'
#require 'pry'

class RedditScraper
  @@reddit = []
  PAGES = ["","/new/","/rising/","/controversial/","/top/"]


  def initialize_all_titles
    str = "http://www.reddit.com"
    PAGES.each do |page|
      @@reddit << scrape_titles(str+page)
    end

    @@reddit.uniq.flatten
  end

  def scrape_titles(str)
    doc = Nokogiri::HTML(open(str))
    arr=[]
    doc.css('a.title').each do |title|
      arr << title.text
    end
    arr
  end

end