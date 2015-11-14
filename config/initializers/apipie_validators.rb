class MinMaxValidator < Apipie::Validator::BaseValidator

  def initialize(param_description, argument, min, max)
    super(param_description)
    @max = max
    @min = min
  end

  def validate(value)
    puts @max
    puts @min
    return false if value.nil?
    @max = value if @max.nil?
    @min = value if @min.nil?
    value.to_i <= @max and value.to_i >= @min
  end

  def self.build(param_description, argument, options, block)
    unless options[:max].nil? or options[:min].nil?
      self.new(param_description, argument, options[:min], options[:max])
    end
  end

  def description
    "Must be at max #{@max}, and at min #{@min}."
  end
end
