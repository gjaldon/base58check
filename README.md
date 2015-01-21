Base58Check
===========
[Base58Check](https://en.bitcoin.it/wiki/Base58Check_encoding) encoding in Elixir with the Bitcoin-specific alphabet. 


Usage
=====
Base85Check exposes 4 functions: `encode58/1, decode58/1, encode58check/2, decode58check/1`. `encode58check/2` accepts
a hex string, binary or integer and returns base58-encoded string. `decode58check/1` accepts a base58-encoded string
and returns a binary. 

```elixir
iex(1)> Base58Check.encode58check(128, "1e99423a4ed27608a15a2616a2b0e9e52ced330ac530edcc32c8ffc6a526aedd")
"5J3mBbAH58CpQ3Y5RNJpUKPE62SQ5tfcvU2JpbnkeyhfsYB1Jcn"

iex(2)> {prefix, payload} = Base58Check.decode58check("5J3mBbAH58CpQ3Y5RNJpUKPE62SQ5tfcvU2JpbnkeyhfsYB1Jcn")
iex(3)> Base.encode16(payload, case: :lower)
"1e99423a4ed27608a15a2616a2b0e9e52ced330ac530edcc32c8ffc6a526aedd"
iex(4)> :binary.decode_unsigned(prefix)
128
```


License
=======
The MIT License (MIT)

Copyright (c) 2015 Gabriel Jaldon

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

