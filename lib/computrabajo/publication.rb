module Computrabajo
  class Publication
    attr_accessor :body
  
    def initialize
      self.body = default_publication_json()
    end
  
    private
    def default_publication_json
      return {
        Title: "",                          # required
        Description: "",                    # required
        Category: 0,                        # required
        Country: 0,                         # required
        Location: 0,                        # required
        City: 0,                            # required
        EmploymentType: 0,                  # required
        ContractType: 0,                    # required
        Salary: 0,                          # required
        LevelStudy: 0,                      # required
        Skills: [""],                       # optional
        LanguagesAndLevels: [{
          Language: "", Level: ""
          }],                               # optional
        DrivingLicense: [""],               # optional
        DontShowSalary: false,              # optional
        Experience: "",                     # required
        Startdate: "",                      # optional
        Vacancies: "",                      # required
        AgeMin: "",                         # optional
        AgeMax: "",                         # optional
        TravelAvailability: false,          # required
        ResidenceChangeAvailability: false, # required
        Disability: false,                  # required
        HiddenCompany: false,               # optional
        HiddenCompanyName: ""               # dependent
      }
    end
  end
end