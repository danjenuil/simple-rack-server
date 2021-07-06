# Simple JSON API Server (Ruby)

## About
An API server writen in Ruby using Rack gem and Active Record gem for manipulating database.

## Requirements

- Ruby (version 3.0.1 is recommended but should work fine with Ruby 2.x too)
- PostgreSQL
- Bundler (version 2.2.20)

## Setting up and running the server
**WARNING: Running the server will drop and recreate the tables (`users`, `posts` and `ratings`) each time. You may want to make changes to database.rb before running the server.**
1. Run `bundle install`
2. Run `rackup` to start the server (press Control-C to stop).

## Seed Data
1. Run the server first.
2. Run `ruby db/seeds.rb` to populate the database with sample data. 

## JSON API Endpoints
- `GET /top-post?n=5`, retrieve the top 5 posts by average rating.
- `GET /get-ip-listings`, get a list of IP addresses and showing an array of authors that posted content using those IP addresses.
- `POST /post`, create a post with content (must not be empty). 
- `POST /post/rate`, rate a post, accepts a value from 1 to 5.


