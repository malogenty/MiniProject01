# Routes
## USER  
- [ ] a GET method: http://localhost:4000/api/users?email=XXX&username=YYY 
- [ ] a GET method: http://localhost:4000/api/users/:userID
- [ ] a POST method: http://localhost:4000/api/users
- [ ] a PUT method: http://localhost:4000/api/users/:userID
- [ ] a DELETE method: http://localhost:4000/api/users/:userID 

## WORKING TIME  
- [ ] a GET(ALL) method: http://localhost:4000/api/workingtimes/:userID?start=XXX&end=YYY 
- [ ] a GET(ONE) method: http://localhost:4000/api/workingtimes/:userID/:id
- [ ] a POST method: http://localhost:4000/api/workingtimes/:userID
- [ ] a PUT method: http://localhost:4000/api/workingtimes/:id
- [ ] a DELETE method: http://localhost:4000/api/workingtimes/:id 

## CLOCKING  
- [ ] a GET method: http://localhost:4000/api/clocks/:userID
- [ ] a POST method: http://localhost:4000/api/clocks/:userID

# Controllers methods
## USER
- [x] On GET
  - If there are query params, fetch in db and return 
    - 404 if no user
    - 200 + payload if found
  - if no query params, but /userId, fetch in db and return
    - 404 if no user
    - 200 + payload if found
- [x] On POST
  - If value passes validation (maybe add unique email ?)
    - Push to DB + 200 && payload 
  - Else returns 400
- [ ] On PUT
  - If value passes validation && user exists
    - Edit corresponding user + 200 && payload
  - Else returns 400 || 404
- [ ] On DELETE
  - If user exists
    - Delete corresponding user + 204
  - Else returns 404

## WORKING TIME  
- [ ] on GET
  - If query params && if no /id (GET ALL)
    - if userId valid
      - fetch to DB && returns 200 + payload
    - Else
      - returns 404
  - If no query params but /id (GET ONE)
    - if userId valid && id valid
      - fetch to DB && returns 200 + payload
    - Else
      - returns 404
- [ ] on POST
  - if userId valid 
    - post to DB && returns 200 + payload
  - Else
    - returns 404
- [ ] on PUT
  - if id valid
    - update DB && returns 200 + payload
  - else
    - returns 404
- [ ] on DELETE
  - if id valid
    - update DB && returns 204
  - else
    - returns 404

## CLOCKING  
- [ ] on GET
  - if userId valid
    - fetch && returns 200 + payload
  - Else
    - returns 404
- [ ] on POST
  - if userId Valid
    - update DB && returns 200 + payload
  - else 
    - returns 404