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

# subsetting Global_active_power column in the dataset
sub_epcdata <- subset(epcdata, Date == "2007-02-01"| Date == "2007-02-02", "Global_active_power")
dim(sub_epcdata)
head(sub_epcdata)
class(sub_epcdata)
gapower <- sub_epcdata$Global_active_power

## Create hist on screen device 
hist(gapower,col = "red", main = "Global Active Power",xlab="Global Active Power (kilowatts)")  ## Create hist on screen device 

## Copy my plot to a PNG file
dev.copy(png, file = "plot1.png")  

## Closing the PNG device
dev.off()  





