class Project < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :client
  belongs_to :category
  has_many :donations

  mount_uploader :image, ImageUploader

  validates :image, presence: true
  validates :title, presence: true, length: { maximum: 64 }
  validates :price, presence: true
  validates :description, presence: true, length: { maximum: 512 }
  validates :end_time, presence: true
  validates :start_time, presence: true
  validates_length_of :price, :in => 1..500

  before_save :time_invalid

  def time_invalid
    if start_time > end_time
      errors.add(:base, 'A data final deve ser maior que data inicial.')
      raise ActiveRecord::Rollback
    end

    if (end_time - start_time).days <= 30
      errors.add(:base, 'A diferença entre as datas não deve ser maior que 30 dias.')
      raise ActiveRecord::Rollback
    end

    if start_time <= Time.current || end_time <= Time.current
      errors.add(:base, 'A data de início e encerramento devem ser maiores que o momento atual.')
      raise ActiveRecord::Rollback
    end
  end

  def donation_total_value
    self.donations.where(status: 'paid').to_a.sum { |donation| donations.price_paid }
  end

  def visibility_valid?
    return true if start_time <= Time.current && end_time >= Time.current
    false
  end
end
