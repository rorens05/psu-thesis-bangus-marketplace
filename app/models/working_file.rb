class WorkingFile < ApplicationRecord
  belongs_to :master_list

  enum particular: [:membership_fee, :capital_share, :withdrawal, :consolidation]
  enum member: [:associate, :regular]
  
  validates :master_list, presence: true
  validates :or_no, presence: true, uniqueness: {case_sensitive: true}
  validates :or_date, presence: true
  validates :particular, presence: true
  validates :amount, presence: true

end
