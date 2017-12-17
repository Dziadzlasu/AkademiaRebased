require 'minitest/autorun'
require 'minitest/pride'
require_relative 'binary_tree'

class TestBinaryTree < Minitest::Test
  def test_binary_tree_with_nil_arguments
    b = BinaryTree.new(nil, nil, nil)
    assert_equal('', b.value)
    assert_nil(b.left)
    assert_nil(b.right)
  end

  def test_binary_tree_with_one_element
    b = BinaryTree.create([5])
    assert_equal('5', b.value)
    assert_nil(b.left)
    assert_nil(b.right)
  end

  def test_binary_tree_with_normal_array
    b = BinaryTree.create([3, 1, 2, 9, 7, 8, 6])
    assert('6', b.value)
    assert('2', b.left.value)
    assert('1', b.left.left.value)
    assert_nil(b.left.left.left)
    assert_nil(b.left.left.right)
    assert('3', b.left.right.value)
    assert_nil(b.left.right.left)
    assert_nil(b.left.right.right)
    assert('8', b.right.value)
    assert('7', b.right.left.value)
    assert_nil(b.right.left.left)
    assert_nil(b.right.left.right)
    assert('9', b.right.right.value)
    assert_nil(b.right.right.left)
    assert_nil(b.right.right.right)
  end
end
