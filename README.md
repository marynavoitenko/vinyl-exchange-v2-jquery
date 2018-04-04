# VINYL EXCHANGE

## About
This app is a vinyl exchange platform. Add your vinyls for sale and every other user will be able to buy them. Or buy the vinyls that someone else has posted.

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

## Prerequisites
What things you need to install the application

Make sure Ruby is installed

```
ruby -v
```

Make sure Rails is installed

```
rails -v
```

## Installing:
A step by step guide how to get a development env running

Clone this repo

```
git clone https://github.com/marynavoitenko/vinyl-exchange.git
```

Install all dependencies

```
bundle install
```

Create db and migrate schema

```
rake db:create
rake db:migrate
```

Now run the application

```
rails s
```

### Facebook Login
To make it work on localhost, you need to generate a self-signed SSL certificate

Make sure you're inside the app directory (or move the files there later)

```
openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 365 -keyout localhost.key -out localhost.crt
```

This will create localhost.key and localhost.crt files.

To run rails server using a generated self-signed SSL certificate

```
rails s -b 'ssl://localhost:3000?key=localhost.key&cert=localhost.crt'
```

Thanks to the great resource about [self-signed SSL certificate on localhost](https://github.com/marynavoitenko/vinyl-exchange) from Matt DuBois

## CONTRIBUTING
Bug reports and pull requests are welcome on GitHub at https://github.com/marynavoitenko/vinyl-exchange. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## LICENSE

[The MIT License (MIT)](https://github.com/marynavoitenko/vinyl-exchange/blob/master/LICENSE.md)
