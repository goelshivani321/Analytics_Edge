getwd()
quality = read.csv("quality.csv")
summary(quality)
str(quality)
install.packages("caTools")
library(caTools)
set.seed(88)
split = sample.split(quality$PoorCare,SplitRatio = 0.75)
split
str(split)
qualityTrain = subset(quality, split == TRUE)
qualityTest = subset(quality, split == FALSE)
QualityLog = glm(PoorCare ~ StartedOnCombination + ProviderCount, data=qualityTrain, family=binomial)
summary(QualityLog)
QualityLog = glm(PoorCare ~ OfficeVisits + Narcotics , data=qualityTrain, family=binomial)
install.packages("ROCR")
library(ROCR)
predictTest = predict(QualityLog, type="response", newdata=qualityTest)
summary(predictTest)
predictTest = predict(QualityLog, type="response", newdata=qualityTest)
ROCRpredTest = prediction(predictTest, qualityTest$PoorCare)
auc = as.numeric(performance(ROCRpredTest, "auc")@y.values)
auc
