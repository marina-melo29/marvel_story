# Marvel Story

#### Api_keys
First configure your api_keys in .env:

```http
  api_key='api_key_example'
  private_key='private_key_example'
```

#### Preparing with docker

```http
  > docker build -t marvel-story .
  > docker run marvel-story -p 3000
```

### If you don't use docker, then

#### Install RVM

```http
  > \curl -sSL https://get.rvm.io | bash
```

#### Prepare the environment

In the project folder, run:

```http
  > bundle install
```

#### Initializing your server

```http
  > rails s
```