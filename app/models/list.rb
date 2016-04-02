class List < ActiveRecord::Base
  has_many :list_items
  has_many :items, through: :list_items
  belongs_to :user

  before_save :name_to_slug

#   validates :name,
#     presence: true,
#     format: {
#       with: /^[a-zA-Z0-9 \-]+$/
#     }

  def self.random
    if (c = count) != 0
      List.offset(rand(c)).first
    end
  end

  def self.to_slug(name)
    name.downcase.gsub!(" ", "-")
  end

  def self.find_or_create_by_name(name)
    where({ name: name }).
      first_or_create
  end

  def name_to_slug
    slug = self.class.to_slug name
  end
end
