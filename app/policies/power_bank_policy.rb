# class PowerBankPolicy < ApplicationPolicy
#   def index?
#     true  # Example: Allow all users to view index
#   end
#
#   def create?
#     user.admin?
#   end
#
#   def update?
#     user.admin?
#   end
#
#   def destroy?
#     user.admin?
#   end
#
#   def show?
#     user.admin? || user.normal?
#   end
#
#   def index?
#     user.admin? || user.normal?
#   end
#
#   private
#
#   def user
#     record.user
#   end
# end
class PowerBankPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true  # Example: Allow anyone to list PowerBanks
  end

  def show?
    true  # Example: Allow anyone to view a PowerBank
  end

  # Define other methods like create?, update?, destroy? as needed

  private

  def user_can_access_power_bank?
    # Logic to check if the user can access a specific power bank
    # Example: record.user == user || user.admin?
    # Note: `record` here should be an instance of PowerBank
  end
end