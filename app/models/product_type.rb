include ActionView::Helpers::NumberHelper

class ProductType < ActiveRecord::Base
  
  def memory
    unless self[:memory].blank?
      self[:memory].to_s + " GiB"
    else
      "0 GiB"
     end
  end

  def cost
    unless self[:cost_per_month].blank?
      "$" + number_with_precision(self[:cost_per_month], precision: 2).to_s + " per Month"
    else
      "$ 0 per Month"
    end
  end
end
