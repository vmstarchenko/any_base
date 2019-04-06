import os

from setuptools import setup, Extension, find_packages

setup_requires = [
    'setuptools>=18.0',
    'cython',
]

extra_compile_args = [
    "-O3",
    "-std=c++11",
    # "-fsanitize=leak",
    # "-fsanitize=address",
]

ext = [
    Extension(
        "any_base._any_base",
        [os.path.join("any_base", "_any_base.pyx")],
        extra_compile_args=extra_compile_args,
        language='c++'),
]

setup(
    name='any_base',
    version='0.1.0',
    setup_requires=setup_requires,
    description='Convert numbers to any base',
    author='Vladimir Starchenko',
    author_email='vmstarchenko@edu.hse.ru',
    packages=['any_base'],
    zip_safe=False,
    ext_modules=ext,
)
