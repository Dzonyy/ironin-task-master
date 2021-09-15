class Serializer
  attr_accessor :object

  @@attributes = Hash.new { |v,k| v[k] = {} }

  def initialize(object)
    @object = object
  end

  def serialize
    @@attributes[self.class.name].transform_values do |block|
      instance_eval(&block)
    end
  end

  def self.attribute(name, &block)
    @@attributes[self.name][name] = block || proc { object.send(name) }
  end
end
