class Dish < ActiveRecord::Base

    belongs_to :restaurant
    has_many :tags

    # def initialize(name, restaurant, tag)
    #     @name = name
    #     @restaurant = restaurant
    #     @tag = tag
    # end

    def names(name)
        @names
    end

    def max_tags

    end

    def untagged

    end
    def average_tag_count 

    end
    def tag_count 

    end
    def tag_names

    end
    def most_popular_tag

    end

end