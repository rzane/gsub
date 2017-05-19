# Gsub

A CLI program to do find and replace!

## Installation

TODO

## Usage

```sh
# Find occurances of `foo` in the current directory
$ gsub foo

# Find lines ending with `foo` in the current directory
$ gsub 'foo$'

# Find an replace all occurances of `foo` with `bar`
$ gsub foo --replace bar --commit

# Find an replace with backtracking
$ gsub 'foo (\w+) bar' --replace 'Got: \1' --commit

# Preview a find/replace (just omit the --commit)
$ gsub 'foo' --replace bar

# Find occurances of `foo` in the `app` and `lib` directories
$ gsub foo app lib

# Find with globs
$ gsub foo 'spec/**/*_spec.rb'

# Exclude files matching a regex
$ gsub foo 'spec/**/*_spec.rb' --exclude 'foo_spec\.rb' --exclude 'bar_(\w+)_spec\.rb'
```

## Development

To compile Gsub, you'll need Crystal. Instructions for your operating system can be found here: http://crystal-lang.org/docs/installation.

To build a release, simply run `make`.

## Contributing

1. Fork it ( https://github.com/rzane/gsub/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request
