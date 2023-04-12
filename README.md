### Prerequisites

The setups steps expect following tools installed on the system.

- [Ruby (2.7.6 recommended)](https://github.com/organization/project-name/blob/master/.ruby-version#L1)
- [Postgres (14.x recommended)](https://www.postgresql.org/download/) at port 5432 with default user and password (`postgres` and `postgres`)
- [Redis (7.x recommended)](https://redis.io/docs/getting-started/installation/) at port 6379

In case you use `docker compose` and want to install `Postgres` and `Redis` services using docker run:

```bash
docker-compose up -d # or docker compose up if you are using docker compose v2
```

### 1. Create and setup the database

Run the following commands to create and setup the database.

```ruby
rails db:setup
```

### 2. Start the server

You can start the rails server using the command given below. This will power the async process that will execute package indexation once it starts.

```ruby
foreman start -f Procfile.dev
```

Keep the server running while executing the sync task.

### 3. Run the first packages sync

And finally, to kick-off the first sync:

```ruby
rails packages:sync
```

And now you can visit sidekiq to follow packages sincronization at [http://localhost:3000/sidekiq](http://localhost:3000/sidekiq)


### Tests

You can run the test suite using:

```ruby
rails test
```

### Aditionals

Packages that are in the manifest but could not be found in the cran server can be listed with:

```bash
cat log/development.log | grep "not found"
```

Packages that are in the served but could not be created (invalid compression, corrupted, etc) can be listed with:

```bash
cat log/development.log | grep "malformed"
```

---

### Architecture and models

---

### Potential areas of improvement
