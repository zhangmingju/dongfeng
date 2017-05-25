module A
  def self.included(base)
    base.before_save :test
    def test
      puts "self: #{self.inspect}"
      puts "aaaaaaa"
    end
  end
end