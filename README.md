== Install

* gems
  gem 'redactor-rails', :git => 'git://github.com/vdv/redactor-rails.git'
  gem 'fupload-rails', :git => 'git://github.com/vdv/fupload-rails.git'
  gem 'galetahub-simple_captcha', :require => 'simple_captcha', :git => 'git://github.com/galetahub/simple-captcha.git'
  gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'

* add routes
  mount Qoqocms::Engine => "/"

rake qoqocms:install:migrations
rake db:migrate
rm public/index.html

== TODO

* generator:
  - routes
  - migrations
  - initializers  (перенести из проекта)
