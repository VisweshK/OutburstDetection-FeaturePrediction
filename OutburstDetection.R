
# Taking the non duplicated data and removing all outliers across the years 
# adding into a dataframe. This should enable greater accuracy in prediction

library(outliers, verbose = TRUE)
library(dplyr, verbose = TRUE)
library(lubridate, verbose = TRUE)
library(data.table, verbose = TRUE)


all_data = list('1990' = data_1990, '1991' = data_1991, '1992' = data_1992, '1993' = data_1993, '1994' = data_1994, '1995' = data_1995, '1996' = data_1996, '1997' = data_1997, '1998' = data_1998, '1999' = data_1999,
                '2000' = data_2000, '2001' = data_2001, '2002' = data_2002, '2003' = data_2003, '2004' = data_2004, '2005' = data_2005, '2006' = data_2006, '2007' = data_2007, '2008' = data_2008, '2009' = data_2009, 
                '2010' = data_2010, '2011' = data_2011, '2012' = data_2012, '2013' = data_2013, '2014' = data_2014, '2015' = data_2015, '2016' = data_2016)

# Removing Duplicate entries

all_data = lapply(all_data, function(x) x <- x[x$Number != 0,])
all_data = lapply(all_data, function(x) setDT(x))
all_data = lapply(all_data, function(x) x <- x[,Month := month(x$Start.Date)])
all_data = lapply(all_data, function(x) x <- x[,Day := day(x$Start.Date)])
all_data = lapply(all_data, function(x) setDF(x))
all_data = lapply(all_data, function(x) x <- x[!duplicated.data.frame(x[c(4,5,9,15,16)]),])
all_data = lapply(all_data, function(x) x <- x[,c(11,15)])
all_data = lapply(all_data, function(x) setDT(x))

Number_vs_Shower = matrix(data = NA, nrow = 27, ncol = 12)

# Creates matrix of number count for each month every year

for(i in 1:27)
{
  current_df = all_data[[i]]
  for(j in 1:12)
  {
    Number_vs_Shower[i,j] = colSums(current_df[current_df$Month == j])[1]
  }
}


# Finding Outliers function
findOutlier <- function(data, cutoff = 2.5) {
  ## Calculate the sd
  sds <- apply(data, 2, sd, na.rm = TRUE)
  ## Identify the cells with value greater than cutoff * sd (column wise)
  result <- mapply(function(d, s) {
    which(d > cutoff * s)
  }, data, sds)
  result
}

# Setting up list with outlier months

df_N_vs_S = data.frame(Number_vs_Shower)
outlier_Month_Year_Logi = scores(df_N_vs_S) > 0.8
outlier_Month_Year_list <- list()

for(i in 1:12){
  temp <- c()
  for(j in 1:27){
    if(outlier_Month_Year_Logi[j,i]){  #df_N_vs_S[j,i] > (3*mean(Number_vs_Shower[,i]) - 2*median(Number_vs_Shower[,i]
      temp = append(temp,j)
    }
  }
  outlier_Month_Year_list[[i]] <- temp
}


# Converting to data table and saving month and year

tempdf <- df_nodupl
tempdf <- tempdf[tempdf$Number != 0]
setDT(tempdf)
tempdf = tempdf[,Month := month(tempdf$Start.Date)]
tempdf = tempdf[,Year := (year(tempdf$Start.Date) - 1989)]
tempdf = tempdf[,ZHR := tempdf$Number/as.double((difftime(time1 = as.POSIXlt(tempdf$End.Date), time2 = as.POSIXlt(tempdf$Start.Date), units = 'hours')))]


# Remove month entries with possible outliers

setDT(tempdf)
outliers_in_month_df <- subset(tempdf, Year %in% unlist(outlier_Month_Year_list[Month]))

#   Have to find outliers for each dataset
#   outlier_Number_values <- unlist(findOutlier(outliers_in_month_df)['Number'])

# Removing outliers
removeOutlier <- function(data, outliers) {
  result <- mapply(function(d, o) {
    res <- d
    res[o] <- NA
    return(res)
  }, data, outliers)
  return(as.data.frame(result))
}

outlierdf <- subset(outliers_in_month_df, User.ID == -1)

for(i in 1:27)
{
  for(j in 1:12)
  {
    temp <- unlist(findOutlier(subset(outliers_in_month_df, Month == j & Year == i), cutoff = 1)['ZHR'], use.names = FALSE)
    outlierdf <- rbind(outlierdf, subset(outliers_in_month_df, Month == j & Year == i)[temp])
  }
  print(i)
}

df_nodupl <- df[df$Number != 0]
normaldf <- df_nodupl
setDT(normaldf)
normaldf = normaldf[, Month := month(normaldf$Start.Date)]
normaldf = normaldf[, Year := (year(normaldf$Start.Date) - 1989)]
normaldf = normaldf[,ZHR := normaldf$Number/as.double((difftime(time1 = as.POSIXlt(normaldf$End.Date), time2 = as.POSIXlt(normaldf$Start.Date), units = 'hours')))]
normaldf <- anti_join(normaldf, outlierdf)
setDF(normaldf)
normaldf <- normaldf[!duplicated.data.frame(normaldf[c(4,5,9,15,16)]),]

# Creating the same Number_vs_Shower without the outlier data

tempdf <- normaldf
tempdf <- tempdf[, c(11,15,16)]
setDF(tempdf)

Number_vs_Shower_withoutOutlier = matrix(data = NA, nrow = 27, ncol = 12)

# Creates matrix of number count for each month every year

for(i in 1:27)
{
  for(j in 1:12)
  {
    Number_vs_Shower_withoutOutlier[i,j] = colSums(subset(tempdf, Month == j & Year == i))[1]
  }
  print(i)
}

#Plotting
matplot(t(Number_vs_Shower), xlab = 'Month', ylab = 'Meteor Count', ylim = c(0,50000))
matplot(t(Number_vs_Shower_withoutOutlier), xlab = 'Month', ylab = 'Meteor Count', ylim = c(0,50000))
plot(1:92, table(normaldf$Number), type = 'l', xlab = 'Meteor Count', ylab = 'Count', xlim = c(0,70))


write.csv2(normaldf_ordered, 'WithoutOutliers.csv')
write.csv2(outlierdf, 'Outliers.csv')
