# README

This is an API based project, to learn how to parse json from databases using typical rails techniques.

## API Endpoints:

/api/v1...
[ ] Items
  [x] get ...'/items'
  [x] get ...'/items/:id'
  [x] post ...'/items'
  [x] patch ...'/items/:id'
  [x] delete ...'/items/:id'
  [x] get ...'/items/:id/merchant'
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
[x] Serializing data to JSON guidelines for consumption.
[ ] Using additional controllers for 'non-RESTful' actions.
[ ] Handling errors and supplying appropriate statuses / messages.