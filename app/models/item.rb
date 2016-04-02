class Item < ActiveRecord::Base
  has_many :list_items
  has_many :lists, through: :list_items
  has_many :ratings
  belongs_to :rscope

  validates :name, presence: true

  def self.random
    if (c = count) != 0
      Item.offset(rand(c)).first
    end
  end

  def rating_for_scope(rscope)
    ratings.where({ rscope: rscope }).first_or_create
  end
end
