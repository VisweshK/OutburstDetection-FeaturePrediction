
# Taking the non duplicated data and removing all outliers across the years 
# adding into a dataframe. This should enable greater accuracy in prediction

#library(outliers)
library(data.table)

all_data = list('1990' = data_1990, '1991' = data_1991, '1992' = data_1992, '1993' = data_1993, '1994' = data_1994, '1995' = data_1995, '1996' = data_1996, '1997' = data_1997, '1998' = data_1998, '1999' = data_1999,
                '2000' = data_2000, '2001' = data_2001, '2002' = data_2002, '2003' = data_2003, '2004' = data_2004, '2005' = data_2005, '2006' = data_2006, '2007' = data_2007, '2008' = data_2008, '2009' = data_2009, 
                '2010' = data_2010, '2011' = data_2011, '2012' = data_2012, '2013' = data_2013, '2014' = data_2014, '2015' = data_2015, '2016' = data_2016)

# Processes each year data for cross-referencing

all_data = lapply(all_data, function(x) x <- x[!duplicated(x[1:11]),])
all_data = lapply(all_data, function(x) setDT(x))
all_data = lapply(all_data, function(x) x <- x[,Month := month(x$Start.Date)])
all_data = lapply(all_data, function(x) x <- x[,c(11,15)])

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
outlier_Month_Year = findOutlier(df_N_vs_S)

# Converting to data table and saving month and year

tempdf <- df_nodupl
setDT(tempdf)
tempdf = tempdf[,Month := month(tempdf$Start.Date)]
tempdf = tempdf[,Year := (year(tempdf$Start.Date) - 1989)]
setDF(tempdf)
outlierdf <- subset(tempdf, tempdf$Year == unlist(outlier_Month_Year[tempdf$Month]))

