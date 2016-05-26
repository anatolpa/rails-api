class SessionSerializer < BaseSerializer
  attributes :token
  has_one :user
end
