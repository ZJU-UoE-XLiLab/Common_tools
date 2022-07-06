print("Enter mutation sequence from 3' to 5', start position of the mutation region, and end position of the mutation region")
print("After each input, type Enter. Type Enter twice after the third input to terminate the scanning process")

seq <- scan(what='')
s <- as.numeric(seq[2])
e <- as.numeric(seq[3])
seq <- toupper(seq[1])

outputl <- list()
for (i in seq(s,e,1)){
  mut <- substr(seq,i,i)
  if (mut == "A"){
      sub <- "B"
    }else if (mut == "T"){
      sub <- "V" 
    }else if (mut == "C"){
      sub <- "D"
    }else{
      sub <- "H"
    }
  for (fl in seq(8,13)){
    achieve <- 0
    for (fr in seq(8,13)){
      #flanking region 8-13
      ff <- substr(seq,i-1-fl,i-1)
      bf <- substr(seq,i+1,i+1+fr)
      primer <- paste0(ff,sub,bf)
      Tm <- (str_count(primer,"A")+str_count(primer,"T"))*2+(str_count(primer,"G")+str_count(primer,"C"))*4
      cg <- (str_count(primer,"G")+str_count(primer,"C"))/(str_count(primer,"A")+str_count(primer,"T"))
      if (Tm < 55 | Tm > 65 | cg < 0.45 | cg > 0.55){
        if (fl==13 & fr==13){
          print(paste0("no primer is appropriate in position",i)) 
          }
        }else{
          output <- c(primer,Tm,fl+fr+1,i)
          len <- length(outputl)
          outputl[[len+1]] <- output
          achieve <- 1
          break
        }
    if (achieve == 1){
      break
      }
      }
    }
} 

primer <- c()
Tm <- c()
len <- c()
pos <- c()
for (i in 1:length(outputl)){
  primer <- c(primer,outputl[[i]][1])
  Tm <- c(Tm,outputl[[i]][2])
  len <- c(len,outputl[[i]][3])
  pos <- c(pos,outputl[[i]][4])
  df <- data.frame(primer=primer,Tm=Tm,primer_length=len,position=pos)
}