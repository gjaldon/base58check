defmodule Base58Check do

	b58_alphabet = Enum.with_index('123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz')

	for {encoding, value} <- b58_alphabet do
		defp do_encode58(unquote(value)), do: unquote(encoding)
		defp do_decode58(unquote(encoding)), do: unquote(value)
	end

	def encode58(data) do
		integer = :binary.decode_unsigned(data)
		encode58(integer, [])
	end
	defp encode58(0, acc), do: to_string(acc)
	defp encode58(integer, acc) do
		encode58(div(integer, 58), [do_encode58(rem(integer, 58)) | acc])
	end	
	
	def encode58check(prefix, data) when is_integer(prefix) and is_integer(data) do
		prefix = :binary.encode_unsigned(prefix)
		data = :binary.encode_unsigned(data)
		versioned_data = prefix <> data

		<<checksum::binary-size(4), _rest::binary-size(28)>> = versioned_data |> :erlsha2.sha256() |> :erlsha2.sha256()
		encode58((versioned_data <> checksum))
	end
end
