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


## To import new data:

LOCALHOST:
1. Tear down/clear out the Database:
 `rails db:reset`
2. Recreate the tables:
`rails db:migrate`
3. Import the data:
`rails db:import_partners`

HEROKU STAGING:
1. Tear down/clear out the Database:
`heroku pg:reset -rstaging`
2. Recreate the tables:
`heroku run rails db:migrate -rstaging`
3. Import the data:
`heroku run rake db:import_partners -rstaging`

To add new Data Fields:
(Example: Adding "Procurement" and Adding "Featured_Listing" to Partner Data) 

1.Create a new Model: 

Example: Adding a featured_listing field to Partners
One-->Many = featured_listing-->partners
`rails g model featured_listing name:string`
Run the migration to reflect the changes in the database:
`rails db:migrate`

2.Add Relationship associations to Models:
*List of Associations: https://edgeguides.rubyonrails.org/association_basics.html

Example: Inside app/models/partner.rb add `belongs_to :featured_listings, optional: true` and 
Inside app/models/featured_listing.rb add `has_many :partners` within class definition

When your New Field has a many->many relationship with Partner: 
Reference: https://stackoverflow.com/questions/5120703/creating-a-many-to-many-relationship-in-rails/5120734

3a.Create a Join table using a Migration: 
`rails g migration CreateProcurementsPartnersJoinTable`

  -Run the migration to reflect the changes in the database:
`rails db:migrate`

  -Go to "routes.rb" and add: 
`resources :procurements` within the `namespace: admin`

  -Go to db.rake and add:
```ruby
procurement_names = val['Procurement'].to_s().split(', ')
  procurement_names.each do |procurement_name|
    unless procurement_name.blank?
      procurement = Procurement.find_or_create_by(name: procurement_name)
      procurement.partners << partner
    end
  end
end 
```

  -Go to "app/views/admin/partners/show.html.haml" and add procurements to the location you want to show it in

OR

When your New Field has a one-->many relationship with Partner:
3b.Add some Migrations:
*Since "partner" belongs_to "featured_listing", the "partner" table should have a "featured_listing_id" column as the foreign key
referencing to the featured_listing table*

a.Generate a migration to create featured_listing_id into the partner table:
```rails generate migration AddFeaturedListingToPartners```

b.Add the following line to the new migration file inside "db/migrate/(ordered by date)":

```ruby
class AddFeaturedListingToPartners < ActiveRecord::Migration[5.2]
  def change
      add_reference :partners, :featured_listing
  end
end
```

c.Run the migration to reflect the changes in the database:
```rails db:migrate```

*Open your schema file "/db/schema.rb" Now you can see "featured_listing_id" column in "partners" table

4.Generate one more migration for creating the foreign key:

a.Add "featured_listing_id" as a foreign key into the partner:
```rails g migration AddForeignKeyToPartner```

b.Add the following line to the new migration file inside "db/migrate/(ordered by date)":
```ruby
class AddForeignKeyToTask < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :partners, :featured_listings```
  end
end
```
c.Run the migration to reflect the changes in the database:
```rails db:migrate```
*Refer to the "To Import New Data" section in the README

5. Go the the "show.html.haml" file of the view you want to see the new field appear in and add

6. Go to "lib/tasks/db.rake" and add:
```ruby
featured_listing_name = val['Featured Listing']
   unless featured_listing_name.blank?
      featured_listing = FeaturedListing.find_or_create_by(name: featured_listing_name)
      featured_listing.partners << partner
    end
end
```

To generate a new Controller:
`rails g controller <path/<controller_name> <action>`

Example: 
`rails g controller admin/featured_listings create`


To create the featured_listing model:
`rails g model featured_listing name:string`
To undo  creating a model:
`rails destroy model featured_listing`

Note: See _.env.example_ for a complete list of expected environment
variables that need set in both staging & production environments.
&copy; 2020 Yong Joseph Bakos and Brayden Brown. All rights reserved.
