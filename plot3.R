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
sub_epcdata <- subset(epcdata, Date == "2007-02-01"| Date == "2007-02-02", c("Date","Time","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dim(sub_epcdata)
head(sub_epcdata)
class(sub_epcdata)
str(sub_epcdata)

sub_epcdata1 <- within(sub_epcdata, { timestamp=format(as.POSIXct(paste(sub_epcdata$Date, sub_epcdata$Time)), "%Y-%m-%d %H:%M:%S") })
head(sub_epcdata1)
str(sub_epcdata1)

## Create plot on screen device 
now_ct <- as.POSIXct(sub_epcdata1$timestamp,tz="GMT","%Y-%m-%d %H:%M:%S")
plot(sub_epcdata1$Sub_metering_1 ~ now_ct,xlab="",ylab="Energy sub metering",type="l")
lines(now_ct,sub_epcdata1$Sub_metering_2,col="red")
lines(now_ct,sub_epcdata1$Sub_metering_3,col="blue")

legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1),lwd=c(2.5,2.5,2.5),col=c("black","red","blue"),inset = 0)

## Copy my plot to a PNG file
dev.copy(png, file = "plot3.png")  

## Closing the PNG device
dev.off()  
