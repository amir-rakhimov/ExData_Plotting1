fname<-"household_power_consumption.txt"
df<-read.table(fname,header = T,sep = ";")

df$Date<-as.Date(df$Date,"%d/%m/%Y")

subdf<-subset(df,Date>="2007-02-01"&Date<="2007-02-02")
str(subdf)

subdf$Sub_metering_1<-as.numeric(subdf$Sub_metering_1)
subdf$Sub_metering_2<-as.numeric(subdf$Sub_metering_2)

subdf$datetime<-paste(subdf$Date,subdf$Time)
subdf$datetime<-strftime(subdf$datetime,format= "%Y-%m-%d %H:%M:%S",usetz=FALSE)
subdf$datetime<-as.POSIXct(subdf$datetime)

subdf$Voltage<-as.numeric(subdf$Voltage)
subdf$Global_active_power<-as.numeric(subdf$Global_active_power)
subdf$Global_reactive_power<-as.numeric(subdf$Global_reactive_power)
png("plot4.png",480,480)
par(mfrow=c(2,2))
# 1
plot(subdf$datetime, subdf$Global_active_power,type="l",
                xaxt="n",xlab="",
                ylab="Global Active Power")
axis(1, 
     at=c(as.POSIXct(min(subdf$datetime),format= "%Y-%m-%d %H:%M:%S",usetz=FALSE),
          as.POSIXct(median(subdf$datetime),format= "%Y-%m-%d %H:%M:%S",usetz=FALSE),
          as.POSIXct(max(subdf$datetime),format= "%Y-%m-%d %H:%M:%S",usetz=FALSE)),
     labels=c("Thu","Fri","Sat"))

# 2
plot(subdf$datetime,subdf$Voltage,type="l",
     xaxt="n",xlab="datetime",ylab="Voltage")
axis(1, 
     at=c(as.POSIXct(min(subdf$datetime),format= "%Y-%m-%d %H:%M:%S",usetz=FALSE),
          as.POSIXct(median(subdf$datetime),format= "%Y-%m-%d %H:%M:%S",usetz=FALSE),
          as.POSIXct(max(subdf$datetime),format= "%Y-%m-%d %H:%M:%S",usetz=FALSE)),
     labels=c("Thu","Fri","Sat"))

# 3
plot(subdf$datetime,subdf$Sub_metering_1, type="l",
     xaxt="n",xlab="",col="black",
     ylab="Energy sub metering")

lines(subdf$datetime, subdf$Sub_metering_2,type="l",
      xaxt="n",xlab="",col="red")
lines(subdf$datetime, subdf$Sub_metering_3,type="l",
      xaxt="n",xlab="",col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       col=c("black","red", "blue"), lty = 1, cex=0.8)
axis(1, 
     at=c(as.POSIXct(min(subdf$datetime),format= "%Y-%m-%d %H:%M:%S",usetz=FALSE),
          as.POSIXct(median(subdf$datetime),format= "%Y-%m-%d %H:%M:%S",usetz=FALSE),
          as.POSIXct(max(subdf$datetime),format= "%Y-%m-%d %H:%M:%S",usetz=FALSE)),
     labels=c("Thu","Fri","Sat"))

# 4
plot(subdf$datetime, subdf$Global_reactive_power,type="l",
     xaxt="n",xlab="datetime",
     ylab="Global_reactive_power")
axis(1, 
     at=c(as.POSIXct(min(subdf$datetime),format= "%Y-%m-%d %H:%M:%S",usetz=FALSE),
          as.POSIXct(median(subdf$datetime),format= "%Y-%m-%d %H:%M:%S",usetz=FALSE),
          as.POSIXct(max(subdf$datetime),format= "%Y-%m-%d %H:%M:%S",usetz=FALSE)),
     labels=c("Thu","Fri","Sat"))
dev.off()
