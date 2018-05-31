# Specifications for the Rails with jQuery Assessment

Specs:
- [x] Use jQuery for implementing new requirements
- [x] Include a show resource rendered using jQuery and an Active Model Serialization JSON backend. I've added json response to vinyl show controller action and loaded it on the page via ajax get request
- [x] Include an index resource rendered using jQuery and an Active Model Serialization JSON backend. I've added json response to vinyl index controller action and loaded it on the "my_vinyls" page via ajax get request
- [x] Include at least one has_many relationship in information rendered via JSON and appended to the DOM. Vinyl has_many Genres. On Vinyl show I've added a button to load genres. On button click genres get appended to the DOM via ajax request.
- [x] Use your Rails API and a form to create a resource and render the response without a page refresh. On "my_vinyls" page I've added a new vinyl form. On submit a new vinyl gets appended to vinyls table without page refresh.
- [x] Translate JSON responses into js model objects. I've created JS model objects for Vinyl and Genre, and converted ajax response into those.
- [x] At least one of the js model objects must have at least one method added by your code to the prototype. Vinyl and Genre both have prototype methods for formating.

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
