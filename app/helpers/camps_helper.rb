module CampsHelper
  def get_category_imagename(category)
    case category
      when "Art/Music/Drama"  ; 'arts-music-ent.jpg'
      when "Sports"           ; 'sports.jpg'
      when "Special Needs"    ; 'special-needs.jpg'
      when "Educational"      ; 'educational.jpg'
      when "Religious"        ; 'religions.jpg'
      when "Outdoors"         ; 'outdoors.jpg'
      when "Traditional"      ; 'outdoors.jpg'
      when "Community Service"; 'outdoors.jpg'
      when "Teen Travel"      ; 'teen-travel.jpg'
      else                    ; 'outdoors.jpg'
    end
  end
  
  def get_category_imagename_thumb(category)
    case category
      when "Art/Music/Drama"  ; 'arts-music-ent-thumb.jpg'
      when "Sports"           ; 'sports-thumb.jpg'
      when "Special Needs"    ; 'special-needs-thumb.jpg'
      when "Educational"      ; 'educational-thumb.jpg'
      when "Religious"        ; 'religions-thumb.jpg'
      when "Outdoors"         ; 'outdoors-thumb.jpg'
      when "Traditional"      ; 'outdoors-thumb.jpg'
      when "Community Service"; 'outdoors-thumb.jpg'
      when "Teen Travel"      ; 'teen-travel-thumb.jpg'
      else                    ; 'outdoors-thumb.jpg'
    end
  end
  
  def get_assets(camp_id)
    @assets = Asset.where(:camp_id => camp_id)
  end
  
  def get_asset(camp_id, cat_name, type)
    asset = Asset.where(:camp_id => camp_id).first
    if !asset.blank?
      @url = asset.asset.url(type)
    else
      if type == :large
        @url = "/assets/category/" + get_category_imagename(cat_name)
      else
        @url = "/assets/category/" + get_category_imagename_thumb(cat_name)
      end
    end
  end
  
end
