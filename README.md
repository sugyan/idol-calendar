### development ###

    $ git clone git://github.com/sugyan/idol-calendar.git
    $ cd idol-calendar
    $ bundle install --path vendor/gems
    $ bundle exec padrino rake sq:migrate:auto
    $ bundle exec padrino rake seed
    $ foreman start

### deploy ###

    $ heroku apps:create
    $ heroku config:set TZ=Asia/Tokyo
    $ heroku config:set GOOGLE_API_EMAILADDRESS=*********************************************@developer.gserviceaccount.com
    $ heroku config:set GOOGLE_API_KEY="-----BEGIN RSA PRIVATE KEY-----
    ...
    -----END RSA PRIVATE KEY-----"
    $ heroku run bundle exec padrino rake sq:migrate:auto
    $ heroku run bundle exec padrino rake seed
    $ git push heroku master

### tasks ###

- scraping

    $ bundle exec padrino rake scraping
