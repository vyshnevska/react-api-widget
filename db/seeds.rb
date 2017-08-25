# puts '1. Creating channels'
# 5.times { |i| Channel.create!(name: "channel#{i}", type: 'public', active: true); printf '.' }

# puts '2. Creating messages'
# Channel.all.map do |channel|
#   Message.create!(content: 'Hello here', recipient_id: 1, status: 'sent', channel_id: channel.id)
#   printf '.'
# end

puts '3. Users and friendships'

me   = User.create!(full_name: 'Steven Luscher', email: 'steveluscher@fb.com',
                    username: 'steveluscher', password: '123456')
dhh  = User.create!(full_name: 'David Heinemeier Hansson', email: 'dhh@37signals.com',
                    username: 'dhh', password: '123456')
ezra = User.create!(full_name: 'Ezra Zygmuntowicz', email: 'ezra@merbivore.com',
                    username: 'ezra', password: '123456')
matz = User.create!(full_name: 'Yukihiro Matsumoto', email: 'matz@heroku.com',
                    username: 'matz', password: '123456')

me.friends   << [matz]
dhh.friends  << [ezra, matz]
ezra.friends << [dhh, matz]
matz.friends << [me, ezra, dhh]


Channel.create(type: 'support', name: 'Support', active: true, user: User.last)