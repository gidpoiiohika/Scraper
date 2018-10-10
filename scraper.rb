require 'httparty'
require 'nokogiri'

class Scraper

  attr_accessor :parse_page

  @@text = "#{'twitter_it_s_what_s_happening'}"

  def perform
    url = 'https://twitter.com/'
    doc = HTTParty.get(url)
    @parse_page ||= Nokogiri::HTML(doc)
  end
  

  def get_button
    buttons = perform.css("button")
    buttons.each do |button|
      h = { button.name => {"#{'@@text'}_#{button.text}_#{button.name}" => {
        type: button.name, 
        selector: "css", 
        identifier: button.css_path }}}
      puts h
    end
  end

  def get_link
    links = perform.css("link")
    links.each do |link|
      h = { link.name => {"#{@@text}_#{link.name}" => {
        type: link['rel'], 
        selector: "css", 
        identifier: link.css_path }}}
      puts h
    end
  end

  def get_div
    divs = perform.css("div")
    divs.each do |div|
      h = { div.name => {"#{@@text}_#{div['class']}_#{div.name}" => {
        type: div.name, 
        selector: "css",
        identifier: div.css_path }}}
      puts h
    end
  end

  def get_span
    spans = perform.css("span")
    spans.each do |span|
      h = { span.name => {"#{@@text}_#{span['class']}_#{span.name}" => {
        type: span.name,
        selector: "css",
        identifier: span.css_path }}}
      puts h
    end
  end

  scraper = Scraper.new
  button = scraper.get_button
  link = scraper.get_link
  div = scraper.get_div
  span = scraper.get_span
end
