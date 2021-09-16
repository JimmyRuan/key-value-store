class MemoryKeyValueStore
  def initialize(values)
    @values = values
  end

  def get(key)
    @values[key]
  end

  def set(key, value)
    unless value.is_a? String
      raise "The value has to be string"
    end
    @values[key] = value
    'OK'
  end

  def keys(pattern=nil)
    unless pattern
      return @values.keys
    end
    @values.keys.select{|key| key.to_s[/#{pattern}/]}
  end
end
