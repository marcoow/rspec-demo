module Matchers

  class RequireAttributeMatcher

    def initialize(attribute)
      @attribute = attribute
    end

    def matches?(model)
      @model = model
      model.send("#{@attribute.to_s}=".to_sym, nil)
      return !model.valid? && !model.errors.on(@attribute.to_sym).nil?
    end

    def failure_message
      "expected #{@target.inspect} to require attribute #{@attribute}"
    end

    def negative_failure_message
      "expected #{@target.inspect} not to require attribute #{@attribute}"
    end

  end

  def require_attribute(attribute)
    RequireAttributeMatcher.new(attribute)
  end

end
