defmodule Base58Check do

	b58_alphabet = Enum.with_index('123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz')

	for {encoding, value} <- b58_alphabet do
		defp do_encode58(unquote(value)), do: unquote(encoding)
		defp do_decode58(unquote(encoding)), do: unquote(value)
	end

	def encode58(data) do
		integer = if is_binary(data), do: :binary.decode_unsigned(data), else: data
		encode58(integer, [])
	end
	defp encode58(0, acc), do: to_string(acc)
	defp encode58(integer, acc) do
		encode58(div(integer, 58), [do_encode58(rem(integer, 58)) | acc])
	end	

	def decode58(data) when is_binary(data) do
		decode58(to_char_list(data), 0)
	end
	defp decode58([], acc), do: acc
	defp decode58([c|codestring], acc) do
		decode58(codestring, (acc * 58) + do_decode58(c))
	end
	def decode58(data), do: raise(ArgumentError, "expects base58-encoded binary")

	def encode58check(prefix, data) when is_binary(prefix) and is_binary(data) do
		data = case Base.decode16(String.upcase(data)) do
				{:ok, bin} 	->	bin
				:error 			->	data
			end
		versioned_data = prefix <> data
		<<checksum::binary-size(4), _rest::binary-size(28)>> = versioned_data |> :erlsha2.sha256() |> :erlsha2.sha256()
		encode58((versioned_data <> checksum))
	end
	def encode58check(prefix, data) do
		prefix = if is_integer(prefix), do: :binary.encode_unsigned(prefix), else: prefix
		data = if is_integer(data), do: :binary.encode_unsigned(data), else: data
		encode58check(prefix, data)
	end
end
