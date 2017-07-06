###################
### Example:
## Al Users
# {
#  allUsers {
#     username
#     fullName
#     email
#     friends
#     {
#       username
#       fullName
#       email
#       friends{
#         username
#         fullName
#         email
#       }
#     }
#   }
# }
## Single user
# {
#  user(id: 1) {
#     id
#     username
#     fullName
#     email
#     friends
#     {
#       id
#       username
#       fullName
#       email
#     }
#   }
# }
###################

Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'The root of all queries'

  field :allUsers do
    type types[Types::UserType]
    description 'Everyone'
    resolve -> (obj, args, ctx) { User.all }
  end

  field :user do
    type Types::UserType
    description 'The user associated with a given ID'
    argument :id, !types.ID
    resolve -> (obj, args, ctx) { User.find(args[:id]) }
  end
end