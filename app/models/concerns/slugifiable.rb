module Slugifiable

    module ClassMethods
        def find_by_slug(slug)
            #name = slug.gsub("-", " ").split(" ").map{|word| word.capitalize }.join(" ")
            name = slug.gsub("-", " ")

           #binding.pry
           # self.find_by(name: name)
           #self.ci_find('name', name)
           self.ci_find('username', name)
           ## CREATE THE ci_find METHOD IN YOUR OBJECTS
           ## BE MINDFUL OF THE ci_find ATTRIBUTE !!!!!!
        end
    end

    module InstanceMethods
        def slug
            #self.name.downcase.gsub(/\s/, "-")
            self.username.downcase.gsub(/\s/, "-")
        end
    end

end