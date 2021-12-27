# Warp-next

The Kir-Dev organization has history with image hosting under the project name 'warp-drive'. This new project aims to fulfill the same purpose: easy Rails application for internal image hosting, mostly needed by the blog-next project.

## Felhasználás:

- Köröket kérésre készít a Warp üzemeltetője.
- Minden újonnan belépő személynek jelentkeznie kell egy körbe a nyitó oldalon. A kör adminjai elfogadják a belépni kívánó személyt, ezután tud albumokat rendezni és használni.

## Tech

### Development notes

* Be aware, albums are *public* as a default.
  * public: which means the album is accessible to the internet (every image is public by default and will stay as is, [but no worries](https://edgeguides.rubyonrails.org/active_storage_overview.html#serving-files))
* After long research it is not clear to me, if it would be possible to create shorter urls for the images with custom endpoint on our album controller, but it is free for all to prove me wrong with a solution. /triszt4n/
  * So that's why the "copy" button is designed, only so that after uploading you could also get instantly that long url for yourself to use it in a blog post or something like that.

### Tech stack

* Ruby on Rails (ActiveStorage as the image storage)
* Bulma
* PhotoSwipe
* PostgreSQL
* Docker

## Local setup

*note:* This repo uses Ruby 3.0.2, if you use rbenv, install it with `rbenv install 3.0.2`.

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

#### Docker database

You might be wanting to use docker for containerizing the postgres DBMS instead of installing one yourself:

```bash
docker volume create --name=warp_db # create the persistent database volume
docker-compose --file docker-compose.dev.yml up --build -d # run ONLY the database container
```

After creating the database container you have to set up the database from the console (see above).

### AuthSCH setup

1. Copy `.env.example` as `.env`:
    ```bash
    cp .env.example .env
    ```
2. Navigate to Developer console on [the AuthSCH admin page](https://auth.sch.bme.hu).
3. Create a new OAuth client, set the callback url to `http://localhost:3000/auth/oauth/callback`
4. Copy the received **client id** and **client secret** into the `.env` file, and restart your server app.

## Disclaimer

* No testing yet
* When deployed, db and web container's warp-next/storage directory (with the images) should be saved sometimes
