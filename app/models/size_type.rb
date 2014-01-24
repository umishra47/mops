include ActionView::Helpers::NumberHelper

class SizeType < ActiveRecord::Base

  def memory
    unless self[:memory].blank?
      if self[:memory].to_s == "512.0"
        self[:memory].to_s + " MB"
      else
        self[:memory].to_s + " GiB"
      end
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
