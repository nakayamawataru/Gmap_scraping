require 'selenium-webdriver'
require "google_drive"

@wait_time = 3 
@timeout = 4

Selenium::WebDriver.logger.output = File.join("./", "selenium.log")
Selenium::WebDriver.logger.level = :warn
driver = Selenium::WebDriver.for :chrome
driver.manage.timeouts.implicit_wait = @timeout
wait = Selenium::WebDriver::Wait.new(timeout: @wait_time)

#検索ワード = key, 位置情報 = location(x,y)
keyword = "中野"
keyword = keyword.encode("UTF-8")
x = 35.710573
y = 139.664616
location = "@#{x},#{y}"

driver.get("https://www.google.com/maps/search/#{keyword}/#{location},16z/data=!3m1!4b1")

sleep 5


#各要素を配列としてまとめて取得
name = driver.find_elements(class: "section-result-title")
detail = driver.find_elements(class: "section-result-details")
location = driver.find_elements(class: "section-result-location")
opening_hours = driver.find_elements(class: "section-result-opening-hours")
rating_score = driver.find_elements(class: "cards-rating-score")
num_rating = driver.find_elements(class: "section-result-num-ratings")

=begin
#各ビジネスごとに情報をまとめて出力


#ステップ１：とりあえず出力する
p "ビジネス名：" + name[0].text
p "種類：" + detail[0].text
p "住所：" + location[0].text
p "営業時間：" + opening_hours[0].text
p "口コミランク：" + rating_score[0].text
p "口コミ数：" + num_rating[0].text

p "-------------------------"

p "ビジネス名：" + name[1].text
p "種類：" + detail[1].text
p "住所：" + location[1].text
p "営業時間：" + opening_hours[1].text
p "口コミランク：" + rating_score[1].text
p "口コミ数：" + num_rating[1].text

p "-------------------------"

p "ビジネス名：" + name[2].text
p "種類：" + detail[2].text
p "住所：" + location[2].text
p "営業時間：" + opening_hours[2].text
p "口コミランク：" + rating_score[2].text
p "口コミ数：" + num_rating[2].text

p "-------------------------"


#ステップ２zipメソッドを使って出力
name.zip(detail,location,opening_hours,rating_score,num_rating) {|aray|
     p aray[0].text
     p aray[1].text
     p aray[2].text
     p aray[3].text
     p aray[4].text
     p aray[5].text
     p "------------------------"
    }

=end

#Google spred sheetへ吐き出し gem "google_drive" 使用
    session = GoogleDrive::Session.from_config("config.json")
    sheets = session.spreadsheet_by_url("https://docs.google.com/spreadsheets/d/1Gm3ozXXi6z-_bBzckdRwwxwwBRYeEUHpsSGKoxpFW1g/edit#gid=0").worksheet_by_title("スクレイピング")

    #セル指定のため
    name_line = 2
    detail_line = 3
    location_line = 4
    opening_hours_line = 5
    rating_score_line = 6
    num_rating_line = 7
    border_line_line = 8


    #name.zip(detail,location,opening_hours,rating_score,num_rating) do |detail,location,opening_hours,rating_scpre,num_rating|
    name.zip(detail,location,opening_hours,rating_score,num_rating) {|aray|
        
    sheets[name_line, 2] = aray[0].text
    sheets[detail_line, 2] = aray[1].text
    sheets[location_line, 2] = aray[2].text
    sheets[opening_hours_line, 2] = aray[3].text
    sheets[rating_score_line, 2] = aray[4].text
    sheets[num_rating_line, 2] = aray[5].text
    sheets[border_line_line, 2] = "---------------------"

    name_line += 7
    detail_line += 7
    location_line += 7
    opening_hours_line += 7
    rating_score_line += 7
    num_rating_line += 7
    border_line_line += 7

    }
sheets.save


#写真のクラス数を数えられないか思案中
#img_count = driver.find_elements(role: "img")
#p img_count.length