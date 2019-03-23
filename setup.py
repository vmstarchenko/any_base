import os
from distutils.core import setup
from distutils.extension import Extension

try:
    from Cython.Build import cythonize
    has_cython = True
except ImportError:
    has_cython = False

ext = '.pyx' if has_cython else '.c'

extra_compile_args = [
    "-O3",
    # "--fsanitize=leak"
]

source = os.path.join("any_base", "_any_base")

extensions = [
    Extension("any_base._any_base", [source + ext], extra_compile_args=extra_compile_args),
]

if has_cython:
    extensions = cythonize(extensions)

setup(
    name='any_base',
    version='0.1.0',
    description='Convert numbers to any base',
    author='Vladimir Starchenko',
    author_email='vmstarchenko@edu.hse.ru',
    packages=['any_base'],
    ext_modules=extensions,
)
