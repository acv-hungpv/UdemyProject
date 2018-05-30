class Product < ApplicationRecord
  extend Enumerize
  enumerize :level, in: { easy: 1, medium: 2, hard: 3 }
  
  validates :title, :description, presence: true
  validate :title_is_shorter_than_description
  validates :price, presence: true, numericality: { greater_than: 0 }
  
  belongs_to :category, optional: true
  
  before_save :strip_html_from_description
  before_save :set_title_to_lower_case
  
  scope :published, -> { where(published: true) }
  scope :priced_more_than, ->(price) { where('price > ?', price) }

  def title_is_shorter_than_description
    return if title.blank? or description.blank?
    if description.length < title.length
      errors.add(:description, 'can\'t be shorter than title')
    end
  end
  
  def strip_html_from_description
    self.description = ActionView::Base.full_sanitizer.sanitize(self.description)
  end
 
  def set_title_to_lower_case
    self.title = self.title.downcase
  end
end