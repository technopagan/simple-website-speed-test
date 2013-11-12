#!/usr/bin/env bats

@test "Time to first byte" {
  [ "$timeToFirstByte" -lt 200 ]
}

@test "Median Response Time" {
  [ "$medianResponse" -lt 200 ]
}

@test "Number of HTTP requests" {
  [ "$requests" -lt 30 ]
}

@test "Number of domains" {
  [ "$domains" -lt 5 ]
}

@test "Number of redirects" {
  [ "$redirects" -eq 0 ]
}

@test "Number of CSS files" {
  [ "$cssCount" -eq 1 ]
}

@test "CSS size" {
  [ "$cssSize" -lt 15360 ]
}

@test "Number of Javascript files" {
  [ "$jsCount" -lt 4 ]
}

@test "Javascript size" {
  [ "$jsSize" -lt 153600 ]
}
