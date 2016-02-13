# downloading file

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)

# loading data into R
epcdata <- read.table(unz(temp, "household_power_consumption.txt"),na.strings=c("?","","NA"),sep=";",strip.white = TRUE,header=T,stringsAsFactors = F)

unlink(temp)

head(epcdata)
dim(epcdata)
names(epcdata)
str(epcdata)

# removing dataset missing values
epcdata <- na.omit(epcdata)

# converting the Date variable to Date class
epcdata$Date <- as.Date(epcdata$Date,"%d/%m/%Y")
head(epcdata$Date)
class(epcdata$Date)
str(epcdata)

# subsetting Date, Time and Global_active_power columns in the dataset
sub_epcdata <- subset(epcdata, Date == "2007-02-01"| Date == "2007-02-02", c("Date","Time","Global_active_power","Voltage","Sub_metering_1","Sub_metering_2","Sub_metering_3","Global_reactive_power"))
dim(sub_epcdata)
head(sub_epcdata)
class(sub_epcdata)
str(sub_epcdata)

sub_epcdata1 <- within(sub_epcdata, { timestamp=format(as.POSIXct(paste(sub_epcdata$Date, sub_epcdata$Time)), "%Y-%m-%d %H:%M:%S") })
head(sub_epcdata1)
str(sub_epcdata1)

par(mfrow=c(2, 2))

## Create plot_top/left on screen device 
now_ct <- as.POSIXct(sub_epcdata1$timestamp,tz="GMT","%Y-%m-%d %H:%M:%S")
plot(sub_epcdata1$Global_active_power ~ now_ct,xlab="",ylab="Global Active Power (kilowatts)",type="l")

## Create plot_top/right on screen device 
plot(sub_epcdata1$Voltage ~ now_ct,xlab="datetime",ylab="Voltage",type="l")

## Create plot_bottom/left on screen device 
plot(sub_epcdata1$Sub_metering_1 ~ now_ct,xlab="",ylab="Energy sub metering",type="l")
lines(now_ct,sub_epcdata1$Sub_metering_2,col="red")
lines(now_ct,sub_epcdata1$Sub_metering_3,col="blue")

legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1),lwd=c(2.5,2.5,2.5),col=c("black","red","blue"),cex = 0.45)

## Create plot_bottom/right on screen device 
plot(sub_epcdata1$Global_reactive_power ~ now_ct,xlab="datetime",ylab="Global_reactive_power",type="l")

## Copy my plot to a PNG file
dev.copy(png, file = "plot4.png")  

## Closing the PNG device
dev.off()  


