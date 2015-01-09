# gman-services

## Getting Started
A few gotchas:

Octopus does not like to play nice with the database.yml and will not produce the
correct schema.rb file when running rake db:migrate. See issue #6 for more details.
The app will work without the schema.rb but any 
```rake db:schema:load``` commands will not work.

For development purposes:
```Bash
# run the following:
for db in grossman_dev gman_services_dev; do mysql -e "create database $db" ; done
```
Then do a:
```ruby
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed:development
```

Do not use:
```ruby
rake db:reset
```
