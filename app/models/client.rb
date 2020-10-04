class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :cpf_number, presence: true, uniqueness: true
  
  has_many :projects
  has_many :donations
  has_one :profile

  before_save :cpf_valid?

  def cpf_valid?
    unless CPF.valid?(cpf_number)
      errors.add(:base, 'O número do CPF está incorreto.')
      raise ActiveRecord::Rollback
      return
    end
  end

end
