#!/bin/bash
#
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#
#
# The MIT License (MIT)
# 
# Copyright (c) 2017 Thomas Lange [<code@nerdmind.de>]
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#
# Copy Shared Library Dependencies           [Thomas Lange <code@nerdmind.de>] #
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#
#
#                                                                              #
# This script copies all shared library dependencies from a binary source file #
# to a desired target directory. The directory structure of the libraries will #
# be mapped relative to the target directory. The binary file itself will also #
# be copied to the target directory.                                           #
#                                                                              #
# OPTION [-b]: Full path to the binary whose dependencies shall be copied.     #
# OPTION [-t]: Full path to the target directory for the dependencies.         #
#                                                                              #
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#

#===============================================================================
# Parsing command-line arguments with the getopts shell builtin
#===============================================================================
while getopts :b:t: option
do
	case $option in
		b) ARGUMENT_BINARY="$OPTARG" ;;
		t) ARGUMENT_TARGET="$OPTARG" ;;
	esac
done

#===============================================================================
# Checking if all required command-line arguments are provided
#===============================================================================
[ -z "${ARGUMENT_BINARY}" ] && echo "$0: Missing argument: [-b binary]" >&2
[ -z "${ARGUMENT_TARGET}" ] && echo "$0: Missing argument: [-t target]" >&2

#===============================================================================
# Abort execution if required command-line argument is missing
#===============================================================================
[ -z "${ARGUMENT_BINARY}" ] || [ -z "${ARGUMENT_TARGET}" ] && exit 1

#===============================================================================
# Checking if binary or target path does not exists and abort
#===============================================================================
[ ! -f "${ARGUMENT_BINARY}" ] && echo "$0: Binary path does not exists." >&2 && exit 1
[ ! -d "${ARGUMENT_TARGET}" ] && echo "$0: Target path does not exists." >&2 && exit 1

#===============================================================================
# Copy binary file with its parent directories to the target directory
#===============================================================================
cp --verbose --parents "${ARGUMENT_BINARY}" "${ARGUMENT_TARGET}"

#===============================================================================
# Copy each library with its parent directories to the target directory
#===============================================================================
for library in $(ldd "${ARGUMENT_BINARY}" | cut -d '>' -f 2 | awk '{print $1}')
do
	[ -f "${library}" ] && cp --verbose --parents "${library}" "${ARGUMENT_TARGET}"
done
