class MasterList < ApplicationRecord
  belongs_to :user
  has_many :working_files

  validates :user, uniqueness: true
  

  enum status: ["Active", "Inactive"]

  def name
    user.name
  end

  def paid_share_capital
    working_files.where(particular: "capital_share").sum(:amount)
  end

  def withdrawal_of_sc
    working_files.where(particular: "withdrawal").sum(:amount)
  end

  def paid_membership_fee
    working_files.where(particular: "membership_fee").sum(:amount)
  end

  def membership 
    return "associate" if paid_membership_fee < 2000
    return "regular"
  end

  def paid_consolidation
    working_files.where(particular: "consolidation").sum(:amount)
  end

  def balance_of_share_capital
    (paid_share_capital || 0) - (withdrawal_of_sc || 0)
  end

  def status_of_share_capital
    if balance_of_share_capital < 2000
      "Balance of #{2000 - balance_of_share_capital}"
    else
      "PAID"
    end
  end

  def status_of_membership_fee
    if paid_membership_fee < 2000
      if paid_membership_fee == 200
        "PAID"
      else
        "Balance of #{2000 - paid_membership_fee}"
      end
    else
      "PAID"
    end
  end

  def status_of_consolidation
    if paid_consolidation == 0
      return ""
    else
      if paid_consolidation < 21000
        return "Balance of #{21000 - paid_consolidation}"
      else
        if paid_consolidation == 21000 
          return "PAID"
        else
          return "Excess of #{paid_consolidation - 21000}"
        end
      end
    end
  end
end
