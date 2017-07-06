Types::UserType = GraphQL::ObjectType.define do
  name 'User'

  description 'a user'

  field :id, !types.ID
  field :username, types.String, property: :username
  field :fullName, types.String, property: :full_name
  field :email, !types.String, 'Like a phone number, but spammier', property: :email
  field :friends, -> { types[Types::UserType] }, 'Some people to lean on'
end
