defmodule Base58CheckTest do
  use ExUnit.Case

  import Base58Check

  test "encode58/1" do
  	assert encode58(0) == ""
    assert encode58(57) == "z"
    assert encode58(1024) == "Jf"
    assert encode58(123456789) == "BukQL"
    assert encode58(<<1, 0>>) == "5R"
  end

  test "decode58/1" do
  	assert decode58("") == 0
    assert decode58("z") == 57
    assert decode58("Jf") == 1024
    assert decode58("BukQL") == 123456789
    assert_raise ArgumentError, fn ->
    	decode58(123)
    end
  end

  test "encode58check/2 accepts integer" do
  	bin = Base.decode16! "1e99423a4ed27608a15a2616a2b0e9e52ced330ac530edcc32c8ffc6a526aedd", case: :lower
  	integer = :binary.decode_unsigned(bin)
    assert encode58check(128, integer) == "5J3mBbAH58CpQ3Y5RNJpUKPE62SQ5tfcvU2JpbnkeyhfsYB1Jcn"
  end

  test "encode58check/2 accepts binary" do
  	data_bin = Base.decode16! "1e99423a4ed27608a15a2616a2b0e9e52ced330ac530edcc32c8ffc6a526aedd", case: :lower
  	prefix_bin = :binary.encode_unsigned(128)
    assert encode58check(prefix_bin, data_bin) == "5J3mBbAH58CpQ3Y5RNJpUKPE62SQ5tfcvU2JpbnkeyhfsYB1Jcn"
  end

  test "encode58check/2 accepts hex" do
  	bin = "1e99423a4ed27608a15a2616a2b0e9e52ced330ac530edcc32c8ffc6a526aedd"
    assert encode58check(128, bin) == "5J3mBbAH58CpQ3Y5RNJpUKPE62SQ5tfcvU2JpbnkeyhfsYB1Jcn"
  end
end
