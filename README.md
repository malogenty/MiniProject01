# ApiProject

Create user in PostgreSQL:  
  ``CREATE ROLE miniapiproject WITH LOGIN PASSWORD 'password';  
  ALTER ROLE miniapiproject CREATEDB;
  ``


To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

# Api routes
## Users
``GET /api/users?email=xxx&username=xxx``
> Will return a response of this kind (JSON) :
```json
{
    "email": "name@domain.com",
    "id": 1,
    "username": "somename"
}
```

``GET /api/users/:userId``
> Will return a response of this kind (JSON) : 
```json
{
    "email": "name@domain.com",
    "id": 1,
    "username": "somename"
}
```

``POST /api/users``
> Expects a payload as such: 
```json
{
  "user": {
    "email": "name@domain.com",
    "username": "somename"
  }
}
```
> Will return a response of this kind (JSON) : 
```json
{
    "email": "name@domain.com",
    "id": 1,
    "username": "somename"
}
```

``PUT /api/users/:userId``
> Expects a payload as such: 
```json
{
  "user": {
    "username": "somename"
  }
}
```
> Will return a response of this kind (JSON) : 
```json
{
    "email": "name@domain.com",
    "id": 1,
    "username": "somename"
}
```

``DELETE /api/users/:userId``
> Will return code 204

## Working time
``GET /api/workingtimes/:userId?start=xxx&end=xxx``
``GET /api/workingtimes/:userId/:id``
``POST /api/workingtimes/:userId``
``PUT /api/workingtimes/:id ``
``DELETE /api/workingtimes/:id ``
## Clocking
``GET /api/clocks/:userID``
> Will return a response of this kind (JSON)
```json
[
  {
    "status": true,
    "time": "2022-10-25 08:33:05", // Please note that this is UTC Time
    "user": 5
  },
  {
    "status": false,
    "time": "2022-10-25 13:30:15",
    "user": 5
  },
]
```
``POST /api/clocks/:userID``
> Expects a payload as such ; date-time will be generated from the back-end.
```json
{
  "user": 5,
  "status": false
}
```