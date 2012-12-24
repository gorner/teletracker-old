class Season < ActiveRecord::Base
  attr_accessible :number, :series_id
  belongs_to :series
  has_many :episodes
end
