# Gsub

A CLI program to do find and replace!

## Installation

You can grab a binary release from the [releases](https://github.com/rzane/gsub/releases) tab. Install it somewhere on your `PATH`.

Here's a one-liner:

```sh
$ curl -L https://github.com/rzane/gsub/releases/download/0.1.1/gsub-0.1.1_darwin_x86_64.tar.gz | tar xvf - -C /usr/local
```

Currently, binary releases are only available for Darwin. If you're on Linux, you'll have to build from source.

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

# Specify paths
$ gsub foo 'spec/**/*_spec.rb' 'app/**/*.rb'

# Exclude files from paths
$ gsub foo 'spec/**/*_spec.rb' --exclude 'spec/foo_spec.rb' --exclude 'spec/bar_*_spec.rb'
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
