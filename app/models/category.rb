class Category < ActiveRecord::Base

  validates :name, presence: true, length: { in: 3..20 }
  validates :reach_count, presence: true, numericality: true

  def self.search_for(category_name)
    category_name ? where("name like ?", "%#{category_name.strip}%") : all
  end

end
