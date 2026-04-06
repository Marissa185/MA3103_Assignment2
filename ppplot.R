# # clustalo
# set
# d <- read.table("work/5_homo/_Summary.csv",
#                    header=TRUE,
#                    sep=",",
#                    skip=6)
# head(d)
# p_values <- d$p
# observed <- sort(p_values)
# 
# pdf(height=4, width=3.5, file="P-values.pdf")
# expected <- seq(0, 1, length.out = length(observed))
# a <- plot(expected, observed,
#      main="PP Plot (Homo p-values - clustalo)",
#      xlab="Expected",
#      ylab="Observed")
# abline(0, 1, col="red", lty=2)
# dev.off()
# 1. Load the data (skipping the first 6 metadata lines)
d <- read.table("work/5_homo/_Summary.csv",
                header=TRUE,
                sep=",",
                skip=6)

# 2. Extract and sort the p-values from column 'p'
# Note: Ensure the column header in your CSV is exactly 'p'
p_values <- d$p 
observed <- sort(p_values)

# 3. Create the Expected values (0 to 1) for the PP plot
expected <- seq(0, 1, length.out = length(observed))

# 4. Open the PDF device to save the plot
pdf(height=4, width=4, file="P-values.pdf")

# 5. Generate the plot
plot(expected, observed,
     main="PP Plot (Homo p-values - clustalo)",
     xlab="Expected",
     ylab="Observed",
     pch=20,       # Using solid dots for better visibility
     col="black")

# 6. Add the 1:1 reference line
abline(0, 1, col="red", lty=2)

# 7. Finalize and save the PDF file
dev.off()
