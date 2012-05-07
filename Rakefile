task default: [:build] do 
end

# task :build do
#   `cd ../blog; git pull`
#   puts "finish update source"

#   `ruby blog_update.rb`
#   puts "finish update data"

#   `bundle exec middleman build`
#   puts "finish create html"

#   `cp build/* /var/www/nginx-default -r`
#   puts "OK"
# end

task :build do
  `cd ../blog; git pull`
  `ruby blog_update.rb`
  `bundle exec middleman build`
  `cp build/* ../halida/ -rf`
  `cd ../halida; git add .; git push`
end
