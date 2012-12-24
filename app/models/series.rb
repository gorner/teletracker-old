require "net/http"
class Series < ActiveRecord::Base
  attr_accessible :sid, :category_id, :description, :rating, :title
  belongs_to :category
  has_many :seasons
  has_many :episodes, :through => :seasons
  before_save :update_episodes
  
  ### CLASS METHODS
  
  def self.find_or_new_from_sid(sid, attrs={})
    if (series = Series.find_by_sid(sid.to_i)) != nil
      return series
    end
    
    series = self.new(attrs)
    response = self.get_from_tvrage("showinfo", {"sid" => sid})
    if response.present? and response.has_key?("Showinfo")
      show_info = response["Showinfo"]
      
      series.sid = show_info["showid"] if show_info.has_key?("showid")
      series.title = show_info["showname"] if show_info.has_key?("showname")
      series.category = Category.find_or_initialize_by_name(show_info["classification"]) if show_info.has_key?("classification")
    end
    series
  end
  
  def self.external_search(query=nil)
    return [] if query.blank?
    
    response_data = self.get_from_tvrage("search", {"show" => query})
    if response_data.present? and response_data.has_key?("Results") \
                              and response_data["Results"].has_key?("show")
      response_data["Results"]["show"]
    else
      []
    end
  end
  
  protected
  
  ### CLASS METHODS
  
  def self.get_from_tvrage(call, args={})
    base_url = "http://services.tvrage.com/feeds/"
    args_query = args.to_query
    url = base_url + call.to_s + ".php?" + args_query
    uri_object = URI.parse(url)
    
    response = nil
    begin
      Timeout::timeout(10) do
        response = Net::HTTP.get_response(uri_object)
      end
    rescue => ex
      logger.info ex.to_s
    end
    
    response.present? ? Hash.from_xml(response.body) : {}
  end
  
  ### INSTANCE METHODS
  def update_episodes
    response = self.class.get_from_tvrage("episode_list", {"sid" => sid})
    if response.present? and response.has_key?("Show") \
                          and response["Show"].has_key?("Episodelist")
      seasons_data = response["Show"]["Episodelist"]["Season"]
      
      seasons_data.each do |season_data|
        season = self.seasons.find_or_initialize_by_number(season_data["no"])
        
        episodes_data = season_data["episode"]
        episodes_data.each do |episode_data|
          episode = season.episodes.find_or_initialize_by_number(episode_data["seasonnum"].to_i)
          episode.title = episode_data["title"]
        end
      end
    end
  end
end
