# distutils: language = c++
# cython: language_level=3, boundscheck=False

from cpython.mem cimport PyMem_Malloc, PyMem_Free

from libcpp.string cimport string
from libc cimport stdint, string as cstring


cdef extern from "convert.h" nogil:
    string _convert "convert"(stdint.uint64_t x, char* alphabet, int base, char sign) except +
    string _convert "convert"(stdint.uint64_t x, char* alphabet, int base) except +

    int _repair "repair"(char* x, int length, char* repair_alphabet, int base) except +


cdef class IntBase:
    cdef char * _alphabet
    cdef char * _repair_alphabet
    cdef char _sign
    cdef int _base
    cdef int _repair

    def __cinit__(self, bytes alphabet, bytes sign = b'-', repair = False):
        self._base = len(alphabet)
        self._alphabet = <char *>PyMem_Malloc(self._base)
        cstring.strncpy(self._alphabet, alphabet, self._base)
       
        self._repair = repair
        if repair:
            max_char = max(alphabet) + 1
            self._repair_alphabet = <char *>PyMem_Malloc(max_char)
            cstring.memset(self._repair_alphabet, 0, max_char)

            for i, letter in enumerate(alphabet):
                self._repair_alphabet[letter] = i

        assert len(sign) == 1, 'sign must be one char'
        self._sign = sign[0]

    def __dealloc__(self):
        PyMem_Free(self._alphabet)
        PyMem_Free(self._repair_alphabet)

    def __str__(self):
        return 'IntBase<%d, %r>' % (self._base, self._alphabet[:self._base])

    def __repr__(self):
        return 'IntBase<%d>' % self._base

    def __call__(self, int x):
        sign = x > 0
        if sign:
            return _convert(x, self._alphabet, self._base)
        return _convert(-x, self._alphabet, self._base, self._sign)

    def repair(self, bytes x):
        assert self._repair, "Cant repair base"
        return _repair(x, len(x), self._repair_alphabet, self._base)

    @property
    def sign(self):
        return chr(self._sign)

    @property
    def base(self):
        return self._base

    @property
    def alphabet(self):
        return self._alphabet[:self._base]

