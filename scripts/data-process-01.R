setwd("/Users/jianyingli/myGit/CTN-0031/csv/")
fn <- list.files(pattern=".csv")
fn

dt.bisa <- read.csv(fn[1])
dt.frsb <- read.csv(fn[12])
dt.gt <- read.csv(fn[16])
dt.ravlt <- read.csv(fn[20])
dt.stroop <- read.csv(fn[22])
dt.wcst <- read.csv(fn[25])

dt.completion <- read.csv(fn[24])
levels(as.factor(dt.completion$TTF1))

getCompletion <- function (dt.in)
{
  dt.in <- dt.completion
  patID <- c()
  patID2 <- c()
data2process <- NULL
  index = 0
  index2 = 0
  dt.temp <- dt.in[,c(6,7,30)]
  for (i in levels(as.factor (dt.temp$patdeid)))
  {
   # i = levels(as.factor(dt.temp$patdeid))[1]
    dm <- dt.temp [dt.temp$patdeid == as.character(i),]
    if (sum (dm$TTF2) >= 7 ){
      index = index + 1
      patID[index] = as.character(i)
    }else if (sum(dm$TTF2) >= 5){
      index2 = index2 + 1
      patID2[index2] = as.character(i)
      data2process <- rbind (data2process, dm)
    }else{
      next;
    }
  }
}


for (i in levels(as.factor(dt.completion$patdeid)))
{print(i)}

dt.dem <- read.csv(fn[4])
colnames(dt.dem)
table(dt.dem$DEM02) #gender
#1: male
#2: female
#03 -- 04x ethnicity

##====================================
## stroop test
#31: Color naming
#31A: minute
#31B: second
#STR31D: total-second  (A+B)

#32 Word reading
#STR32C: total-second (A+B)

#33 Interference Trial
#STR33D: total-second (A+B)

## ravlt
# 6 trails with xR indicates existing or not

##======================================


stroop.dt <- dt.stroop[,c(28,12,18,24)]


ravlt.dt <- dt.ravlt[c(which(dt.ravlt$RAVLT2R!=98)),c(7,9,11,13,15,17,19,22)]

colnames(dt.gt)
summary(dt.gt)
##====================================================
colnames(dt.ravlt)
summary(dt.ravlt)

# 6 trails with xR indicates existing or not
dt.ravlt$RAVLT1[which(dt.ravlt$RAVLT1R!=98)]
dt.ravlt$RAVLT2[which(dt.ravlt$RAVLT2R!=98)]
dt.ravlt$RAVLT3[which(dt.ravlt$RAVLT3R!=98)]
dt.ravlt$RAVLT4[which(dt.ravlt$RAVLT4R!=98)]
dt.ravlt$RAVLT5[which(dt.ravlt$RAVLT5R!=98)]
dt.ravlt$RAVLTB[which(dt.ravlt$RAVLTBR!=98)]
dt.ravlt$RAVLT6[which(dt.ravlt$RAVLT6R!=98)]

ravlt.dt <- dt.ravlt[c(which(dt.ravlt$RAVLT2R!=98)),c(7,9,11,13,15,17,19,22)]


##========================================
colnames(dt.stroop)
dt.stroop$STR21
summary(dt.stroop)
