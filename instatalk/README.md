# Instatalk

###### Ruby: `3.1.0` Rails: `7.0.1`

### About:
The "Instatalk" application allows users to communicate with each other in public chat rooms.

Upon entering the web page, the user is given a random name and can create rooms. Online users are displayed on the main page.

### Usage:

1. Clone repo
```
$ git clone git@github.com:phobco/instatalk.git
```

2. Install gems
```
$ bundle
```

3. Create database and run migrations (`PostgreSQL` database is used)
```
$ rails db:create
$ rails db:migrate
```

4. Start server
```
$ bin/dev
```
Open `localhost:3000` in browser

### or

Try it live [Instatalk](https://fast-instatalk.herokuapp.com/) (wait about 10 seconds for the server to start)
