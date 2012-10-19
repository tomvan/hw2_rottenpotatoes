class Movie < ActiveRecord::Base
  def self.all_ratings
  ratings=[]
  self.find(:all,:select => 'DISTINCT rating').each do |movie|
  ratings << movie.rating
  end
  return ratings
  end
end
