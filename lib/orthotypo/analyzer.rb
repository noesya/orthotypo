module Orthotypo
  class Analyzer

    def self.url?(string)
      uri = URI.parse(string)
      uri.class != URI::Generic
    rescue URI::InvalidURIError
      false
    end

    def self.email?(string)
      string =~ /\A#{URI::MailTo::EMAIL_REGEXP}\z/ ? true : false
    end

    def self.precious?(string)
      email?(string) || url?(string)
    end

  end
end