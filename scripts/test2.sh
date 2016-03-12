echo Displays a line of text. It can convert variables into their value if you use $

for file in ~/class/sam/*.sam
do
       echo "head -1 $file"
done

for file in ~/class/sam/*.sam
do
       echo head -1 $file 
done