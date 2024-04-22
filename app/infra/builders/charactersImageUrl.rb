module Builders 
  class CharactersImageUrl
    def initialize(characters)
      @characters = characters
    end

    def build
      characters.map do |character|
        build_hash(character[:name])
      end
    end    

    attr_reader :characters

    private

    def build_hash(character_name)
      {
        name: character_name,
        url: character_url(character_name)
      }
    end
    
    def character_url(name)
      character = Api::Marvel.new.get_character(name)

      "#{character[:thumbnail][:path]}.jpg"
    end
  end
end