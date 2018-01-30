require(xlsx)
ccDataFile <- "ccDataFile.xls"

ccDataURL <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00350/default%20of%20credit%20card%20clients.xls"
download.file(url=ccDataURL, destfile=ccDataFile, mode="wb")

# this is taking forever (when I have giant python job running)
ccData <- read.xlsx(file=ccDataFile, sheetIndex=1, startRow=2)

ccData <- read.xlsx2(file=ccDataFile, sheetIndex=1, startRow=2, colClasses="numeric", stringsAsFactors=FALSE)
