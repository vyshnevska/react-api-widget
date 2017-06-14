Types::UserType = GraphQL::ObjectType.define do
  name 'User'

  description 'a user'

  field :id, !types.ID
  field :username, !types.String, property: :username
  field :email, !types.String, 'Like a phone number, but spammier', property: :email
end
