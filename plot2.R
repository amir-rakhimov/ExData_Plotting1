fname<-"household_power_consumption.txt"
df<-read.table(fname,header = T,sep = ";")

df$Date<-as.Date(df$Date,"%d/%m/%Y")

subdf<-subset(df,Date>="2007-02-01"&Date<="2007-02-02")
subdf$Global_active_power<-as.numeric(subdf$Global_active_power)

subdf$datetime<-paste(subdf$Date,subdf$Time)
subdf$datetime<-strftime(subdf$datetime,format= "%Y-%m-%d %H:%M:%S",usetz=FALSE)
subdf$datetime<-as.POSIXct(subdf$datetime)

png("plot2.png",width = 480,height = 480)
with(subdf,plot(datetime, Global_active_power,type="l",
                xaxt="n",xlab="",
                ylab="Global Active Power (kilowatts)"))
axis(1, 
     at=c(as.POSIXct(min(subdf$datetime),format= "%Y-%m-%d %H:%M:%S",usetz=FALSE),
          as.POSIXct(median(subdf$datetime),format= "%Y-%m-%d %H:%M:%S",usetz=FALSE),
          as.POSIXct(max(subdf$datetime),format= "%Y-%m-%d %H:%M:%S",usetz=FALSE)),
     labels=c("Thu","Fri","Sat"))
dev.off()
