class RatingBuilder
  attr_reader :items, :list, :pick, :rscope

  def initialize
    @list = pick_a_random_list
    @items = pick_some_items
    @pick = Pick.new({ list: list })
  end

  def pick_a_random_item(list, rscope)
    list.items.where({ rscope: rscope }).random
  end

  def pick_a_random_list
    List.random
  end

  def pick_a_random_scope
    Rscope.random
  end

  def pick_some_items
    until list.items.where({rscope: rscope}).count > 2
      redo_random_picks(list, rscope)
    end
    item1 = pick_a_random_item(list, rscope)
    item2 = pick_a_random_item(list, rscope)
    until item1 != item2
      item2 = pick_a_random_item(list, rscope)
    end
    [item1, item2]
  end

  def redo_random_picks(list, rscope)
    @rscope = pick_a_random_scope
    @list = pick_a_random_list
  end
end
