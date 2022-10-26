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

### Libraries
We will be using [Apex charts](https://apexcharts.com/docs/installation/#) for data visualisation. 