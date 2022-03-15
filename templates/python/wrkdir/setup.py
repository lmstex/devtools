#!/usr/bin/env python

"""The setup script."""

from setuptools import setup, find_namespace_packages

with open('README.md') as readme_file:
    readme = readme_file.read()

requirements = []

setup_requirements = ['pytest-runner', ]

test_requirements = ['pytest>=3', ]

setup(
    author="Luis Teixeira",
    author_email='lteixeira.1973@gmail.com',
    python_requires='>=3.5',
    classifiers=[
        'Development Status :: 2 - Pre-Alpha',
        'Intended Audience :: Developers',

        'Natural Language :: English',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7',
        'Programming Language :: Python :: 3.8',
    ],
    description="",
    entry_points={
        'console_scripts': [
            'aurora_resource_mngr=aurora_resource_mngr.cli:main',
        ],
    },
    install_requires=requirements,
    license="private",
    long_description=readme,
    include_package_data=True,
    keywords='%%WRKSPACE%%',
    name='%%WRKSPACE%%',
    package_dir={"": "%%WRKSPACE%%"},
    packages=find_namespace_packages('%%WRKSPACE%%'),
    setup_requires=setup_requirements,
    test_suite='tests',
    tests_require=test_requirements,
    url='',
    version='0.1.0',
    zip_safe=False,
)
