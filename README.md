# Warp-next

The Kir-Dev organization has history with image hosting under the project name 'warp-drive'. This new project aims to fulfill the same purpose: easy Rails application for internal image hosting, mostly needed by the blog-next project.

Techs:
* Ruby on Rails
* Primer CSS (by GitHub)
* PhotoSwipe
* PostgreSQL
* Docker

## Local setup

## Create database user

```bash
sudo su postgres # log in to postgres user
createuser -P -s warp # create a database user for the project
# Now the `createuser` command will prompt for a password. Make it `CHANGE-ME`.
exit # change back to your normal user
```

### Set up the database

```bash
rails db:setup # setup the database
rails s # serve application
```

### AuthSCH setup

1. Copy `.env.example` as `.env`:
    ```bash
    mv .env.example .env
    ```
2. Navigate to Developer console on [the AuthSCH admin page](https://auth.sch.bme.hu).
3. Create a new OAuth client, set the callback url to `http://localhost:3000/users/auth/authsch/callback`
4. Copy the received **client id** and **client secret** into the `.env` file, and restart your server app.

## Docker

```bash
docker volume create --name=warp_db # create the persistent database volume
docker-compose --file docker-compose.dev.yml up --build -d # run ONLY the database container
```

The database is accessible on port `5433`, so you might need to update the port in `config/database.yml`.

After creating the database container you have to set up the database from the console (see above).

## Disclaimer

* No testing yet
* When deployed, db should be saved sometimes
