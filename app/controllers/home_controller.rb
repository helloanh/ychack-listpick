class HomeController < ApplicationController

  def index
    @items = Item.all
  end

  def privacy
  end

  def tos
  end

end
