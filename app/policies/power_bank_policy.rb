class PowerBankPolicy < ApplicationPolicy
  # Scope class definition remains the same as above

  def index?
    true  # Example: Allow anyone to list PowerBanks
  end

  def show?
    true  # Example: Allow anyone to view a PowerBank
  end

  def create?
    user.admin?  # Example: Only admins can create new PowerBanks
  end

  def update?
    user.admin? || record.user == user ||user.role=="normal"
  end
   def edit?
    user.admin? ||user.role=="normal"
  end
  def destroy?
    user.admin? || record.user == user  # Example: Admins or owners can delete
  end

  private

  def user_can_access_power_bank?
    record.user == user || user.admin?
  end
end
