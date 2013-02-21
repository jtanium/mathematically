require 'mathematically'

describe Mathematically do
  include Mathematically
  describe '#factors_of' do
    it "should return an array of the factors of the given number" do
      factors_of(10).should == [1,2,5,10]
      factors_of(20).should == [1,2,4,5,10,20]
      factors_of(9).should == [1,3,9]
      factors_of(6).should == [1,2,3,6]
      factors_of(18).should == [1,2,3,6,9,18]
    end
  end

  describe "#prime_factors_of" do
    it "should return an array containing the prime factors of the given number" do
      prime_factors_of(12).should == [2, 2, 3]
      prime_factors_of(60).should == [2, 2, 3, 5]
      prime_factors_of(17).should == [17]
      prime_factors_of(18).should == [2, 3, 3]
      prime_factors_of(100).should == [2, 2, 5, 5]
      prime_factors_of(900).should == [2, 2, 3, 3, 5, 5]
    end
  end

  describe '#greatest_common_factor' do
    it "should return the greatest common factor of the given numbers" do
      greatest_common_factor(10,20).should == 10
      greatest_common_factor(9,6).should == 3
      greatest_common_factor(9,-6).should == 3
    end
  end

  describe '#least_common_multiple' do
    it "should return the least common multiple of the given numbers" do
      least_common_multiple(6,18).should == 18
      least_common_multiple(28,32).should == 224
      least_common_multiple(20,18).should == 180
    end
  end

  describe "#simplify_fraction" do
    it "should return a two element Array representing a simplified proper fraction" do
      simplify_fraction(9,27).should == [1,3]
      simplify_fraction(8,64).should == [1,8]
      simplify_fraction(18,27).should == [2,3]
      simplify_fraction(-18,27).should == [-2,3]
    end
    context "when the numerator is larger than the denominator" do
      it "should return a two element Array representing a simplified proper fraction" do
        simplify_fraction(27,18).should == [3,2]
      end
    end
    context "when the numerator is evenly divisible by the denominator" do
      it "should return an Integer" do
        simplify_fraction(27,9).should == 3
        simplify_fraction(64,8).should == 8
      end
    end
  end

  describe "#add_fractions" do
    it "should return an array representing the simplified fraction" do
      add_fractions([1,3],[1,2]).should == [5,6]
      add_fractions([1,2],[-1,3]).should == [1,6]
      add_fractions([1,3],[-1,2]).should == [-1,6]
      add_fractions([-8,4],[7,8]).should == [-9,8]
      add_fractions([-1,3],[-2,5]).should == [-11,15]
      add_fractions([5,6],[-7,3]).should == [-3,2]
    end
  end

  describe "#sub_fractions" do
    it "should return an array representing the simplified fraction" do
      sub_fractions([1,2],[1,3]).should == [1,6]
      sub_fractions([1,3],[1,2]).should == [-1,6]
      sub_fractions([1,2],[-1,3]).should == [5,6]
      sub_fractions([1,3],[-1,2]).should == [5,6]
      sub_fractions([-1,2],[1,3]).should == [-5,6]
      sub_fractions([-1,3],[1,2]).should == [-5,6]
      sub_fractions([-1,2],[-1,3]).should == [-1,6]
      sub_fractions([-1,3],[-1,2]).should == [1,6]
    end
  end

  describe "#mult_fractions" do
    it "should return an array representing the simplified fraction" do
      multiply_fractions([1,2], [1,2]).should == [1,4]
      multiply_fractions([1,2], [-1,3]).should == [-1,6]
      multiply_fractions([-1,2], [1,3]).should == [-1,6]
      multiply_fractions([-1,2], [-1,3]).should == [1,6]
      multiply_fractions([15,4], [19,5]).should == [57,4]
    end
  end

  describe "#to_mixed_number" do
    it "should return a mixed number" do
      to_mixed_number([57,4]).should == [14, 1, 4]
    end
  end

  describe "#arithmetic_mean" do
    it "should divide the sum of the elements by number of elements" do
      arithmetic_mean([7,5,8,9,4,5,8,4,10,4]).should eq(6.4)
      arithmetic_mean([7,5,8,9,4,5,8,4,10,4], :float).should eq(6.4)
      arithmetic_mean([7,5,8,9,4,5,8,4,10,4], :fraction).should eq([32,5])
    end
  end

  describe "#median" do
    it "should return the middle number" do
      median([7,5,8,9,4,5,8,4,4]).should eq(5)
    end
    context "when there are two middle numbers" do
      it "should return the arithmetic mean of the two middle numbers" do
        median([7,5,8,9,4,5,8,4,10,4]).should eq(6)
      end
    end
  end

  describe "#mode" do
    it "should return the most frequent element" do
      mode([7,5,8,9,4,5,8,4,10,4]).should eq(4)
    end
    context "when multiple elements are equally frequent" do
      it "should return the arithmetic mean of those elements" do
        mode([7,5,8,9,4,5,8,4,10,4,5]).should eq(4.5)
      end
    end
  end

  describe "#prime?" do
    it "should return false" do
      prime?(27).should be_false
    end
    context "when factors of n are [1,n]" do
      it "should return true" do
        prime?(29).should be_true
      end
    end
  end

  describe "#population_variance" do
    it "should return the variance" do
      population_variance([2,2,3,3]).should eq(0.25)
      population_variance([0,0,5,5]).should eq(6.25)
      population_variance([19,22,3,5,12,3]).should eq(58.22222222222222)
    end
  end

  describe "#sample_variance" do
    it "should return the variance" do
      sample_variance([2,2,3,3]).should eq(0.3333333333333333)
      sample_variance([0,0,5,5]).should eq(8.333333333333334)
      sample_variance([19,22,3,5,12,3]).should eq(69.86666666666666)
    end
  end

  describe "#population_standard_deviation" do
    it "should return the standard deviation of the population" do
      population_standard_deviation([14,16,5,6]).should eq(4.815340071064556)
    end
  end

  describe "#sample_standard_deviation" do
    it "should return the standard deviation of the sample" do
      sample_standard_deviation([14,16,5,6]).should eq(5.560275772537426)
    end
  end

  describe "#pythagorean_theorem" do
    it "should return the hypotenuse of the right triangle" do
      pythagorean_theorem(3, 4).should eq(5.0)
      pythagorean_theorem(5, 12, :radical).should eq([13,:sqrt,0])
      pythagorean_theorem(19, 34).should eq(38.948684188300895)
      pythagorean_theorem(14, 11, :radical).should eq([0,:sqrt,317])
    end
  end

  describe "#simplify_radical" do
    it "should return the simplified radical" do
      simplify_radical(2 * 2 * 3).should eq([2,:sqrt,3])
      simplify_radical(5 * 5).should eq([5,:sqrt,0])
      simplify_radical(5 * 5 * 2).should eq([5,:sqrt,2])
      simplify_radical(317).should eq([0,:sqrt,317])
    end
    it "should simplify radicals besides root 2" do
      simplify_radical(27, 3).should eq([3,:rt3,0])
      simplify_radical(125, 3).should eq([5,:rt3,0])
      simplify_radical(1024, 5).should eq([4,:rt5,0])
      simplify_radical(1024, 10).should eq([2,:rt10,0])
    end
    it "should handle multiple " do
      simplify_radical(5 * 5 * 5).should == [5,:sqrt,5]
      simplify_radical(2 * 2 * 2 * 2 * 2 * 2).should == [8,:sqrt,0]
      simplify_radical(2 * 2 * 2 * 2 * 2 * 2 * 2).should == [8,:sqrt,2]
      simplify_radical(3 * 3 * 3).should == [3,:sqrt,3]
      simplify_radical(4 * 4 * 4, 3).should == [4,:rt3,0]
      simplify_radical(2 * 2 * 2 * 2 * 3 * 3 * 5 * 5 * 7).should == [60,:sqrt,7]
    end
  end

  describe "#distance" do
    it "should return the distance between the two points" do
      distance(8, 7, -8, 6).should == 16.0312195418814
      distance(6, 3, 8, -3).should == 6.324555320336759
      distance(6, 5, -7, -7).should == 17.69180601295413
      distance(-6, 5, -7, -7).should == 12.041594578792296
    end
    it "should return the distance as a simplified radical" do
      distance(8, 7, -8, 6, :radical).should == [0, :sqrt, 257]
      distance(6, 3, 8, -3, :radical).should == [2, :sqrt, 10]
      distance(6, 5, -7, -7, :radical).should == [0, :sqrt, 313]
      distance(-6, 5, -7, -7, :radical).should == [0, :sqrt, 145]
    end
  end

end
