# distutils: language = c++
# cython: language_level=3, boundscheck=False

from libcpp.string cimport string
from libc cimport stdint


cdef extern from "convert.h" nogil:
    string convert(stdint.uint64_t x, char* alphabet, int base, char sign)
    string convert(stdint.uint64_t x, char* alphabet, int base)


cdef class IntBase:
    cdef char * _alphabet
    cdef char _sign
    cdef int _base

    def __cinit__(self, bytes alphabet, bytes sign = b'-'):
        self._alphabet = alphabet
        self._base = len(alphabet)
        assert len(sign) == 1, 'sign must be one char'
        self._sign = sign[0]

    def __str__(self):
        return 'IntBase<%d, %r>' % (self._base, self._alphabet)

    def __repr__(self):
        return 'IntBase<%d>' % self._base

    def __call__(self, int x):
        sign = x > 0
        if sign:
            return convert(x, self._alphabet, self._base)
        return convert(-x, self._alphabet, self._base, self._sign)

    @property
    def sign(self):
        return chr(self._sign)

    @property
    def base(self):
        return self._base

    @property
    def alphabet(self):
        return self._alphabet

