class PicksController < ApplicationController

  def index
    if @pick = Pick.create(pick_params)
      list = List.find(params[:list_id])
      winner = Item.find(params[:winner_id])
      loser = Item.find(params[:loser_id])
      rscope = winner.rscope
      winner_rating = Rating.where({ rscope: rscope, list: list, item: winner}).find_or_create_new
      loser_rating = Rating.where({ rscope: rscope, list: list, item: loser }).find_or_create_new
      winner_rating.win_against(loser_rating)
    end
    redirect_to '/picks/new'
  end

  def new
    new_r = new_rating
    @pick = new_r.pick
    @items = new_r.items
    @rscope = new_r.rscope
    @list = new_r.list
  end

  private

  def new_rating
    RatingBuilder.new
  end

  def pick_params
    params.permit(:winner_id, :loser_id, :list_id)
  end

end
