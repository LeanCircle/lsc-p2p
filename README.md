# Dev Notes

## Getting started

Make sure you have an application.yml file! You will need it for config variables.

Take application.yml.example and copy it as applcation.yml.
Please rename INTERCEPT_EMAIL to your email. You will receive all emails sent from the app to that email address if the environment variables are set to development.

Do not delete application.yml.example from the repo!

remember, after making any changes to your gems, use
  bundle install
  
You will also need to run
  rake db:reset
before running app for the first time

## Environment variables

All environment variables such as api keys are collected in the config/application.yml using Figaro gem - https://github.com/laserlemon/figaro

To push variables to heroku, use:

    rake figaro:heroku
    rake figaro:heroku[lsc-p2p-staging]
    rake figaro:heroku[lsc-p2p-production]

## Checking in Code and Deploying

### Development workflow

* Work in a Branch
  * Create branch with a semantic name (e.g. meetup_api_bug_fixes)
  * Write tests first
  * Make the tests pass!
  * Commit in nice small chunks
* Test on Staging
  * Push to staging
  * Confirm new code works in staging
* Deploy to Production
  * Merge to master
  * Deploy to production
  * Confirm new code works in production
  * Delete branch

### When pulling

Use rebase to make git a bit cleaner.

    git pull --rebase origin master

### Testing

Test before deploying!

    rake db:test:prepare # for creating/migrating test db
    guard # for starting continious testing ("Press enter inside guard for running all specs")
    rspec spec/ # for running specs. Please prefer guard over rspec spec/ command

### Deploying

Heroku-san is added for your convenience. You can see the docs here: https://github.com/fastestforward/heroku_san

    rake production deploy
    rake staging deploy

These commands will run migrations and restart the server.

To deploy the code to staging manually: (assuming your remotes are set up correctly)

    git push staging master
    heroku restart
    heroku restart workers

## Database

### Copy db from production / staging

WARNING: This will clobber your local db files

    heroku pgbackups:capture --app lsc-p2p-production
    curl -o latest.dump `heroku pgbackups:url --app lsc-p2p-production`
    pg_restore --verbose --clean --no-acl --no-owner -h localhost -U myuser -d mydb latest.dump

Note, you'd better have postgres installed locally for this!

### Copy db from production to staging

    heroku pgbackups:capture --app lsc-p2p-production
    heroku pgbackups:restore DATABASE `heroku pgbackups:url --app lsc-p2p-production` --app lsc-p2p-staging --confirm lsc-p2p-staging


## Misc Heroku Tasks

### Script console on production / staging

    heroku console --app lsc-p2p-production

or

    heroku console --app lsc-p2p-staging

### Copy logs from production / staging

    heroku logs --app lsc-p2p-production

or

    heroku logs --app lsc-p2p-staging

#### Updating votes

    Link.find_each(&:update_cached_votes)