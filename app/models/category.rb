class Category < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  has_many :projects

  def project_present?
    return true if Category.joins(:projects).where(id: id).distinct.present?
    false
  end
end
