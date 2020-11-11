# README

## DB情報
# Task
  |column|data|
  |:--|--:|
  |name|string|
  |content|text|

## heroku deploy
1. heroku_login
  $ heroku login
2. Git commit
  $ git add .
  $ git commit -m "commit message"
3. create heroku app
  $ heroku create
4. add build pack
  $ heroku buildpacks:set heroku/ruby
  $ heroku buildpacks:add --index 1 heroku/nodejs
5. deploy
  $ git push heroku master
6. create table
  $ heroku run rails db:migrate
