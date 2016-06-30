class TaskSerializer < BaseSerializer
  attributes :id, :operation, :status

  has_one :user
end