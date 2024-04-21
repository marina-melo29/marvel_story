require 'faraday'

module Infra
  module Api 
    class Marvel 
      def self.get_character(name)
        begin
          connection.get "/v1/public/characters?name=#{name}&#{api_key}"
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
        'apikey=2b34747a19f220d038298662f10c5c50'
      end
    end
  end
end
