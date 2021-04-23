# HDFFA Directory

A searchable directory of locally-sourced food sources, sponsored by the
[High Desert Food and Farm Alliance](https://www.hdffa.org).

## Expectations

This is a Rails 5.x app with Ruby \~2.6, PostgreSQL, and AWS for storage.

After cloning this repository and `cd`ing into it, get up and running with:

`bundle install`
`rails db:setup`
`rails s`

## Development

There are a few steps to get up and running in development.

### Customize `.env`

* `RECAPTCHA_SITE_KEY`
* `RECAPTCHA_SECRET_KEY`

See _.env.example_ for a complete list of expected environment variables.

### TODO

## Testing

This app is using minitest / Rails default tests. Run the suite with:

`rails test`

Note: There is a _Guardfile_ should you wish to use guard.

## Production

There is a staging and production environment hosted by Heroku.

```
heroku git:remote -a hdffa-directory-staging
git remote rename heroku staging
heroku git:remote -a hdffa-directory
git remote rename heroku production
```

By renaming the remotes, you can then deploy with

```
git push staging
git push production
```

Configure env vars in staging and production:

* `RECAPTCHA_SITE_KEY`
* `RECAPTCHA_SECRET_KEY`
* `AWS_S3_KEY`
* `AWS_S3_SECRET`
* `AWS_REGION`
* `AWS_S3_BUCKET`


To import new data:

LOCALHOST:
1. Tear down/clear out the Database:
```rails db:reset```
2. Recreate the tables:
```rails db:migrate```
3. Import the data:
```rails db:import_partners```

HEROKU STAGING:
1. Tear down/clear out the Database:
```heroku pg:reset -rstaging```
2. Recreate the tables:
```heroku run rails db:migrate -rstaging```
3. Import the data:
```heroku run rake db:import_partners -rstaging```

To add new Fields: 
To create a new Model: 

Example: Adding a featured_listing field to Partners
One-->Many 
featured_listing-->partners

```rails g model featured_listing name:string```

To generate a new Controller:
```rails g controller <path/<controller_name> <action>```

Example: 
```rails g controller admin/featured_listings create```


To create the featured_listing model:
```rails g model featured_listing name:string```
To undo  creating a model:
```rails destroy model featured_listing```

Note: See _.env.example_ for a complete list of expected environment
variables that need set in both staging & production environments.
&copy; 2020 Yong Joseph Bakos and Brayden Brown. All rights reserved.
