module Base62
  SIXTYTWO = ('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a

  def encode(numeric, s = '')
    fail ArgumentError, 'must pass in a number' unless numeric.is_a?(Numeric)
    numeric += ENV['BASE62_RANDOM'].to_i
    return '0' if numeric == 0
    while numeric > 0
      s << Base62::SIXTYTWO[numeric.modulo(62)]
      numeric /= 62
    end
    s.reverse
  end

  def decode(base62, total = 0)
    s = base62.to_s.reverse.split('')
    s.each_with_index do |char, index|
      fail ArgumentError, "#{base62} has #{char} which is not valid" unless SIXTYTWO.index(char)
      total += SIXTYTWO.index(char) * (62**index)
    end
    total -= ENV['BASE62_RANDOM'].to_i
  end

  module_function :encode, :decode
end
