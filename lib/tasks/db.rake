require 'json'

namespace :db do
  desc "Import Partner values into database"
  task import_partners: :environment do
    json = JSON.parse(File.read('lib/assets/hdffa-app-export.json.txt'))
    partners = json['Partners']
    partners.each do |key, val|
      partner = Partner.create!(
        name: key,
        latitude: val['Latitude'],
        longitude: val['Longitude'],
        description: val['Description'],
        street_address: val['Street Address'],
        city: val['City'],
        state: val['State'],
        zip: val['ZIP'],
        email: val['Email'],
        phone: val['Phone'].size < 10 ? '' : val['Phone'],
        url: (val['Website'].start_with?('https') ? val['Website'] : "https://#{val['Website']}").downcase!,
        hours_of_operation: val['Hours of Operation'],
        discount: val['Discount'],
      )
      social_links = val['Social Account'].to_s().split(' ')
        social_links.each do |social_link|
          unless social_link.blank?
            if social_link.include? "twitter"
              partner.twitter = social_link
            elsif social_link.include? "instagram"
              partner.instagram = social_link
            elsif social_link.include? "facebook"
              partner.facebook = social_link
            end
          end
        end
      category_names = val['Category'].to_s().split(', ')
      category_names.each do |category_name|
        unless category_name.blank?
          category = Category.find_or_create_by(name: category_name)
          category.partners << partner
        end
      end
      product_names = val['Products'].to_s().split(', ')
      product_names.each do |product_name|
        unless product_name.blank?
          product = Product.find_or_create_by(name: product_name)
          product.partners << partner
        end
      end
      featured_listing_name = val['Featured Listing']
      unless featured_listing_name.blank?
        featured_listing = FeaturedListing.find_or_create_by(name: featured_listing_name)
        featured_listing.partners << partner
      end
      dietary_names = val['Dietary'].to_s().split(', ')
      dietary_names.each do |dietary_name|
        unless dietary_name.blank?
          dietary = Dietary.find_or_create_by(name: dietary_name)
          dietary.partners << partner
        end
      end
      procurement_names = val['Procurement'].to_s().split(', ')
      procurement_names.each do |procurement_name|
        unless procurement_name.blank?
          procurement = Procurement.find_or_create_by(name: procurement_name)
          procurement.partners << partner
        end
      end
      value_names = val['Value'].to_s().split(', ')
      value_names.each do |value_name|
        unless value_name.blank?
          value = Value.find_or_create_by(name: value_name)
          value.partners << partner
        end
      end
    end
  end
end
