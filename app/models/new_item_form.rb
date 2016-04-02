require 'active_support/core_ext/module/delegation'

class NewItemForm
  extend  ActiveModel::Naming
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks
  include ActiveModel::ForbiddenAttributesProtection

  attr_accessor :description, :img_url, :list_name, :name,
    :rscope_quantity, :rscope_unit

  attr_writer :item_source, :list_item_source, :list_source,
    :rscope_source

  attr_reader :saved

  delegate :description, :img_url, :name,
    :description=, :img_url=, :name=,
    to: :item

  validates :name, presence: true

  validates :list_name,
    presence: true,
    format: { with: /[a-zA-Z0-9 \-]+/ }

  validates :rscope_unit, presence: true
  validates :rscope_quantity, presence: true

  def self.model_name
    ActiveModel::Name.new(Item)
  end

  def attributes
    {
      description: description, img_url: img_url, name: name,
      list_name: list_name, rscope_unit: rscope_unit,
      rscope_quantity: rscope_quantity
    }
  end

  def attributes=(attrs)
    sanitize_for_mass_assignment(attrs).each { |k,v| send("#{k}=", v) }
  end

  def item
    @item ||= item_source.call
  end

  def list
    @list ||= List.find_or_create_by_name(list_name)
  end

  def list_item
    @list_item ||= list_item_source.call({
      item: item, list: list
    })
  end

  def new_record?
    !saved
  end

  def persisted?
    false
  end

  def rscope
    @rscope ||= Rscope.where({
      quantity: rscope_quantity, unit: rscope_unit
    }).first_or_create
  end

  def save!
    item.rscope = rscope
    @saved =
      rscope.save! && list.save! && item.save! && list_item.save!
  end

  private

  def item_source
    Item.public_method(:new)
  end

  def list_source
    List.public_method(:new)
  end

  def list_item_source
    ListItem.public_method(:new)
  end

  def rscope_source
    Rscope.public_method(:new)
  end

end
