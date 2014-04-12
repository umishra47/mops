module ProductsHelper
  def product_image(product)
    image_path = case product
    when "vT6Basic"
      "Vtiger-logo.png"
    when "Sugar6516"
      "logo_sugarcrm.png"
    when "RailsImage"
      "rails.png"
    end
    image_tag image_path, class: 'img-responsive', style: 'text-align:center'
  end
end
