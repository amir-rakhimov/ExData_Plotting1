fname<-"household_power_consumption.txt"
df<-read.table(fname,header = T,sep = ";")
df$Date<-as.Date(df$Date,"%d/%m/%Y")

subdf<-subset(df,Date>="2007-02-01"&Date<="2007-02-02")
subdf$Global_active_power<-as.numeric(subdf$Global_active_power)

png("plot1.png",width = 480,height = 480)
with(subdf,hist(Global_active_power,col="red",
                xlab="Global Active Power (kilowatts)",
                main="Global Active Power"))
dev.off()

