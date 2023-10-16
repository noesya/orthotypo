module Orthotypo
  class Analyzer

    def self.url?(string)
      (string =~ /\A#{URI::DEFAULT_PARSER.regexp[:ABS_URI]}\z/) && 
      (string =~ /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix) ? true : false
    end
  
    def self.email?(string)
      string =~ /\A#{URI::MailTo::EMAIL_REGEXP}\z/ ? true : false
    end

    def self.precious?(string)
      email?(string) || url?(string)
    end
    
  end
end