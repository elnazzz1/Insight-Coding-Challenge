filelist <- list.files(path = "/home/fatemeh/Downloads/H1B/",pattern = "*.csv")
for (i in 1:length(filelist)) {
  filepath[i] <- paste("/home/fatemeh/Downloads/H1B/",filelist[i],sep = "")
  H1B <- read.csv(filepath[i],sep = ";")

#______________________     Top 10 occupations for certified visa applications ________________________

#H1B <- read.csv("/home/fatemeh/Downloads/H1B_FY_2014.csv",sep = ";")
jobs <- data.frame(table(H1B$LCA_CASE_SOC_NAME))
jobs$acceptance <- 0 
for (i in 1:nrow(jobs)) {
  temp <- H1B[H1B$LCA_CASE_SOC_NAME==jobs$Var1[i],]
  certified <- temp$STATUS == "CERTIFIED"
  jobs$acceptance[i] <- nrow(temp[certified,])
}
jobs <- jobs[order(-jobs$acceptance),]
toptenjob <- jobs[1:10,]
total_certified <- sum(H1B$STATUS == "CERTIFIED")
toptenjob$percentage <- (toptenjob$acceptance / total_certified)*100
output1 <- character(length = 10)
header <- "TOP_OCCUPATIONS;NUMBER_CERTIFIED_APPLICATIONS;PERCENTAGE "
output1 <- paste(toptenjob$Var1,toptenjob$acceptance,paste(toptenjob$percentage,"%",sep = ""),sep = ";")
output1 <- c(header,output1)
print(output1)

#______________________   Top 10 states for certified visa applications  ________________________

states <- data.frame(table(H1B$LCA_CASE_EMPLOYER_STATE))
states$acceptance <- 0 
for (i in 1:nrow(states)) {
  temp <- H1B[H1B$LCA_CASE_EMPLOYER_STATE==states$Var1[i],]
  certified <- temp$STATUS == "CERTIFIED"
  states$acceptance[i] <- nrow(temp[certified,])
}

states <- states[order(-states$acceptance),]
toptenstates <- states[1:10,]
#total_certified <- sum(H1B$STATUS == "CERTIFIED")
toptenstates$percentage <- (toptenstates$acceptance / total_certified)*100
output2 <- character(length = 10)
header <- "TOP_STATES;NUMBER_CERTIFIED_APPLICATIONS;PERCENTAGE"
output2 <- paste(toptenstates$Var1,toptenstates$acceptance,paste(toptenstates$percentage,"%",sep = ""),sep = ";")
output2 <- c(header,output2)
print(output2)
#____________________________________________________________________________________________________
}