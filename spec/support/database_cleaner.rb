RSpec.configure do |config|

  config.before(:suite) do
    # to clean potentially remaining objects
    DatabaseCleaner.clean_with :truncation

    # By default do transactions-based cleanup
    DatabaseCleaner.strategy = :transaction
  end

  config.around(:each) do |spec|

    if spec.metadata[:js]
      # poltergeist/PhantomJS specs that don't share connections with the spec thread
      #  and therefore can't use transactions

      spec.run
      DatabaseCleaner.clean_with :truncation

    else
      DatabaseCleaner.start
      spec.run
      DatabaseCleaner.clean
      begin
        ActiveRecord::Base.connection.send(:rollback_transaction_records, true)
      rescue
      end
    end
  end
end