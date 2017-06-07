PersonType = GraphQL::ObjectType.define do
  name 'Person'
  description 'Somebody to lean on'
  field :id, !types.ID
  field :username, !types.String, property: :username
  field :email, !types.String, 'Like a phone number, but spammier'
end

QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'The root of all queries'

  field :person do
    type PersonType
    description 'The person associated with a given ID'
    argument :id, !types.ID
    resolve -> (obj, args, ctx) { User.find(args[:id]) }
  end
end

Schema = GraphQL::Schema.new(
  query: QueryType,
)