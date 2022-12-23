def counter(value = 0)
  counter_value = -> { value }
  increment = -> { value += 1 }

  [counter_value, increment]
end

require 'rails_helper'

RSpec.describe 'Counter Function' do
  let!(:counter_method_array) { counter(3) }
  let!(:counter_method_another_object) { counter(100) }

  it 'should return Array' do
    expect(counter()).to be_an_instance_of(Array)
  end

  it 'should return two methods in the array' do
    expect(counter_method_array.count).to eql(2)
  end

  it 'should return Lambda methods in the array' do
    expect(counter_method_array.map(&:class)).to all(eql(Proc))
  end

  it 'should return the current counter value' do
    expect(counter_method_array[0].call).to eql(3)
  end

  it 'should increase the internal counter value by one' do
    expect(counter_method_array[1].call).to eql(4)
  end

  it 'should create independent instances of counter with Multiple calls' do
    counter_method_array[1].call
    counter_method_another_object[1].call
    expect(counter_method_array).not_to eql(counter_method_another_object)
  end
end
