require 'httparty'
require 'json'
require 'active_support/core_ext/hash/keys'

MORTY_API_URL = 'https://rickandmortyapi.com/api'
rick_and_morty_api_response = HTTParty.get(MORTY_API_URL)
rick_and_morty_api_response.deep_symbolize_keys!

if rick_and_morty_api_response.code.eql?(200)
  episodes_response = HTTParty.get(rick_and_morty_api_response[:episodes])
  episodes_response.deep_symbolize_keys!

  if episodes_response.code.eql?(200)
    episodes_response[:results].map! do |episode|
      episode.deep_symbolize_keys[:characters].map! do |character|
        character_response = HTTParty.get(character)
        character_response.code.eql?(200) ? character_response.parsed_response : character_response
      end
    end
  end

  puts JSON.pretty_generate(episodes_response[:results])
end
