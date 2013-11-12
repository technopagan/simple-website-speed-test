#!/usr/bin/env bash 

###############################################################################
#
# Bash script to initiate TAP compliant (http://www.testanything.org/) web 
# performance metrics testing to be easily integrated with Jenkins or Travis CI
#
# Usage: bash performance-tests.sh http://your-url.tld/somepage
#
###############################################################################
#
# Tools needed to run this test suite:
#
#	* Node.js (http://github.com/joyent/node)
#
# * PhantomJS (http://github.com/ariya/phantomjs/)
#
#	* Phantomas (http://github.com/macbre/phantomas)
#
#	* jq (http://stedolan.github.io/jq/)
#
#	* BATS (http://github.com/sstephenson/bats)
#
#
#
# For potential integration with Jenkins, check out this plugin:
#
# * https://wiki.jenkins-ci.org/display/JENKINS/TAP+Plugin
#
###############################################################################
# 
# How to maintain the test suite:
#
# All names for tests & their variables are derived from JSON object names
# used by Phantomas (https://github.com/macbre/phantomas) for consistency.
#
# To create a new testable metric, find its respective JSON object name in
# the Phantomas documentation (https://github.com/macbre/phantomas#metrics).
#
# Then add it to the array of test metric names within "Metrics_to_analyze"
# in this script and create a test, using its name as the variable containing
# the testable value, for it in "performance-tests.bats".
#
# Example - testing that the time to first byte is less than 200ms:
#
# - performance-tests.sh:
#		[...]
#		Metrics_to_analyze=('timeToFirstByte' '...' '...' '...')
#		[...]
# 
# - performance-tests.bats:
#		[...]
# 	@test "Time to first byte" {
#  		[ "$timeToFirstByte" -lt 200 ]
# 	}
#		[...]
# 
###############################################################################



###############################################################################
# USER CONFIGURABLE PARAMETERS
###############################################################################

# Define an array of metrics to be analyzed 
Metrics_to_analyze=('timeToFirstByte' 'medianResponse' 'requests' 'domains' 'redirects' 'cssCount' 'cssSize' 'jsCount' 'jsSize')



###############################################################################
# GLOBAL RUNTIME VARIABLES (usually do not require tuning by user)
###############################################################################

# Accept the test URL as a command  line argument 
URL_to_measure="$1"

# Start PhantomJS based Phantomas (https://github.com/macbre/phantomas) to retrieve a JSON response containing all of Phantomas predefined performance metrics
Phantomas_JSON_output=$(phantomas --format=json --url "${URL_to_measure}")



###############################################################################
# MAIN PROGRAM
###############################################################################

# Iterate over every created tile we have listed in our array
for((i=0;i<${#Metrics_to_analyze[@]};i++)) ; do
	JSON_metric_name=".metrics."${Metrics_to_analyze[$i]}
	eval ${Metrics_to_analyze[$i]}=$(echo "$Phantomas_JSON_output" | jq "${JSON_metric_name}")
	export ${Metrics_to_analyze[$i]}
done

# Initialize the BATS test suite with TAP (TestAnythingProtocol, http://testanything.org/) output
bats --tap performance-tests.bats
