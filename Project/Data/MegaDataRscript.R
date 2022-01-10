library(haven)
megadata<-read_dta("csv_combined.dta")
re<-aggregate(NIC~month+year+id,megadata,sum)
write.csv(re, file = "MonthlyAggregateNHSnic.csv")

megadata<-read_dta("csv_combined.dta")
re_alt<-aggregate(NIC~month+year+BNFSectionName+id,megadata,sum)
write.csv(re_alt, file = "MonthlyAggregateNHSnicByCategory.csv")

yrly_re_alt<-aggregate(NIC~year+BNFSectionName+id,megadata,sum)
write.csv(re_alt, file = "YearlyAggregateNHSnicByCategory.csv")

