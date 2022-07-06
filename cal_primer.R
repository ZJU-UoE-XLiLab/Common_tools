##!/usr/bin/env Rscript
library(stringr)
args <- commandArgs(trailingOnly=TRUE)
seq <- toupper(args[1])
s <- as.numeric(args[2])
e <- as.numeric(args[3])
seql <- nchar(seq)
start <- seql - e
end <- seql - s


outputl <- list()
for (i in seq(start,end,1)){
  wt <- substr(seq,i,i)
  if (wt == "A"){
      sub <- "B"
    }else if (wt == "T"){
      sub <- "V" 
    }else if (wt == "C"){
      sub <- "D"
    }else{
      sub <- "H"
    }
  for (fl in seq(8,20)){
    achieve <- 0
    for (fr in seq(8,20)){
      #flanking region 8-13
      ff <- substr(seq,i-1-fl,i-1)
      bf <- substr(seq,i+1,i+1+fr)
      primer <- paste0(ff,sub,bf)
      Tm <- (str_count(primer,"A")+str_count(primer,"T"))*2+(str_count(primer,"G")+str_count(primer,"C"))*4
      gc <- round((str_count(primer,"G")+str_count(primer,"C"))/(str_count(primer,"A")+str_count(primer,"T")+str_count(primer,"G")+str_count(primer,"C")),2)
      if (Tm < 55 | Tm > 65 ){
        if (fl==20 & fr==20){
          print(paste0("no primer is appropriate in position",i)) 
          }
        }
      else{
          output <- c(primer,Tm,fl+fr+1,gc,i)
          len <- length(outputl)
          outputl[[len+1]] <- output
          achieve <- 1
          break
        }
      }
    if (achieve == 1){
      break
      }
    }
  } 

primer <- c()
Tm <- c()
len <- c()
GC <- c()
pos <- c()
for (i in 1:length(outputl)){
  primer <- c(primer,outputl[[i]][1])
  Tm <- c(Tm,outputl[[i]][2])
  len <- c(len,outputl[[i]][3])
  GC <- c(GC,outputl[[i]][4])
  pos <- c(pos,seql-as.numeric(outputl[[i]][5]))
  df <- data.frame(primer=primer,Tm=Tm,primer_length=len,GC_content=GC,position=pos)
}
write.csv(df,"Primers.csv")