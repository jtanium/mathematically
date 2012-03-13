$:.unshift File.join(File.dirname(__FILE__), '..')
require 'rspec'
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

end
