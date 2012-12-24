class Episode < ActiveRecord::Base
  attr_accessible :watched
  belongs_to :season
  
  def series
    season.present? ? season.series : nil
  end
end
