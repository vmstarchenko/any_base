import any_base

base = any_base.IntBase(b'0123456789')
print(base)
print(base(1000))

base = any_base.IntBase(b'abc', b'~')
print(base)
print(base(-11))
print(base.sign)
print(base.base)
print(base.alphabet)
