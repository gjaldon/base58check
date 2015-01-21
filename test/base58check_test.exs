defmodule Base58CheckTest do
  use ExUnit.Case

  test "encode58check/2 accepts integer" do
  	bin = Base.decode16! "1e99423a4ed27608a15a2616a2b0e9e52ced330ac530edcc32c8ffc6a526aedd", case: :lower
  	integer = :binary.decode_unsigned(bin)
    assert Base58Check.encode58check(128, integer) == "5J3mBbAH58CpQ3Y5RNJpUKPE62SQ5tfcvU2JpbnkeyhfsYB1Jcn"
  end

  test "encode58check/2 accepts binary" do
  	data_bin = Base.decode16! "1e99423a4ed27608a15a2616a2b0e9e52ced330ac530edcc32c8ffc6a526aedd", case: :lower
  	prefix_bin = :binary.encode_unsigned(128)
    assert Base58Check.encode58check(prefix_bin, data_bin) == "5J3mBbAH58CpQ3Y5RNJpUKPE62SQ5tfcvU2JpbnkeyhfsYB1Jcn"
  end

  test "encode58check/2 accepts hex" do
  	bin = "1e99423a4ed27608a15a2616a2b0e9e52ced330ac530edcc32c8ffc6a526aedd"
    assert Base58Check.encode58check(128, bin) == "5J3mBbAH58CpQ3Y5RNJpUKPE62SQ5tfcvU2JpbnkeyhfsYB1Jcn"
  end
end
