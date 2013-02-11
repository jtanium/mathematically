module Mathematically

  #
  def factors_of(n)
    n = n.abs
    facts = []
    (1..n).each do |x|
      facts << x if n % x == 0
    end

    facts
  end

  def greatest_common_factor(a,b)
    (factors_of(a)&factors_of(b)).sort.last
  end
  alias :gcf :greatest_common_factor
  alias :greatest_common_divisor :greatest_common_factor
  alias :gcd :greatest_common_divisor

  def least_common_multiple(a,b)
    (a*b)/gcf(a,b)
  end
  alias :lcm :least_common_multiple

  def simplify_fraction(num,den)
    return (num/den) if num % den == 0 # return the 

    g = gcf(num,den)

    [num/g,den/g]
  end

  def add_fractions(frac_a, frac_b)
    frac_a, frac_b = _convert_to_common_denominator(frac_a, frac_b)

    simplify_fraction(frac_a[0] + frac_b[0], frac_a[1])
  end

  def sub_fractions(frac_a, frac_b)
    frac_a, frac_b = _convert_to_common_denominator(frac_a, frac_b)

    simplify_fraction(frac_a[0] - frac_b[0], frac_a[1])
  end

  def multiply_fractions(frac_a, frac_b)
    simplify_fraction(frac_a[0] * frac_b[0], frac_a[1] * frac_b[1])
  end

  def to_mixed_number(frac)
    simplified_fraction = simplify_fraction(*frac)
    return frac if frac[0] <= frac[1]

    whole = frac[0] / frac[1]

    remainder = frac[0] % frac[1]
    [whole, remainder, frac[1]]
  end

  def arithmetic_mean(set,answer_form=:float)
    numerator = set.inject { |sum,n| sum + n }
    denominator = set.length

    case answer_form
    when :float
      numerator.to_f / denominator
    when :fraction
      simplify_fraction(numerator,denominator)
    else
      raise "I don't know how to answer in the form #{answer_form.inspect}"
    end
  end
  alias :mean :arithmetic_mean

  def median(set)
    sorted_set = set.sort
    middle = set.length / 2

    if (set.length % 2) == 1
      sorted_set[middle]
    else
      arithmetic_mean([sorted_set[middle-1], sorted_set[middle]])
    end
  end

  def mode(set)
    frequencies = _frequencies_of(set)
    most_freq   = _most_frequent(frequencies)

    arithmetic_mean(most_freq)
  end

  def prime?(n)
    factors_of(n) == [1,n]
  end

  def population_variance(set)
    mu = mean(set)

    mean(set.map { |n| (n-mu)**2 })
  end

  def sample_variance(set)
    mu = mean(set)

    set.map { |n| (n-mu)**2 }.inject { |sum,n| sum + n } / (set.length - 1)
  end

  def population_standard_deviation(set)
    Math.sqrt population_variance(set)
  end

  def sample_standard_deviation(set)
    Math.sqrt sample_variance(set)
  end

  # helper methods -- not part of the api...
  def _convert_to_common_denominator(frac_a, frac_b)
    frac_a_num = frac_a[0] # numerator of fraction a
    frac_a_den = frac_a[1] # denominator of fraction a
    frac_b_num = frac_b[0] # numerator of fraction b
    frac_b_den = frac_b[1] # denominator of fraction b

    denominator = least_common_multiple(frac_a_den, frac_b_den)

    # multiplier tells us what to multiply the numerators by
    mult_a = denominator/frac_a_den # multiplier for 'a'
    mult_b = denominator/frac_b_den # multiplier for 'b'

    [[(frac_a_num * mult_a), denominator],
     [(frac_b_num * mult_b), denominator]]
  end

  def _frequencies_of(set)
    frequencies = Array.new # [[n,freq_n], [m,freq_m], [x,freq_x], ...]
    set.each do |n| # for each members of the set...
      freq = frequencies.detect { |f| f[0] == n } || (frequencies << [n, 0]).last # find existing freq or create a new one...
      freq[1] += 1 # increment frequency of n
    end

    frequencies
  end

  def _most_frequent(set_of_frequencies)
    most_freq = [] # most frequent members
    max_freq = 0   # maximum frequency
    set_of_frequencies.each do |freq|
      next if freq[1] < max_freq # if the frequency of n is less than the max frequency, go to the next member

      if freq[1] == max_freq # if the frequency of n is equal to the max frequency, add n to the most frequent
        most_freq << freq[0]
      elsif freq[1] > max_freq # if the frequency of n is greater than the max frequency, replace both
        most_freq = [freq[0]]
        max_freq = freq[1]
      else
        raise "Umm... how did I get here?: #{freq[1].inspect} :: #{max_freq.inspect}"
      end
    end

    most_freq
  end
end
