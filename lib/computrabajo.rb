require 'computrabajo/version'
require 'rails'
require 'time'
require 'httparty'
require 'erb'

module Computrabajo
  include HTTParty
  base_uri 'https://api-ats.computrabajo.com'

  # API login configuration, need initialization setup to work
  mattr_accessor :username
  @@username          = nil

  mattr_accessor :password
  @@password          = nil

  mattr_accessor :contact_name
  @@contact_name      = nil

  mattr_accessor :contact_email
  @@contact_email     = nil

  mattr_accessor :contact_telephone
  @@contact_telephone = nil

  mattr_accessor :contact_url
  @@contact_url       = nil

  mattr_accessor :job_reference
  @@job_reference     = nil

  mattr_accessor :options
  @@options = nil

  mattr_accessor :last_request
  mattr_accessor :last_response
  @@last_request = nil
  @@last_response = nil

  # Default way to setup Computrabajo.
  def self.setup
    yield self
  end

  def self.environment(use_environment="production")
    if use_environment == "production"
      Computrabajo.base_uri('https://api-ats.computrabajo.com')
    elsif use_environment == "development"
      Computrabajo.base_uri('https://iapi-ats.computrabajo.com')
    else
      Computrabajo.base_uri('https://iapi-ats.computrabajo.com')
    end
  end

  def self.initialize
    @@options = {
      username: @@username,
      password: @@password, 
      contact_name: @@contact_name,
      contact_email: @@contact_email,
      contact_telephone: @@contact_telephone,
      contact_url: @@contact_url,
      job_reference: @@job_reference
    }
  end

  # Aliases

  # alias
  def self.create_aviso(json)
    Computrabajo.create_publication(json)
  end

  # alias
  def self.get_aviso(json)
    Computrabajo.get_publication(json)
  end

  # alias
  def self.get_postulaciones_en_aviso(json)
    Computrabajo.get_postulations_in_publication(json)
  end

  # alias
  def self.destroy_aviso(json)
    Computrabajo.destroy_publication(json)
  end

  # Methods

  def self.create_publication(json)
    Computrabajo.initialize
    create_publication_path = '/public/v1/integration/4Talent/add'
    
    body = @@options.merge(json).to_json
    response = self.post(create_publication_path, {body: body, headers: { "Accept" => "application/json", "Content-Type" => "application/json"}})

    if Parser.parse_response(response)
      case response.code
        when 200
          # "Publication created, All good!"
          return response # body contains id del proceso publicado
      end
    end
  end

  def self.get_publication(json)
    Computrabajo.initialize
    get_publication_path = '/public/v1/integration/4Talent/get'
    body = @@options.merge(json).to_json
    response = self.post(get_publication_path, {body: body, headers: { "Accept" => "application/json", "Content-Type" => "application/json"}})

    if Parser.parse_response(response)
      case response.code
        when 200
          # "Publication obtained, All good!"
          return response
      end
    end
  end

  def self.get_postulations_in_publication(json)
    Computrabajo.initialize
    get_postulations_in_publication_path = '/public/v1/integration/4Talent/applies'
    body = @@options.merge(json).to_json
    response = self.post(get_postulations_in_publication_path, {body: body, headers: { "Accept" => "application/json", "Content-Type" => "application/json"}})

    if Parser.parse_response(response)
      case response.code
        when 200
          # "Postulants obtained, All good!"
          return response
      end
    end
  end

  def self.destroy_publication(json)
    Computrabajo.initialize
    destroy_publication_path = '/public/v1/integration/4Talent/delete'
    body = @@options.merge(json).to_json
    response = self.post(destroy_publication_path, {body: body, headers: { "Accept" => "application/json", "Content-Type" => "application/json", "X-HTTP-Method-Override" => "DELETE"}})

    if Parser.parse_response(response)
      case response.code
        when 200
          # "Publication deleted, All good!"
          return response
      end
    end
  end
  
  class Parser
    def self.parse_json_to_hash(json, hash)
      json.each{|object| hash[object["id"]] ? hash[object["id"]].merge!(object) : hash[object["id"]] = object}
      return hash
    end

    def self.parse_response(response)
      Computrabajo.last_response = response
      Computrabajo.last_request = response.request
      case response.code
        when 200..201
          # "All good!"
          return response.body
        when 401
          raise "Error 401: Unauthorized. Check login info.\n #{response.body}"
        when 403
          raise "Error 403: Forbidden"
        when 404
          raise "Error 404 not found"
        when 500...600
          raise "ZOMG ERROR #{response.code}: #{response.request.path}, #{response.body}"
        else
          raise "Error #{response.code}, unkown response: #{response.request.path}, #{response.body}"
      end
    end
    def self.parse_response_to_json(response)
      Computrabajo.last_response = response
      Computrabajo.last_request = response.request
      case response.code
        when 200..201
          # "All good!"
          return JSON.parse(response.body)
        when 401
          raise "Error 401: Unauthorized. Check login info.\n #{response.body}"
        when 403
          raise "Error 403: Forbidden"
        when 404
          raise "Error 404 not found"
        when 500...600
          raise "ZOMG ERROR #{response.code}: #{response.request.path}, #{response.body}"
        else
          raise "Error #{response.code}, unkown response: #{response.request.path}, #{response.body}"
      end
    end
  end
end

require 'computrabajo/publication'