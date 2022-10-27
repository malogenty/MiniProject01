# data-visualisation



## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```

### Lints and fixes files
```
npm run lint
```

## About the project
### Quick fix
IDEs can have a hard time finding the babel config file if they are not opened at the directory of the client folder.  
To solve that, add this piece of code to the eslint settings.json file 
```json
    "eslint.workingDirectories": [
        {
            "mode": "auto"
        }
    ],
```

# Store DOC
Always FETCH before you GET. Otherwise, the information in the state might be empty.
## All users
> Namespace: users/

ACTION ``fetchAllUsers``  
> Populates the store with basic informations about all users in the DB  

GETTER ``getAllUsers``  
> Returns an array of users  

## Current User
> Namespace: user/
### Actions
``resetUser``  
> Resets the currentUser object, so it is ready to be re-defined  

``fetchUser``  
> Expects a {id: xx} as a payload and will populate the store with basic infos about the requested user.  

``updateUser``  
> expects a {user: {xx: xx}}` payload and will trigger a POST and update the store accordingly  

``deleteUser``  
> Will delete the user from the DB and reset the current user object.  

``fetchWorkingTimesStartEnd``  
> Expects a {start: date, end: date} payload. Do not mind the date format, it will be formatted anyway. Populates the store with the current user's requested working times.  

``fetchWorkingTime``  
> Expects a {id: xx} payload. Will populate the store with the requested working time.  

``createWorkingTime``  
> Expects a {start: date, end: date} payload. Do not mind the date format, it will be formatted anyway. Populates the store with the newly created working time.  

``updateWorkingTime``  
> Expects a {start: date, end: date} payload (either parameters are optional).  Will send a POST request and update the store accordingly.  

``deleteWorkingTime``  
> Expects an id as payload. Will delete and remove from the store the given working time.  

``fetchClocks``  
> Will fetch all of the current user's clocks and populate the store with it.  

``createClock``  
> Expects a {status: bool} payload and will send a POST request, and update the store accordingly.  

### Getters
``getUser``  
> Will return NULL or an object of this kind:   
```js
{
    id: Number,
    username: String,
    email: String,
    workingTimes: [{id: Number, start: Date, end: Date, user: Number}],
    clocks: [{id: Number, status: Boolean, time: Date}]
}
```