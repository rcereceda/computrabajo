# Computrabajo

This gem was made to connect to the Computrabajo api: https://iapi.computrabajo.com

## Getting started

Computrabajo works with Rails 3.2 onwards. You can add it to your Gemfile with:

```ruby
gem 'computrabajo', :git => 'git@github.com:rcereceda/computrabajo.git'
```

...or can fetch the latest developer version with:

```ruby
gem 'computrabajo', :git => 'git@github.com:rcereceda/computrabajo.git', :branch => 'develop'
```

### Configuration

After you finished the gem installation, you need to configure it with your Computrabajo user information. You can do it filling a file like config/initializers/computrabajo.rb with:

```ruby
Computrabajo.setup do |config|
  config.username          = ""   # username provided by Computrabajo
  config.password          = ""   # password provided by Computrabajo
  config.contact_name      = ""   # your contact name
  config.contact_email     = ""   # your contact email (if not empty, will be shown on the offer detail for registered candidates)
  config.contact_telephone = ""   # your phone number
  config.contact_url       = ""   # your company URL
  config.job_reference     = ""   # your internal offer reference
  config.environment "production" # You can choose between production or development
end
```

## How to use

All return a json object, and raise an error (401, 403, 500) if there was one.

On success there is a "status" field on response with the following values:

- Pendiente = 1
- Activa = 2
- Caducada = 3
- Eliminada = 4
- Rechazada = 5
- Archivada = 6

### Create (publish) a new publication

```ruby
publication = Computrabajo::Publication.new
Computrabajo.create_aviso(publication.body)
```

### Get a publication data

```ruby
Computrabajo.get_aviso(publication_id)
```

### Destroy a publication

```ruby
publication = { offerId: publication_id }
Computrabajo.destroy_aviso(publication)
```

## TODO

- Add the missing methods to obtain the list of postulants
