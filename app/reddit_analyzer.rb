require_relative '../config/environment.rb'

class RedditAnalyzer
  @@frequency = {}

  def call
    scraper = RedditScraper.new.initialize_all_titles
    add(scraper)
    #binding.pry
  end

  def add(arr)
    arr.each do |title|
      title.downcase.split(" ").each do |word|
        word.gsub(/[,.\[\]'?!-\"]/, "")
        if @@frequency[word]
          @@frequency[word] = @@frequency[word] + 1 
        else
          @@frequency[word] = 1
        end
      end
    end

  end

  def top_20
    delete_common
    sorted = @@frequency.sort_by {|k,v| -v}
    sorted.each_with_index do |word,ind|
      puts "#{word[0]} with frequency #{word[1]}" if ind <=19
    end
  end

  def delete_common
    text = []
    File.read("resources/common_words.txt").each_line do |line|
      text << line.chop
    end
    #puts text
    @@frequency.each do |word,v|
      if text.include?(word)
        #puts word
        @@frequency.delete(word)
      end
    end
  end

end

r = RedditAnalyzer.new
r.call
#r.delete_common
r.top_20