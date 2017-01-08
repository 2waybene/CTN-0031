
logits.test.random <- function (dm)
{
 # dm <- stroop.f.dt[,-1]
 # dim(dm)
#  colnames(dm)
  completion <- sample(c(1,0), dim(dm)[1], replace = T)
  dt.4.test <- cbind (completion, dm)
 # colnames(dt.4.test)
  glm.out = glm(completion ~ STR31D + STR32C + STR33D, family=binomial(logit), 
              data=dt.4.test)
  return(glm.out)
}

table(dt.dem$DEM02) #gender: 1 -- male; 2 -- female
colnames(dt.dem)
female.patients.id <- dt.dem$patdeid[dt.dem$DEM02==2]

stroop.f.dt <- stroop.dt[stroop.dt$patdeid %in% female.patients.id ,]
test <- logits.test.random (stroop.f.dt)
summary(test)
