# ActiveRecord Practice Exercises

## Overview

In this lab, you'll practice all of the parts of ActiveRecord - Migrations, Validations, Seeds, and Querying.

## Introduction  

We'll be building out a restaurant domain in two stages. Remember to draw out the relationships between your models before you start building.

### Stage 1

We'll be creating the following models:
- Restaurant
-	Dish
-	Tag

**Migrations**

- Restaurant
	- name
	- has many dishes
- Dish
	- name
	- has many tags
- Tag
	- name
	- has many dishes

*Do you need any join tables? What data should they have?*

**Validations**

- Restaurants need a name
- Dishes need a name and a restaurant
- Tags need a name 3 characters or longer
- Tag names can only be one word or two words, not more
- Dishes can only have one of any particular tag

**Seeds**

Create a seeds file that creates:

* 20 restaurants.
* Each restaurant should have 10 dishes
* Each Dish should have 3 tags
* There should be only 10 or 15 tags, with names like 'Spicy' and 'Vegetarian'

*Reminder: Be DRY - use an array of names and iterate through them to create your restaurants*

**Querying**

Write the following methods. You should use ActiveRecord query methods to get the results (i.e. you shouldn't just use `.all` and use array methods!)

*Note: some helper methods you will need (e.g. the relationships between the models) are not listed here. Write them anyway!*

*Restaurant*
* `Restaurant.mcdonalds` - find the restaurant with the name `'McDonalds'`.
* `Restaurant.tenth` - find the tenth restaurant
* `Restaurant.with_long_names` - find all the restaurants with names longer than 12 characters
* `Restaurant.max_dishes` - find the restaurant with the most dishes
* `Restaurant.focused` - find all the restaurants with fewer than 5 dishes
* `Restaurant.large_menu` - find all the restaurants with more than 20 dishes
* `Restaurant.vegetarian` - all restaurants where all of the dishes are tagged vegetarian
* `Restaurant.name_like(name)` - all restaurants where the name is like the name passed in
* `Restaurant.name_not_like(name)` - all restaurants where the name is not like the name passed in
* `Restaurant#most_popular_tag` - find the most common tag among dishes at this restaurant

*Dish*
* `Dish.names` - all the names of dishes
* `Dish.max_tags` - single dish with the most tags
* `Dish.untagged` - dishes with no tags
* `Dish.average_tag_count` - average tag count for dishes
* `Dish#tag_count` - number of tags for a dish
* `Dish#tag_names` - names of the tags on a dish
* `Dish#most_popular_tag` - most widely used tag for a dish

*Tag*
* `Tag.most_common` - tag with the most associated dishes
* `Tag.least_common` - tag with the fewest associated dishes
* `Tag.unused` - all tags that haven't been used
* `Tag.uncommon` - all tags that have been used fewer than 5 times
* `Tag.popular` - top 5 tags by use
* `Tag#restaurants` - restaurants that have this tag on at least one dish
* `Tag#top_restaurant` - restaurant that uses this tag the most
* `Tag#dish_count` - how many dishes use this tag

ActiveRecord methods you might find useful:
- `find`
- `where`
- `pluck`
- `joins`
- `includes`
- `group`
- `having`

[Examples and explanations here](https://guides.rubyonrails.org/active_record_querying.html#conditions)

*Note: In order to test these methods, you'll probably need to have particular seed data. Create it.*

## Stage 2

> Mo models, mo problems.

Add the following models to the domain:
*	Customer
*	Order
*	Review

**Migrations**

- Customer
	- name
  - lat
  - lon
  - has many orders
  - has many reviews
- Order
  - belongs to a customer
  - belongs to a restaurant
  - has many dishes
- Review
  - content
  - rating
  - date
  - belongs to a customer
  - belongs to a restaurant

And add to your old models
- Dish
  - price
  - cost (price the restaurant paid to make it)
- Restaurant
  - lat
  - lon

*Again - what other tables do you need? Draw your relationships to find out.*

**Validations**

- Customer name is required
- Customer lat and lon must be valid latitude and longitude (-90 < lat < 90, -180 < lon < 180)
- Order needs a customer and a restaurant
- Order needs at least one dish
- Order dishes must all be from the same restaurant
- Review must have a customer and a restaurant
- Review must have content > 10 characters
- Review rating must exist, be one of the values [1,2,3,4,5]. See [Enums](https://guides.rubyonrails.org/active_record_querying.html#enums).
- Review customer must have made an order from the restaurant

**Queries**
*You'll need to update your old seed data and add more to be able to test these query methods.*

*Customer*
- `Customer#recent_reviews` - all reviews by this customer, ordered by recency
- `Customer#nearest_restaurant` - nearest restaurant to the customer's location
- `Customer#top_restaurant` - restaurant where the customer has the most orders
- `Customer#top_dish` - most commonly ordered dish for the customer
- `Customer#total_spending` - total price of all dishes ordered
- `Customer.top_spenders` - top 5 customers by total order price

*Order*
- `Order#total_price` - sum of the price of all the dishes.
- `Order#profit` - difference between price and cost of all the order's dishes
- `Order#profitable?` - true if order profit is positive
- `Order#tags` - tags of all the dishes in an order
- `Order.cheapest` - lowest 5 orders by total price
- `Order.most_expensive` - highest 5 orders by total price

*Review*
- `Review.median_rating` - median rating for all reviews
- `Review.most_recent` - most recent 10 reviews

*Restaurant*
- `Restaurant#average_rating` - average rating of a restaurant
- `Restaurant.average_rating` - average rating across all restaurants
- `Restaurant.highest_rated` - highest average rated restaurant
- `Restaurant.top_five` - top five highest rated restaurants
- `Restaurant#dollar_rating` - how many dollar signs is this restaurant?
  - $: avg_dish_price < 10
  - $$: 10 < avg_dish_price < 20
  - $$$: 20 < avg_dish_price < 30
  - $$$$: 30 < avg_dish_price
- `Restaurant.most_expensive` - most expensive restaurant by average dish price
- `Restaurant.cheap_eats` - all $ and $$ restaurants
- `Restaurant.nearest_customers` - nearest 5 customers
- `Restaurant.recent_reviews` - 5 most recent reviews of this restaurant
- `Restaurant#best_seller` - most ordered dish for the restaurant
- `Restaurant#most_profitable_dish` - most profitable dish `(price - cost) * num orders`

*Dish*
- `Dish#top_customer` - customer who has ordered a dish the most times
- `Dish.most_ordered` - most ordered dish

*Tag*
- `Tag#nearest_restaurant(customer)` - nearest restaurant to the customer with that tag.
- `Tag#top_rated` - top 3 rated restaurants with dishes with a tag

## Bonus 1. Schema Constraints

Read [this](https://robots.thoughtbot.com/validation-database-constraint-or-both) about schema constraints. Add the appropriate schema constraints to your tables. For instance, things that have a validation for `presence: true` should probably also have `null: false` in the schema.

## Bonus 2. N+1 Queries

Read [the section of the rails guide](https://guides.rubyonrails.org/active_record_querying.html#eager-loading-associations) about N+1 queries and Eager Loading Associations. Using the [ActiveRecord Logger](https://guides.rubyonrails.org/v2.3.11/debugging_rails_applications.html#the-logger), find out which of the methods you've written so far have an N+1 query. Fix them.
