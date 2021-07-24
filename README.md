# README

## Local setup

## Create database user

```bash
sudo su postgres # log in to postgres user
createuser -P -s airsoft # create a database user for the project
# Now the `createuser` command will prompt for a password. Make it `CHANGE-ME`.
exit # change back to your normal user
```

### Set up the application

```bash
rails db:setup # setup the database
rails s # serve application
```

## Docker

```bash
docker volume create --name=warp_db # create the persistent database volume
docker-compose up --build -d -f "docker-compose.dev.yml" # run ONLY the database container
```

The database is accessible on port `5433`, so you must update the port in `config/database.yml`.

After creating the database container you have to set up the database from the console.

### AuthSCH setup
Copy .env.example to .env:

```bash
mv .env.example .env
```

Create an Outh Client at https://auth.sch.bme.hu with the follwing callback url:
```bash
http://localhost:3000/users/auth/authsch/callback
```
Complete '.env' with the `client id` and `client secret`, and restart the server.