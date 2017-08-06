if Rails.env.test?
  class Capybara::Session
    def evaluate_multiline_script javascript
      evaluate_script "(function(){ #{javascript} })()"
    end
  end
end