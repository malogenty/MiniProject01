# ApiProject

Create user in PostgreSQL:  
  ``CREATE ROLE miniapiproject WITH LOGIN PASSWORD 'password';  
  ALTER ROLE miniapiproject CREATEDB;
  ``

Into the database (\connect miniproject01_dev):
```
GRANT SELECT, UPDATE, INSERT, DELETE ON users TO miniapiproject;
GRANT SELECT, UPDATE, INSERT, DELETE ON clocks TO miniapiproject;
GRANT SELECT, UPDATE, INSERT, DELETE ON workingtimes TO miniapiproject;
GRANT USAGE, SELECT ON SEQUENCE users_id_seq TO miniapiproject;
GRANT USAGE, SELECT ON SEQUENCE clocks_id_seq TO miniapiproject;
GRANT USAGE, SELECT ON SEQUENCE workingtimes_id_seq TO miniapiproject;
ALTER USER miniapiproject WITH SUPERUSER;
```


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
> Expects start/end to look like : YYYY-MM-DD HH:MM:SS
> Will return a response of this kind (JSON)
```json
[
  {
    "id": 1,
    "start": "2022-10-25 08:33:05",
    "end": "2022-10-25 13:30:15",
    "user": 5
  },
  {
    "id": 2,
    "start": "2022-10-25 14:30:0",
    "end": "2022-10-25 18:32:11",
    "user": 5
  }
]


```

``GET /api/workingtimes/:userId/:id``
> Will return a response of this kind (JSON)
```json
{  
  "id": 1,
  "start": "2022-10-25 08:33:05",
  "end": "2022-10-25 13:30:15",
  "user": 5
}
```

``POST /api/workingtimes/:userId`` 
> Expects a payload as such  
```json
{
  "workingTime": {
    "start": "2022-10-25 08:33:05",
    "end": "2022-10-25 13:30:15",
  }
}
```
> Will return a response of this kind (JSON)
```json
{
  "id": 1,
  "start": "2022-10-25 08:33:05",
  "end": "2022-10-25 13:30:15",
  "user": 5
}
```

``PUT /api/workingtimes/:id ``  
> Expects a payload as such  
```json
{
  "workingTime": {
    "end": "2022-10-25 13:30:15"
  }
}
```
> Will return a response of this kind (JSON)
```json
{
  "id": 1,
  "start": "2022-10-25 08:33:05",
  "end": "2022-10-25 13:30:15",
  "user": 5
}
```

``DELETE /api/workingtimes/:id ``  
> Will return code 204


## Clocking
``GET /api/clocks/:userID``
> Will return a response of this kind (JSON)
```json
[
  {
    "id": 1,
    "status": true,
    "time": "2022-10-25 08:33:05", // Please note that this is UTC Time
    "user": 5
  },
  {
    "id": 1,
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
> Will return a response of this kind (JSON)
```json
{
  "id": 1,
  "status": false,
  "time": "2022-10-25 13:30:15",
  "user": 5
}
```
