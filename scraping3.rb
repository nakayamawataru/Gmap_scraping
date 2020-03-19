require 'selenium-webdriver'

@wait_time = 3 
@timeout = 4

Selenium::WebDriver.logger.output = File.join("./", "selenium.log")
Selenium::WebDriver.logger.level = :warn
driver = Selenium::WebDriver.for :chrome
driver.manage.timeouts.implicit_wait = @timeout
wait = Selenium::WebDriver::Wait.new(timeout: @wait_time)

keyword = "すき家"
keyword = keyword.encode("UTF-8")
x = 35.897343
y = 139.854345
location = "@#{x},#{y}"

driver.get("https://www.google.com/maps/search/#{keyword}/#{location},16z/data=!3m1!4b1")

sleep 5

name = driver.find_element(class: "section-result-title")
detail = driver.find_element(class: "section-result-details")
location = driver.find_element(class: "section-result-location")
opening_hours = driver.find_element(class: "section-result-opening-hours")
rating_score = driver.find_element(class: "cards-rating-score")
num_rating = driver.find_element(class: "section-result-num-ratings")

p "ビジネス名：" + name.text
p "種類：" + detail.text
p "住所：" + location.text
p "営業時間：" + opening_hours.text
p "口コミランク：" + rating_score.text
p "口コミ数：" + num_rating.text