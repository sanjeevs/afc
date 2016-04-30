module MyAppError

class MyAssertError < StandardError
  attr_reader :data

  def initialize(data)
    super(data)
    @data = data
  end

end

class PoductAmountError < MyAssertError
  def message
    "Product amount cannot be negative"
  end
end

end
