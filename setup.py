from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

extra_compile_args = [
    "-O3",
    # "--fsanitize=leak"
]

extensions = [
    Extension("any_base", ["any_base.pyx"], extra_compile_args=extra_compile_args),
]

setup(
    name='any_base',
    version='0.1.0',
    description='Convert numbers to any base',
    author='Vladimir Starchenko',
    author_email='vmstarchenko@edu.hse.ru',
    ext_modules=cythonize(extensions),
)
