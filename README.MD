# Ruby Developer Test

## Table of Contents
* [Technologies Used](#technologies-used)
* [Setup](#setup)
* [Usage](#usage)
* [Testing](#testing)

## Technologies Used
- ruby
- rspec ~> 3.11

## Setup

In order to use parser script you need to install gems by running: 

```shell
bunlde install
```

## Usage

Parser script can be run with following command:

```shell
bin/parser.rb -f spec/fixtures/webserver.log
```

This example is using log file from spec fixtures.

Help command can be run to see more options:

```
bin/parser.rb --help
```

## Testing

Tests are using RSpec, they can be run by following command:

```shell
bundle exec rspec
```