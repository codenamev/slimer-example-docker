# Slimer on Docker

A brief example of running [Slimer](https://github.com/codenamev/slimer) on Docker.

## Batteries Included

This is meant to be a turn-key solution to running Slimer on a local network.
It is especially useful when you need a convenient place to dump data to that is not
in the cloud.

This specific implementation will run three containers:

1. slimer – The Slimer web server that receives requests; it is configured
   to listen on port `6660`.
2. slimer-workers – Used to broker storage requests with Redis.
3. slimer-redis – The Redis server used in tandem with slimer-workers.
4. slimer-database – A PostgreSQL database to store Slimer's substances.

## Prerequisites

* [Docker Compose](https://docs.docker.com/compose/install/)

## Setup

1. Clone this repository – `git clone https://github.com/codenamev/slimer.git`
2. `cd slimer && docker-compose up -d`
3. Visit http://localhost:6660/status and verify Slimer responds with `Ok`.
4. Generate an API key: `docker-compose run slimer rake slimer:api_keys:generate`, and enter a name for the key when it asks.

## Consuming substances

Using the API key you generated above, you can tell Slimer to consume any
substance in one of two ways. Replace any `API_KEY` in the URLs below with the
API key you generated  in the Setup above.

**Consume via GET request**

`curl http:/localhost:6660/API_KEY/consume?store_this=this&and_that=that`

The above request will create a substance with a `payload` of:

```json
{
  "store_this": "this",
  "and_that": "that"
}
```

**Consume via POST request

The same request above can be made as a `POST` request:

```bash
curl -X POST -H "Content-Type: application/json" \
  -d '{"store_this": "this", "and_that": "that"}' \
  http:/localhost:6660/API_KEY/consume
```

** Metadata **

Substances can be stored with metadata to describe the data being stored.
Simply provide a `metadata` parameter in your payload and this will be stored
separately.

## Upgrading

The upgrade process is as simple as:

1. Stop any running Slimer containers – from the directory you cloned this
   example app into, run: `docker-compose down`
2. Upgrade Slimer: `bundle update`
3. Re-build your Docker containers: `docker-compose build`
4. Re-start Slimer: `docker-compose up -d`
