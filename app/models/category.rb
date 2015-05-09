class Category < ActiveRecord::Base

  validates_presence_of :name
  validates_presence_of :reach_count

  def self.search_for(category_name)
    category_name ? where("name like ?", "%#{category_name}%") : all
  end

end
