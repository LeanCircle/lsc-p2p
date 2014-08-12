# Dev Notes

## Getting started

Make sure you have an application.yml file! You will need it for config variables.

Take application.yml.example and copy it as applcation.yml.
Please rename INTERCEPT_EMAIL to your email. You will receive all emails sent from the app to that email address if the environment variables are set to development.

Do not delete application.yml.example from the repo!

## Environment variables

All environment variables such as api keys are collected in the config/application.yml using Figaro gem - https://github.com/laserlemon/figaro

To push variables to heroku, use:

    rake figaro:heroku
    rake figaro:heroku[lsc-p2p-staging]
    rake figaro:heroku[lsc-p2p-production]

## Checking in Code and Deploying

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

    rake heroku:pull

or

    rake heroku:pull TARGET=staging

### Copy db from production to staging

    heroku pgbackups:capture --app leanstartupcircle-production
    heroku pgbackups:restore DATABASE `heroku pgbackups:url --app leanstartupcircle-production` --app leanstartupcircle-staging --confirm leanstartupcircle-staging

### Copy db to production / staging

WARNING: this will clobber your remote db files. NEVER do this.

    rake heroku:push TARGET = staging

or only in a dire circumstance

    rake heroku:push TARGET = production

Didn't work did it? If you can't figure out how, you shouldn't be doing it.


## Misc Heroku Tasks

### Script console on production / staging

    heroku console --app leanstartupcircle-production

or

    heroku console --app leanstartupcircle-staging

### Copy logs from production / staging

    heroku logs --app leanstartupcircle-production

or

    heroku logs --app leanstartupcircle-staging