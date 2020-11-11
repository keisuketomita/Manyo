# README

## DB情報
# Task
  |column|data|
  |:--|--:|
  |name|string|
  |content|text|

## heroku deploy
1. heroku_login
    1. $ heroku login
2. Git commit
    1. $ git add .
    2. $ git commit -m "commit message"
3. create heroku app
    1. $ heroku create
4. add build pack
    1. $ heroku buildpacks:set heroku/ruby
    2. $ heroku buildpacks:add --index 1 heroku/nodejs
5. deploy
    1. $ git push heroku master
6. create table
    1. $ heroku run rails db:migrate
