class ComputrabajoFixture
  def self.publication
    publication = Computrabajo::Publication.new

    publication.body[:Title]            = "Publicacion de prueba"                   # required
    publication.body[:Description]      = "Descripcion de la publicacion de prueba" # required
    publication.body[:Category]         = "16"                                      # required
    publication.body[:Country]          = "34"                                      # required
    publication.body[:Location]         = "11"                                      # required
    publication.body[:City]             = "231"                                     # required
    publication.body[:EmploymenType]    = "1"                                       # required
    publication.body[:ContractType]     = "1"                                       # required
    publication.body[:Salary]           = "500000"                                  # required
    publication.body[:LevelStudy]       = "2"                                       # required
    publication.body[:Skills]           = ["1", "3"]                                # optional
    publication.body[:LanguagesAndLevels] = [{
        "Language": "47", 
        "Level": "5"
        }]                                                                          # optional
    publication.body[:DrivingLicense]   = ["1"]                                     # optional
    publication.body[:DontShowSalary]   = true                                      # optional
    publication.body[:Experience]       = "2"                                       # required
    publication.body[:Startdate]        = "2016/11/23"                              # optional
    publication.body[:Vacancies]        = "2"                                       # required
    publication.body[:AgeMin]           = "24"                                      # optional
    publication.body[:AgeMax]           = "40"                                      # optional
    publication.body[:TravelAvailability] = false                                   # required
    publication.body[:ResidenceChangeAvailability] = false                          # required
    publication.body[:Disability]       = false                                     # required
    publication.body[:HiddenCompany]    = true                                      # optional
    publication.body[:HiddenCompanyName] = "Importante empresa del sector"          # dependent

    return publication
  end
end