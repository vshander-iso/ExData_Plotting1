## V.Shander, Feb 2019 - week1 of Exploratory Data Analysis
library(data.table)
url_string<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url_string,"power.zip")
unzip("power.zip")
#semicolon-delimited, checking for sources of non-numeric variables shows '?' is an na character
test<-fread(file="household_power_consumption.txt",na.strings = "?")
#str(test)
# the date format is dd/mm/yyyy, based on the str() output, no leading zeroes  
# subset to specified dates 
relevant<-test[((test$Date=="1/2/2007")|(test$Date=="2/2/2007")),]
# number of records=1440x2, i.e., number of minutes in two days - OK
# nrow(relevant)
relevant$times<-as.POSIXct(paste(relevant$Date,relevant$Time),
                           format="%d/%m/%Y %H:%M:%S")
rm("test")


# the below code was used to check for missing values - almost 26K records, 
# none on the relevant dates - same done with relevant has zero records
# bad2<-test[is.na(test$Global_active_power)]
# head(bad2[c(1,2)],20)

png(filename = "plot1.png")
hist(relevant$Global_active_power, col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

dev.off()
