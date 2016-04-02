class Rscope < ActiveRecord::Base

  def self.random
    if (c = count) != 0
      Rscope.offset(rand(c)).first
    end
  end

  def self.from_scope_params(scope_params)
    p_unit = scope_params.split(":").last
    p_quantity = scope_params.split(":").first
    where({
      unit: p_unit, quantity: p_quantity
    }).first
  end

end
