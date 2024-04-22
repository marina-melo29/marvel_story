class HomeController < ApplicationController
  STORY_ID = 15384

  def index
    @story_data = story[:data].find { |item| item[:id] == STORY_ID }
    @characters_urls = Builders::CharactersImageUrl.new(@story_data[:characters][:items]).build
    @attribution_text = story[:author]
  end

  private 

  def story
    @story ||= Api::Marvel.new.get_story('Storm')
  end
end
