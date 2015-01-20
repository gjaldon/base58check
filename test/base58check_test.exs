defmodule Base58CheckTest do
  use ExUnit.Case

  test "the truth" do
  	bin = Base.decode16! "1e99423a4ed27608a15a2616a2b0e9e52ced330ac530edcc32c8ffc6a526aedd", case: :lower
  	integer = :binary.decode_unsigned(bin)
    assert Base58Check.encode58check(128, integer) == "5J3mBbAH58CpQ3Y5RNJpUKPE62SQ5tfcvU2JpbnkeyhfsYB1Jcn"
  end
end
