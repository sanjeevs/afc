module MyAppError

class MyAssertError < StandardError
  attr_reader :data

  def initialize(data)
    super(data)
    @data = data
  end

end

class ProductAmountError < MyAssertError
  def initialize
    super('Product amount business constraint violated')
  end

  def message
    "Product amount cannot be negative"
  end
end

end
