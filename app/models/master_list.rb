class MasterList < ApplicationRecord
  belongs_to :user

  enum status: ["Active", "Inactive"]

  def balance_of_share_capital
    (share_capital || 0) - (withdrawal || 0)
  end

  def status_of_share_capital
    if balance_of_share_capital < 2000
      "Balance of #{2000 - balance_of_share_capital}"
    else
      "Paid"
    end
  end

  def status_of_membership_fee
    if membership_fee < 2000
      if membership_fee == 200
        "PAID"
      else
        "Balance of #{2000 - membership_fee}"
      end
    else
      "PAID"
    end
  end

  def status_of_consolidation
    if consolidation == 0
      return ""
    else
      if consolidation < 21000
        return "Balance of #{21000 - consolidation}"
      else
        if consolidation == 21000 
          return "PAID"
        else
          return "Excess of #{consolidation - 21000}"
        end
      end
    end
  end
end
