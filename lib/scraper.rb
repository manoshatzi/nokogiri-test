require 'HTTParty'
require 'Nokogiri'

class Scraper

  attr_accessor :parse_page

  def initialize
    doc = HTTParty.get("https://www.creditkarma.com/credit-cards?ckt=navClickL2")
    @parse_page ||= Nokogiri::HTML(doc) # memorized the @parse_page so it only gets assigned once
  end

  def get_names
    item_container.css("h3").css("a").children.map { |name| name.text }.compact
  end

  private

  def item_container
    parse_page.css(".offer-card-header")
  end

  scraper = Scraper.new
  names = scraper.get_names

  (0...names.size).each do |index| #three dots don't include last digit. Behaev like 0..names -1
    puts "- - - index: #{index + 1} - - -"
    puts "Name: #{names[index]}"
  end

end
