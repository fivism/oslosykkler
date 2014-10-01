## This seeks out the bicycle counts for 49 (Frognerveien) and 54 (Briskeby) 
## from the most recent scrape in /scrapes
##
## For now, in a dumb way
## Later in a smart way
##
## Ideally in the future it will query a db where the scrapes are collected
##
import json
import os
import glob
import sys

## Seek most recently created txt file in set dirpath
newest = max(glob.iglob('Thursday6and9/*.txt'), key=os.path.getctime)

## Open this
json_data = open(newest)
jdata = json.load(json_data)

## CSV writing phase
## Open writeable file
output_file = open(newest, "w")

## Write headers
output_file.write("id,bikesready,emptylocks,online\n")

i = 0
while i < len(jdata):
	# bikesreadyvar = jdata[i][u'bikesReady']
	# emptylocksvar = jdata[i][u'emptyLocks']
	# idvar = jdata[i][u'id']
	# onlinevar = jdata[i][u'online']

	# We're changing the column order here:
	output_file.write("%i," % jdata[i][u'id'])
	output_file.write("%i," % jdata[i][u'bikesReady'])
	output_file.write("%i," % jdata[i][u'emptyLocks'])
	output_file.write("%s\n" % jdata[i][u'online'])
	i = i + 1


output_file.close()


# Format as if for 16x2 display
# 
# output_file = open("display", "w")
# output_file.write("FROGNERVEI: %s\n" % fortynine)
# output_file.write("BRISKEBY: %s\n" % fiftyfour)
# print "FROGNERVEI: %s" % fortynine
# print "BRISKEBY: %s" % fiftyfour
# output_file.close()

json_data.close()

