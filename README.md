# Payment App

## Application specs:

- Ruby version: 3.0.1
- Rails version: 6.1.7
- Database: PostgreSQL
- Background: Sidekiq
- API: Grape
- Testing suite: Rspec

## Setting up locally

Setting up the application locally isn't too hard. Just follow the steps below:

- **Install requirements:** [RVM](https://rvm.io/rvm/install), [PostgreSQL](http://postgresapp.com)
- **Setup database.yml:** `cp config/database.yml.sample config/database.yml`
- **Setup credentials:** `cp .env.sample .env`. Please use your own creds when using locally.
- **Setup DB:** `rake db:setup`
- **Install gems:** `bundle install`

## Make changes

- Open the project in Sublime Text: `subl .`
- Change what you want
- Make a commit

## Run server

```
    rails s
```

## Run sidekiq

```
    bundle exec sidekiq
```

## API path to add transaction 

URL:
```
    http://localhost:3000/api/v1/transactions
```

Parametres:
```
    {
      uuid: 'abc123def',
      status: 'approved',
      merchant_id: <merchant.id>,
      customer_email: 'abcf@gmail.com',
      amount: 10.2
    }
```


### Instructions to run rake task for import ###

1) For Merchant
```
    rake import:csv_model_import[lib/assets/merchants.csv,Merchant]
```

2) For Admin
```
    rake import:csv_model_import[lib/assets/admins.csv,Admin]
```

### Instructions to run rspec ###

```
    rspec
```

### Docker setup is in progress ###

```
    docker-compose build
    docker-compose run
```