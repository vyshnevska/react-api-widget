Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'The root of all queries'

  field :user do
    type Types::UserType
    description 'The user associated with a given ID'
    argument :id, !types.ID
    resolve -> (obj, args, ctx) { User.find(args[:id]) }
  end
end