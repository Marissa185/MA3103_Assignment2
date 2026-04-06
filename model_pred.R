iqtree3 <- read.csv("~/Downloads/bioinfo/iqtree3.csv", sep="")

min(iqtree3$BIC)
max(iqtree3$BIC)
model <- iqtree3$Model

BIC <- iqtree3$BIC

# barplot(BIC,
#         names.arg=model,
#         las=2,
#         col="lightblue",
#         main="Model Comparison (BIC)",
#         ylab="BIC score")

best <- which.min(BIC)

barplot(BIC,
        names.arg=model,
        las=2,
        col=ifelse(1:length(BIC)==best, "red", "lightblue"))
