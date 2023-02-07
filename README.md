# README

This is an API based project, to learn how to parse json from databases using typical rails techniques.

## API Endpoints:

/api/v1...
[ ] Items
  [x] get ...'/items'
  [x] get ...'/items/:id'
  [x] post ...'/items'
  [ ] patch ...'/items/:id'
  [ ] destroy ...'/items/:id'
  [ ] get ...'/items/:id/merchant'
  [ ] search endpoints:
    [ ] get ...'/items/find?name=(name)' or 'items/find?min_price=(num)', etc.

[ ] Merchants
  [x] get ...'/merchants'
  [x] get ...'/merchants/:id'
  [x] get ...'/merchants/:id/items'
  [ ] search endpoints:
    [ ] get ...'/merchants/find?name=(name)'

## Learned concepts:

[ ] Testing using Postman.
[ ] Serializing data to JSON guidelines for consumption.
[ ] Using additional controllers for 'non-RESTful' actions.