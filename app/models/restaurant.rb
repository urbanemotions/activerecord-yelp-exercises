class Restaurant < ActiveRecord::Base
    has_many :dishes 
    has_many :tags, through: :dishes
    
    def tenth

    end
    
    def with_long_names

    end

    def max_dishes

    end

    def focused

    end

    def large_menu

    end
    
    def vegetarian

    end

    def name_like(name)

    end

    def name_not_like(name)

    end

end