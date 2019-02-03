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

# fourth plot 
png(filename = "plot4.png")
par(mfcol=c(2,2))
 # (1,1)
with(relevant, plot(times,Global_active_power,type='n',
                    xlab="", ylab="Global Active Power") )
with(relevant, lines(times,Global_active_power))

# (2,1)
with(relevant, plot(times,pmax(0,Sub_metering_1,Sub_metering_2,Sub_metering_3), type='n',
                    xlab="",    ylab="Energy sub metering"))
with(relevant, lines(times,Sub_metering_1, col='grey',lwd=2))
with(relevant, lines(times,Sub_metering_2, col='red'))
with(relevant, lines(times,Sub_metering_3, col='blue'))
leg.txt=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
leg.col=c("grey","red","blue")
leg.lwd=c(2,1,1)
legend("topright",legend=leg.txt,col=leg.col,lty=1,lwd=leg.lwd)

# (1,2)
with(relevant, plot(times,Voltage, type='n',xlab="datetime"))
with(relevant, lines(times,Voltage))

# (2,2)
with(relevant, plot(times,Global_reactive_power, type='n',xlab="datetime"))
with(relevant, lines(times,Global_reactive_power))

dev.off()
