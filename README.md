# Oceny really simple backend

```bash
bundle install
bundle exec rake db:create db:migrate

bundle exec rails s -p 3001
```

# Execute 

To build the docker image
```shell
docker build -t <your username>/oceny .
```

Your image will now be listed by Docker:
```shell
docker images
# Example
REPOSITORY               TAG             ID              CREATED
ruby                     2.2.3-slim      92b7501c276a    11 weeks ago
<your username>/oceny    latest          d64d3505b0d2    1 minute ago
```

Run the image in detached mode, leaving the container running in the background.
```shell
docker run -p 3001:3001 -d <your username>/oceny
```