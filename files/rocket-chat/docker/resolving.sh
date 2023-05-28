#!/bin/bash
################################################################################
# Imported from: https://github.com/tran4774/Resolving-Shared-Library/blob/master/resolving.sh
################################################################################

destination=''
path=''
file=''
list_files=()

Help () {
  echo "usage: resolving [-h] [-p PATH] [-f FILE] [-d DESTINATION]
  This executable file will help you resolve shared object library dependencies for building image with
  minimum number of files

  options:
    -h                Show this help message and exit
    -p PATH           Path contain all files need to resolve shared object library
    -f FILE           File need to resolve shared object library
    -d DESTINATION    Destination folder to copy dependencies"
}

resolve_file() {
  if [ -z $(readlink -e "$file") ]; then
      echo "$file does not exists."
      exit;
  fi
  list_files+=( $((ldd "$file" | tr -s '[:blank:]' '\n' | grep '^/') 2>/dev/null) );
  echo -e -n '\e[1A\e[K'
	echo "Resolving dependencies for $file";
}

resolve_directory() {
  if [ -z $(readlink -e "$path") ]; then
      echo "$path does not exists."
      exit;
  fi
  for i in $(find $path/** -type f); do
    list_files+=( $((ldd "$i" | tr -s '[:blank:]' '\n' | grep '^/') 2>/dev/null) );
    echo -e -n '\e[1A\e[K'
    echo "Resolving dependencies for $i";
  done;
  echo -e '\e[1A\e[KResolving done.\n'
}

copy_dependencies() {
  for i in $(echo ${list_files[@]}| tr ' ' '\n' | sort -u | tr '\n' ' '); do
    mkdir -p $(dirname $destination/$i);
    echo -e -n '\e[1A\e[K'
    echo "Copying $i"
    cp $i $destination/$i;
  done;
  echo -e '\e[1A\e[KCopy all dependencies done.'
}

while getopts d:p:f:h flag
do
  case "${flag}" in
    d) destination=${OPTARG};;
    p) path=${OPTARG};;
    f) file=${OPTARG};;
    h)
      Help
      exit;;
  esac
done
if [ -z $destination ]; then
  export destination="deps";
fi

if [ ! -z "$path" ]; then
  resolve_directory
  copy_dependencies
elif [ ! -z "$file" ]; then
  resolve_file
  copy_dependencies
else
  echo "No argument -f or -p are requested "
  exit
fi

