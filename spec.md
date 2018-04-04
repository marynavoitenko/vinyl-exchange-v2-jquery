# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project :: application is built using Ruby on Rails framework, adheres to MVC design pattern
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes) :: Vinyl has_many Genres, Cart has_many Vinyls
- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User) :: Vinyl belongs_to Artist, Vinyl belongs_to User
- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients) :: Vinyl has_many Genres through VinylGenres, Cart has_many Vinyls through LineItems
- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity) :: lineitems.quantity
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item) :: Vinyl, Genre, Artist
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes) :: Vinyl.my_vinyls(user) URL: /vinyls/my_vinyls
- [x] Include signup (how e.g. Devise) :: Devise
- [x] Include login (how e.g. Devise) :: Devise
- [x] Include logout (how e.g. Devise) :: Devise
- [x] Include third party signup/login (how e.g. Devise/OmniAuth) :: Devise/OmniAuth : Facebook
- [x] Include nested resource show or index (URL e.g. users/2/recipes) :: artists/22/vinyls , artists/22/vinyls/1
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients) :: artists/22/vinyls
- [x] Include form display of validation errors (form URL e.g. /recipes/new) :: /vinyls/new , /vinyls/edit

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate
