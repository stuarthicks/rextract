# rextract

Simple shell regex capture extractor. Processes STDIN and matches using the provided regex. The first capture group defined in the regex is printed to STDOUT (or a specific named group using `-g`).

## Why?

This is nothing new, and can be achieved with many other tools such as Perl, Sed, etc. However I often struggle to remember the specific flags and quirks of those tools, especially when switching between BSD and Linux based systems. This tool is as simple as I've always wanted this "regex extractor" functionality to be.

## Install

    go install github.com/stuarthicks/rextract@latest

## Usage

    Usage of rextract:
      -e string
            A regular expression to match against stdin (default ".")
      -g string
            Extract this named capture group instead of the first capture

## Examples

    echo 'foobarbat' | rextract -e '(bar)' # prints 'bar'

    echo 'foobarbat' | rextract -e '(foo)(bar)' # prints 'foo'

    echo 'foobarbat' | rextract -e '(?P<one>foo)(?P<two>bar)' -g two # prints 'bar'
