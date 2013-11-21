#!/usr/bin/env bats

@test "Time to first byte" {
  [ "$timeToFirstByte" -lt 180 ]
}

@test "Median Response Time" {
  [ "$medianResponse" -lt 220 ]
}

@test "Number of HTTP requests" {
  [ "$requests" -lt 30 ]
}

@test "Number of domains" {
  [ "$domains" -lt 7 ]
}

@test "Number of 404 Not Found" {
  [ "$notFound" -eq 0 ]
}

@test "Number of redirects" {
  [ "$redirects" -eq 0 ]
}

@test "Number of CSS files" {
  [ "$cssCount" -eq 1 ]
}

@test "CSS size" {
  [ "$cssSize" -lt 65536 ]
}

@test "Number of Javascript files" {
  [ "$jsCount" -lt 5 ]
}

@test "Javascript size" {
  [ "$jsSize" -lt 256000 ]
}

@test "Number of webfonts" {
  [ "$webfontCount" -lt 3 ]
}

@test "DOM complexity" {
  [ "$DOMelementMaxDepth" -lt 11 ]
}
