class Rating < ActiveRecord::Base
  belongs_to :item
  belongs_to :rscope
  belongs_to :list

  before_create :set_score

  DEFAULT_SCORE = 1400

  def self.find_or_create_new
    first_or_create
  end

  def set_score
    self.score = DEFAULT_SCORE
  end

  def win_against(other_rating)
    self.score += 100
    other_rating.score -= 90
    save && other_rating.save
  end

  def lost_to(other_rating)
    self.score -= 90
    other_rating.score += 100
    save && other_rating.save
  end
end
