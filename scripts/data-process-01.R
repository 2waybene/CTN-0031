setwd("/Users/li11/myGit/CTN-0031/csv/")
fn <- list.files(pattern=".csv")
fn

dt.bisa <- read.csv(fn[1])
dt.frsb <- read.csv(fn[12])
dt.gt <- read.csv(fn[16])
dt.ravlt <- read.csv(fn[20])
dt.stroop <- read.csv(fn[22])
dt.wcst <- read.csv(fn[25])



##======================================
## Process the completion status
##======================================
dt.completion <- read.csv(fn[24])
#levels(as.factor(dt.completion$TTF1))


list.index = 0
pids <- c()
status <- c()

patID <- c()
patID2 <- c()
index = 0
index2 = 0


  dt.temp <- dt.completion[,c(6,7,30)]
  
  for (i in levels(as.factor (dt.temp$patdeid)))
  {
    dm <- dt.temp [dt.temp$patdeid == as.character(i),]
    if (sum (dm$TTF2) >= 5)
      {
        index = index + 1
        patID[index] = as.character(i)
        list.index = list.index + 1
        temp <- list ("pid" = patID[index], "completion"  = 1)
        completion <- append(completion, temp)
      }else {
        index2 = index2 + 1
        patID2[index2] = as.character(i)
        list.index = list.index + 1
        pids[list.index] = patID2[index2]
        status[list.index] = 0
      }
    }

completion <- list ("pids" = as.vector(as.character(pids)), "completion" = as.vector(status))
write.table (as.data.frame(completion), file = "completion-processed.txt", col.names = T, row.names = F, sep = "\t")

##========Finished completion==========================================


##====================================
##  Getting demorgraphic information
##====================================


##========================
##  gender information
##========================
dt.dem <- read.csv(fn[4])
colnames(dt.dem)
table(dt.dem$DEM02) #gender
#1: male
#2: female
#03 -- 04x ethnicity

gender.info <- dt.dem[,c(6,19)]
str(gender.info)


dt.w.gender  <- merge(gender.info, completion, by.x = "patdeid", by.y = "pids")
colnames(dt.w.gender)[2] <- "Gender"

#Male completion
table(dt.w.gender[which(dt.w.gender$Gender ==1),]$completion)


#Female completion
table(dt.w.gender[which(dt.w.gender$Gender ==2),]$completion)

write.table(dt.w.gender, file = "Gender-completion.txt", col.names = T, row.names = F, sep ="\t")
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
dt.stroop <- read.csv(fn[22])
stroop.dt <- dt.stroop[,c(28,12,18,24)]

(stroop.dt$patdeid %in% completion$pids)

f.merged <- merge(stroop.dt, completion, by.x = "patdeid", by.y = "pids")
str(f.merged)
str (dt.w.gender)

f.merged.2 <- merge (f.merged, dt.w.gender, by.x = "patdeid", by.y = "patdeid")
dim(f.merged.2)
f.merged.2 <- f.merged.2 [,-5]
colnames(f.merged.2)[6] <- "completion"

with(f.merged.2, tapply(STR31D, completion, mean))
with(f.merged.2, tapply(STR32C, completion, mean))
with(f.merged.2, tapply(STR33D, completion, mean))

data.4.test.male <- f.merged.2[which(f.merged.2[5] == 1),]
data.4.test.female <- f.merged.2[which(f.merged.2[5] == 2),]


##  trying to fit a logistic model on stroop test
glm.out = glm(completion ~ STR31D * STR32C * STR33D, family=binomial(logit), data=f.merged)
summary(glm.out)

##  trying to fit a logistic model on stroop test
glm.out.f = glm(completion ~ STR31D * STR32C * STR33D, family=binomial(logit), data=data.4.test.female)
summary(glm.out.f)

##  trying to fit a logistic model on stroop test
glm.out.m = glm(completion ~ STR31D * STR32C * STR33D, family=binomial(logit), data=data.4.test.male)
summary(glm.out.m)


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
