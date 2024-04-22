require 'faraday'
require 'json'

module Api 
  class Marvel
    TS = 1

    def get_character(name)
      begin
        conn = connection.get "/v1/public/characters?ts=#{TS}&name=#{name}&apikey=#{api_key}&hash=#{hash_key}"
        
        response_parse(conn.body)[:data][:results].first        
      rescue Faraday::ConnectionFailed => e
        puts "Error: #{e}"
      end        
    end

    def get_story(name)
      begin
        character_id = get_character(name)[:id]
        conn = connection.get story_path(character_id)
        response = response_parse(conn.body)

        { data: response[:data][:results], author: response[:attributionText] }
      rescue Faraday::ConnectionFailed => e
        puts "Error: #{e}"
      end        
    end

    private

    def connection
      Faraday.new(url: 'https://gateway.marvel.com:443') do |faraday|
        faraday.adapter Faraday.default_adapter
      end
    end

    def api_key
      ENV['api_key']
    end

    def hash_key
      Digest::MD5.hexdigest "#{TS}#{private_key}#{api_key}"
    end

    def private_key
      ENV['private_key']
    end
    
    def response_parse(response)
      JSON.parse(response).deep_symbolize_keys
    end

    def story_path(character_id)
      "/v1/public/characters/#{character_id}/stories?ts=#{TS}&series=2258&apikey=#{api_key}&hash=#{hash_key}"
    end
  end
end

