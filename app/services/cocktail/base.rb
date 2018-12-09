module Cocktail
  class Base
    CACHE_DEFAULTS = { expires_in: 2.days, force: false}

    def initialize(args = {})
      args.each do |name, value|
        attr_name = name.to_s.underscore
        send("#{attr_name}=", value) if respond_to?("#{attr_name}=")
      end
    end

    def parse_ingredients(args = {})
      ingredients = args.select { |k, v| k.include?("strIngredient") && !v.blank? }.transform_keys { |k| k.sub("strIngredient", "") }
      ingredients = ingredients.inject({}) { |h, (k, title)| h[k] = {title: title.strip}; h }
      args.select { |k, v| k.include?("strMeasure") && !v.blank? }.each { |k, measurement| ingredients[k.sub("strMeasure", "")][:measurement] = measurement.strip }
      ingredients
    end

    def update_recipe(args = {})
      r = Recipe.find_or_initialize_by(cocktail_id: args["idDrink"])
      r.ingredients = parse_ingredients(args)
      r.assign_attributes(title: args["strDrink"], instructions: args["strInstructions"], glass: args["strGlass"], alcoholic: args["strAlcoholic"], thumbnail: args["strDrinkThumb"])
      r.save ? r : nil
    end
  end
end