simple-website-speed-test
=========================

## Quick Start

* Usage: bash performance-tests.sh http://your-url.tld/somepage

## Introduction

Bash script to initiate [TAP compliant](http://www.testanything.org/) web performance metrics testing to be easily integrated with Jenkins or Travis CI

## Required Tools

* [Node.js](http://github.com/joyent/node)

* [PhantomJS](http://github.com/ariya/phantomjs/)

* [Phantomas](http://github.com/macbre/phantomas)

* [jq](http://stedolan.github.io/jq/)

* [BATS](http://github.com/sstephenson/bats)

For potential integration with Jenkins, check out this [plugin](https://wiki.jenkins-ci.org/display/JENKINS/TAP+Plugin).

## How to maintain the test suite:

All names for tests & their variables are derived from JSON object names
used by [Phantomas](https://github.com/macbre/phantomas) for consistency.

To create a new testable metric, find its respective JSON object name in
[the Phantomas documentation](https://github.com/macbre/phantomas#metrics).

Then add it to the array of test metric names within "Metrics_to_analyze"
in this script and create a test, using its name as the variable containing
the testable value, for it in "performance-tests.bats".

Example - testing that the time to first byte is less than 200ms:

* performance-tests.sh:
```bash
Metrics_to_analyze=('timeToFirstByte' '...' '...' '...')
```

* performance-tests.sh:
```bash
@test "Time to first byte" {
 	[ "$timeToFirstByte" -lt 200 ]
}
```
