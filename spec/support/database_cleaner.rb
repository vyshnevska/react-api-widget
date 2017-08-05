RSpec.configure do |config|

  config.before(:suite) do
    # Do truncation once per suite to clean potentially remaining stuff (e.g. from interrupted tests) from the DB on starting the test suite
    DatabaseCleaner.clean_with :truncation

    # By default do transactions-based cleanup
    DatabaseCleaner.strategy = :transaction
  end

  config.around(:each) do |spec|

    if spec.metadata[:js] || spec.metadata[:test_commit_callbacks]
      # use case 1) ":js"  poltergeist/PhantomJS specs that don't share connections with the spec thread and therefore can't use transactions
      # use case 2) ":test_commit_callbacks"  for tests that rely on after_commit callbacks to run

      # using deletion strategy, because it is often faster than truncation on Postgres - doesn't vacuum
      # no need to 'start', clean_with is sufficient for deletion
      spec.run
      DatabaseCleaner.clean_with :truncation

    else
      DatabaseCleaner.start
      spec.run
      DatabaseCleaner.clean

      # see https://github.com/bmabey/database_cleaner/issues/99
      begin
        ActiveRecord::Base.connection.send(:rollback_transaction_records, true)
      rescue
      end
    end
  end
end