Cocktail Search by Drew Carlson

About
This project consumes the https://www.thecocktaildb.com api and returns different cocktail recipes depending on what word is passed in.
For example, doing the query "Sour" will return a Rum Sour and Whiskey Sour recipe.


Prerequisites
Ruby: 2.5.3
Rails: 5.2.1
mysql
postgres


Getting Started
To setup the app you'll need mysql for dev or test and postgres for production. Afterwards just run the migrations and the site should be able to start running.


Acceptable Query Parameters
query - This is the main command used to search. Having the query: "whiskey" will return a few drinks related to whiskey. Leaving query blank will still return results
order - This will define how you'd like the results ordered, the default is by id. Acceptable orders are: "id", "cocktail_id", "title", "glass", "thumbnail", "alcoholic", "instructions", "ingredients", "created_at", "updated_at"
clear_cache - Adding this param will force the rails cache to be cleared and the query to be searched again on thecocktaildb
filter_type - Used for filtering on certain columns, filter_search is required at the same time to perform a filter. Acceptable filter types are: "id", "cocktail_id", "title", "glass", "thumbnail", "alcoholic", "instructions", "ingredients", "created_at", "updated_at"
filter_search - Used with filter_type to perform a filter on a specific column, useful when you'd like to only view non-alcoholic recipes for example
limit - Specifies the amount of results you'd like returned. Must be more then 0 and less than 50. The default is 2 since the results from thecocktaildb are not very large
start - Used for paginating between the api results. Starts at 0 and can go up depending on the amount of the results.


Example Search Queries:
- Default query with no extra params
{
	"query": "Sour"
}

- A query for lemon drink recipes that are non alcoholic
{
	"query": "Lemon",
	"order": "title",
	"filter_type": "alcoholic",
	"filter": "Non alcoholic"
}

- A query forcing the application to clear the cache searching for rum ordered by the title and starting at the 4th item in the results and returning up to 15 results
{
  "clear_cache": "true",
	"query": "rum",
	"order": "title",
	"start": "3",
	"limit": "15"
}


Running the tests
Running the command 'rspec' will run all the individual specs that cover valid and invalid queries


Extra Details about the application
There are two models in the application: Search and Recipe. Search stores each unique query and Recipe stores the different recipes. There is a join table RecipeSearch that allows a recipe or search record to return their associations attached to it.
I decided to use a json column for storing the ingredients on a recipe since I didn't think those fields would be queried on at this time, especially the measurements.
I also added a rescue around the recipe index route. I'd usually have a catch all at the ApplicationController for returning results, but went with this method for time.