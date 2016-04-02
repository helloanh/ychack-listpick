class ListsController < ApplicationController

  def show
    list = List.find(params[:id])
    redirect_to "/items?list_name=#{list.name}"
  end

end
