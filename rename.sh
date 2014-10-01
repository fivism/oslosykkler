for files in *.txt.csv
do
 mv "$files" "${files%.txt.csv}.txt"
done