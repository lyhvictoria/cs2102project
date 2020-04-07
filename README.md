# CS2102 Food Delivery Service Application Project 

# Requirements & Set Up
1. NodeJS must be installed: https://nodejs.org/en/
2. Clone this repo `git clone https://github.com/lyhvictoria/cs2102project.git`
3. Open command terminal and change directory to the `/App` folder using `cd <path>/App` replace path with the correct path.
4. Get the required node modules with `npm install` in terminal. These are included in the `.gitignore` file so it won't be pushed to the repo (cos its alot of stuff so a lotta space). So rmb to get em.
5. To enable us to connect to the database:

    Create a file called `.env` in `/App` folder and include this line:
`DATABASE_URL=postgres://username:password@host address:port/database_name` 

    Note: This file is included in `.gitignore` cos passwords shouldn't be shared

# To Run
1. Change directory to `/App` in terminal
2. Enter `node bin\www` in terminal
3. Open browser and go to `localhost:3000`
4. Remember to `Ctrl + c` when done to close server

# Navigation Help
## App folder
Where we do the work
- `app.js` is kindof like our "main" function
- /routes : tldr is backend/communicates with database
- /views : contains all the frontend stuff
    - /partials : contains reusable frontend code

## Database folder
Just to hold our .sql files, files this folder does not interct with the app (yet idk). There is a seperate folder for the database that does in `App/database`. Files here probably helps to set up the database for the app.