#File for preprocessing the data


library(MetFns)
library(lubridate)
library(data.table)


#Input session and rate data
data_2016 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2016/Rate-IMO-VMDB-Year-2016.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2016/Session-IMO-VMDB-Year-2016.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_2015 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2015/Rate-IMO-VMDB-Year-2015.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2015/Session-IMO-VMDB-Year-2015.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_2014 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2014/Rate-IMO-VMDB-Year-2014.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2014/Session-IMO-VMDB-Year-2014.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_2013 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2013/Rate-IMO-VMDB-Year-2013.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2013/Session-IMO-VMDB-Year-2013.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_2012 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2012/Rate-IMO-VMDB-Year-2012.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2012/Session-IMO-VMDB-Year-2012.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_2011 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2011/Rate-IMO-VMDB-Year-2011.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2011/Session-IMO-VMDB-Year-2011.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_2010 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2010/Rate-IMO-VMDB-Year-2010.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2010/Session-IMO-VMDB-Year-2010.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_2009 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2009/Rate-IMO-VMDB-Year-2009.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2009/Session-IMO-VMDB-Year-2009.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_2008 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2008/Rate-IMO-VMDB-Year-2008.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2008/Session-IMO-VMDB-Year-2008.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_2007 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2007/Rate-IMO-VMDB-Year-2007.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2007/Session-IMO-VMDB-Year-2007.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_2006 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2006/Rate-IMO-VMDB-Year-2006.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2006/Session-IMO-VMDB-Year-2006.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_2005 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2005/Rate-IMO-VMDB-Year-2005.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2005/Session-IMO-VMDB-Year-2005.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_2004 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2004/Rate-IMO-VMDB-Year-2004.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2004/Session-IMO-VMDB-Year-2004.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_2003 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2003/Rate-IMO-VMDB-Year-2003.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2003/Session-IMO-VMDB-Year-2003.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_2002 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2002/Rate-IMO-VMDB-Year-2002.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2002/Session-IMO-VMDB-Year-2002.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_2001 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2001/Rate-IMO-VMDB-Year-2001.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2001/Session-IMO-VMDB-Year-2001.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_2000 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2000/Rate-IMO-VMDB-Year-2000.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2000/Session-IMO-VMDB-Year-2000.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_1999 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1999/Rate-IMO-VMDB-Year-1999.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1999/Session-IMO-VMDB-Year-1999.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_1998 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1998/Rate-IMO-VMDB-Year-1998.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1998/Session-IMO-VMDB-Year-1998.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_1997 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1997/Rate-IMO-VMDB-Year-1997.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1997/Session-IMO-VMDB-Year-1997.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_1996 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1996/Rate-IMO-VMDB-Year-1996.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1996/Session-IMO-VMDB-Year-1996.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_1995 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1995/Rate-IMO-VMDB-Year-1995.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1995/Session-IMO-VMDB-Year-1995.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_1994 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1994/Rate-IMO-VMDB-Year-1994.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1994/Session-IMO-VMDB-Year-1994.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_1993 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1993/Rate-IMO-VMDB-Year-1993.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1993/Session-IMO-VMDB-Year-1993.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_1992 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1992/Rate-IMO-VMDB-Year-1992.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1992/Session-IMO-VMDB-Year-1992.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_1991 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1991/Rate-IMO-VMDB-Year-1991.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1991/Session-IMO-VMDB-Year-1991.csv')[,c(3,8,9,10)], by = 'User.ID'))
data_1990 <- unique(merge(read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1990/Rate-IMO-VMDB-Year-1990.csv')[,c(2,4,5,6,7,8,9,10,11,12,13)], read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1990/Session-IMO-VMDB-Year-1990.csv')[,c(3,8,9,10)], by = 'User.ID'))



df <- rbind.data.frame(data_1990, data_1991, data_1992, data_1993, data_1994, data_1995, data_1996, data_1997, data_1998, data_1999, data_2000, data_2001, data_2002, data_2003, data_2004, data_2005, data_2006, data_2007, data_2008, data_2009, data_2010, data_2011, data_2012, data_2013, data_2014, data_2015, data_2016)





mag_2016 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2016/Magnitude-IMO-VMDB-Year-2016.csv')[,c(4:19)]
mag_2015 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2015/Magnitude-IMO-VMDB-Year-2015.csv')[,c(4:19)]
mag_2014 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2014/Magnitude-IMO-VMDB-Year-2014.csv')[,c(4:19)]
mag_2013 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2013/Magnitude-IMO-VMDB-Year-2013.csv')[,c(4:19)]
mag_2012 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2012/Magnitude-IMO-VMDB-Year-2012.csv')[,c(4:19)]
mag_2011 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2011/Magnitude-IMO-VMDB-Year-2011.csv')[,c(4:19)]
mag_2010 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2010/Magnitude-IMO-VMDB-Year-2010.csv')[,c(4:19)]
mag_2009 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2009/Magnitude-IMO-VMDB-Year-2009.csv')[,c(4:19)]
mag_2008 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2008/Magnitude-IMO-VMDB-Year-2008.csv')[,c(4:19)]
mag_2007 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2007/Magnitude-IMO-VMDB-Year-2007.csv')[,c(4:19)]
mag_2006 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2006/Magnitude-IMO-VMDB-Year-2006.csv')[,c(4:19)]
mag_2005 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2005/Magnitude-IMO-VMDB-Year-2005.csv')[,c(4:19)]
mag_2004 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2004/Magnitude-IMO-VMDB-Year-2004.csv')[,c(4:19)]
mag_2003 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2003/Magnitude-IMO-VMDB-Year-2003.csv')[,c(4:19)]
mag_2002 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2002/Magnitude-IMO-VMDB-Year-2002.csv')[,c(4:19)]
mag_2001 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2001/Magnitude-IMO-VMDB-Year-2001.csv')[,c(4:19)]
mag_2000 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-2000/Magnitude-IMO-VMDB-Year-2000.csv')[,c(4:19)]
mag_1999 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1999/Magnitude-IMO-VMDB-Year-1999.csv')[,c(4:19)]
mag_1998 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1998/Magnitude-IMO-VMDB-Year-1998.csv')[,c(4:19)]
mag_1997 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1997/Magnitude-IMO-VMDB-Year-1997.csv')[,c(4:19)]
mag_1996 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1996/Magnitude-IMO-VMDB-Year-1996.csv')[,c(4:19)]
mag_1995 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1995/Magnitude-IMO-VMDB-Year-1995.csv')[,c(4:19)]
mag_1994 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1994/Magnitude-IMO-VMDB-Year-1994.csv')[,c(4:19)]
mag_1993 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1993/Magnitude-IMO-VMDB-Year-1993.csv')[,c(4:19)]
mag_1992 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1992/Magnitude-IMO-VMDB-Year-1992.csv')[,c(4:19)]
mag_1991 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1991/Magnitude-IMO-VMDB-Year-1991.csv')[,c(4:19)]
mag_1990 <- read.csv2('/home/cfrce/Documents/Viswesh/MeteorShowerPrediction/Datasets/IMO-VMDB-Year-1990/Magnitude-IMO-VMDB-Year-1990.csv')[,c(4:19)]

mag <- rbind.data.frame(mag_1990, mag_1991, mag_1992, mag_1993, mag_1994, mag_1995, mag_1996, mag_1997, mag_1998, mag_1999, mag_2000, mag_2001, mag_2002, mag_2003, mag_2004, mag_2005, mag_2006, mag_2007, mag_2008, mag_2009, mag_2010, mag_2011, mag_2012, mag_2013, mag_2014, mag_2015, mag_2016)

# setDF(df)
# setDF(mag)
# 
# df <- merge(df, mag, by = 'Start.Date')

setDT(df)
setDT(mag)

df[,Solar.Long := solar.long(df$Start.Date)]
#mag[, Population.Index := pop.index(mag, mag$Start.Date, mag$End.Date, mag$Shower, k = 0.1)]

setDF(df)
df_nodupl = df[!duplicated(df[1:11]),]

setDT(df_nodupl)
df_nodupl[,Solar.Long := solar.long(df_nodupl$Start.Date)]

write.csv2(df_nodupl,'Preprocessed_data.csv')