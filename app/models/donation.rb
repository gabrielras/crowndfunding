class Donation < ApplicationRecord
  belongs_to :client
  belongs_to :project
  
  before_create :donation_invalid?

  def donation_invalid?
    if project.end_time < Time.current
      errors.add(:base, 'Não é possível realizar o pagamento, pois o prazo encerrou.')
      raise ActiveRecord::Rollback
    end
  end
end
