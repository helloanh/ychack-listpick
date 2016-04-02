class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy]

  expose(:new_item_form, attributes: :item_params)

  def create
    creator.call new_item_form
  end

  def on_create_succeeded(success)
    item = success.item
    list = success.list
    rscope = success.rscope
    respond_to do |format|
      format.html {
        redirect_to "/items?list_name=#{list.name}&scope=#{rscope.quantity}:#{rscope.unit}",
        notice: 'Item was successfully created.'
      }
      format.json { render :show, status: :created, location: item }
    end
  end

  def on_create_failed(failure)
    self.new_item_form = failure
    respond_to do |format|
      format.html { render :new }
      format.json { render json: new_item_form.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def index
    if params[:list_name]
      rscope = Rscope.from_scope_params(params[:scope])
      list = List.where({ name: params[:list_name]}).first
      items = list.items.
        where({ rscope_id: rscope.id }).to_a
      @items = items.sort! { |a, b|  a.rating_for_scope(rscope).score <=> b.rating_for_scope(rscope).score }
    else
      @items = Item.all
    end
  end

  def new
    @item = NewItemForm.new
    @rscope_units = ["$", "HRS", "PER"]
  end

  def show
  end


  private

  def creator
    creator_source.call self
  end

  def creator_source
    CreateNewItem.public_method(:new)
  end

  def item_params
    params.require(:item).permit(
      :name, :img_url, :description,
      :list_name, :rscope_unit, :rscope_quantity
    )
  end

  def set_item
    @item = Item.find(params[:id])
  end

end

