class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?(record)
    raise Pundit::NotAuthorizedError, "not_allow_update" unless record.active?

    true
  end

  def edit?
    update?
  end

  def destroy?(record)
    raise Pundit::NotAuthorizedError, "not_allow_delete" unless record.active?

    true
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
