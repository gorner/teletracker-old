class Episode < ActiveRecord::Base
  attr_accessible :description, :number, :rating, :season_id, :title
end
