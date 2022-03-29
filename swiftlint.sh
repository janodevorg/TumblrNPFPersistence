#!/usr/bin/env zsh

if [ ! -z "$SKIP_LINT" ]
then
	echo "Skipping swiftlint because SKIP_LINT is defined."
    exit 0
fi

# Check swiftlint is installed
export lint="swiftlint"
if [ ! -f $lint ] 
then
	export lint=`which swiftlint`
	if [ ! -f $lint ] 
	then
	    echo "swiftlint is not installed. Try installing with Homebrew: brew install swiftlint" >&2
	    exit 1
	fi
fi
echo Using $lint version `$lint version`

# Set project dir
export PROJECT_DIR=${0:a:h}
echo PROJECT_DIR is $PROJECT_DIR
cd $PROJECT_DIR

# Check the directory to lint is passed as 1st parameter
if [[ -z $1 ]]
then
    echo "Pass the relative directory to swiftlint as first parameter, e.g.: swiftlint.sh TeamworkDomain/TeamworkDomain"
	exit 1
fi
echo Directory to lint is $PROJECT_DIR/$1

# Check configuration exists
export conf=$PROJECT_DIR/.swiftlint.yml
if [ ! -f $conf ] 
then
	echo "Missing configuration file at $conf" >&2
	exit 1
fi
echo Using configuration file $conf

count=0

# To input paths with spaces I need to back up the shell input field separator (IFS) and replace it with \n
OIFS="$IFS"
IFS=$'\n'
pwd
for file in `git diff --cached --name-only --diff-filter=ACMR $PROJECT_DIR/$1 | grep "\.swift"`
do
     export SCRIPT_INPUT_FILE_$count="$file"
     echo Adding SCRIPT_INPUT_FILE_$count="$file"
     count=$((count + 1))
done
pwd
for file in `git ls-files -mo --exclude-standard $PROJECT_DIR/$1 | grep "\.swift"`
do
     export SCRIPT_INPUT_FILE_$count="$file"
     echo Adding SCRIPT_INPUT_FILE_$count="$file"
     count=$((count + 1))
done
IFS="$OIFS"

# lint collected files
if (( $count > 0 ))
then
    echo Linting $count files
    export SCRIPT_INPUT_FILE_COUNT=$count
    echo Command is: $lint --config $conf --use-script-input-files
    $lint --config $conf --use-script-input-files
else
	echo Zero modified or staged files. Nothing to lint.
	exit 0
fi
