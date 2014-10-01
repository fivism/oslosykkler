## This converts a whole pile of scrapes made for bysykkel scraping and turns them into CSVs
import json
import os
import glob
import sys

## Seek most recently created txt file in set dirpath
# newest = max(glob.iglob('Thursday6and9/*.txt'), key=os.path.getctime)
filelist = glob.glob("week36/composite/*.txt")

print filelist[2]
k = 0 
while k < len(filelist):
	## Open this
	json_data = open(filelist[k])
	jdata = json.load(json_data)

	## CSV writing phase
	## Open writeable file
	output_file = open(filelist[k]+".csv", "w")

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
	json_data.close()
	output_file.close()
	k = k + 1




# Format as if for 16x2 display
# 
# output_file = open("display", "w")
# output_file.write("FROGNERVEI: %s\n" % fortynine)
# output_file.write("BRISKEBY: %s\n" % fiftyfour)
# print "FROGNERVEI: %s" % fortynine
# print "BRISKEBY: %s" % fiftyfour
# output_file.close()



