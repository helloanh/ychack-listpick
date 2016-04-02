class SearchController < ApplicationController

  def search
    query = params[:q]
    list_name = query.split(" ").first
    scope_params = query.split(" ").last
    rscope = Rscope.from_scope_params(scope_params)
    list = List.where({ name: list_name }).first
    redirect_to "/items?list_name=#{list.name}&scope=#{rscope.quantity}:#{rscope.unit}&q=#{list_name}%20#{scope_params}"
  end
end
