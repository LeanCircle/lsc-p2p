if Rails.env.development?
  #require File.dirname( __FILE__ ) + '/../../config/environment'
  require 'shell'
  include Shell

  namespace :deploy do
    task :default => ["staging"]

    desc "Deploy to production from BRANCH=<ref>"
    task :production => :environment do
      branch = ENV['BRANCH'] || 'production'
      execute( "git push --force prod #{branch}:master" )
      execute( "heroku run rake --trace db:migrate --app lsc-p2p-production" )
      execute( "heroku restart --app lsc-p2p-production" )
      execute( "heroku run rake --trace db:seed --app lsc-p2p-production" )
    end

    desc "Deploy to Staging from BRANCH=<ref>"
    task :staging => :environment do
      branch = ENV['BRANCH'] || 'staging'
      execute( "git push --force stag #{branch}:master" )
      execute( "heroku pgbackups:capture --expire --app lsc-p2p-staging" )
      execute( "heroku pgbackups:capture --expire --app lsc-p2p-staging" )
      execute( "heroku pg:reset DATABASE --app lsc-p2p-staging" )
      execute( "heroku pgbackups:restore DATABASE `heroku pgbackups:url  --app lsc-p2p-production` --app lsc-p2p-staging --confirm lsc-p2p-staging" )
      execute( "heroku run rake --trace db:migrate --app lsc-p2p-staging" )
      execute( "heroku restart --app lsc-p2p-staging" )
      execute( "heroku run rake --trace db:seed --app lsc-p2p-staging" )
      execute( "rake airbrake:deploy TO=#{target}" )
    end

  end

end