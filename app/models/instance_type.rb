include ActionView::Helpers::NumberHelper

class InstanceType < ActiveRecord::Base

  def memory
    unless self[:memory].blank?
      self[:memory].to_s + " GiB"
    else
      "0 GiB"
     end
  end

  def cost_type
    unless self[:cost].blank?
      "$" + number_with_precision(self[:cost], precision: 3).to_s + " per Month"
    else
      "$ 0 per Month"
    end
  end
end
