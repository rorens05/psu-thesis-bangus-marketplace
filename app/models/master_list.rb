class MasterList < ApplicationRecord
  belongs_to :user

  enum status: ["Active", "Inactive"]
end
