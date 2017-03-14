puts '1. Creating channels'
5.times { |i| Channel.create!(name: "channel#{i}", type: 'public', active: true); printf '.' }

puts '2. Creating messages'
Channel.all.map do |channel|
  Message.create!(content: 'Hello here', recipient_id: 1, status: 'sent', channel_id: channel.id)
  printf '.'
end