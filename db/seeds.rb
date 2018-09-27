["dons", "cheez", "windy", "king", "rb", "chpole"].each do |name|
  r = Restaurant.create(name: name)
  {
    burger: ["meat", "fat", "meal"],
    fry: ["vegetarian", "side", "potato"],
    chicken: ["meat", "meal"],
    soda: ["drink", "sugar", "vegetarian"],
    taco: ["vegetarian"]
  }.each do |dish, tags|
    d = Dish.create(name: dish)
    tags.each do |tag|
      t = Tag.find_or_create_by(name: tag)
      d.tags << t
    end 
    r.dishes << d
  end
end
