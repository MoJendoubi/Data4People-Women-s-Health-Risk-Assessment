##############################################################################
#   Date : Sept 21, 2016
#   Creative Commons - Attribution (CC-BY) UluumY.com
##############################################################################


# load the libraries
if(!require("randomForest")) install.packages("randomForest")
library(randomForest)


# Specify the URL of data. 
# Also specify the rda file that you want to use to save the model
dataURL <- 'http://az754797.vo.msecnd.net/competition/whra/data/WomenHealth_Training.csv'
model_rda_file <- "C:/Users/Mo/OneDrive/Documents/Site Web/Data4People/whra/WHRA/randomforest.rda"


# Read data to R workspace. The string field religion is read as factors
colclasses <- rep("integer",50)
colclasses[36] <- "character"
dataset1 <- read.table(dataURL, header=TRUE, sep=",", strip.white=TRUE, stringsAsFactors = F, colClasses = colclasses)


# Combine columns geo, segment, and subgroup into a single column.    
# This will be the label column to be predicted in the multiclass classification task
combined_label <- 100*dataset1$geo + 10*dataset1$segment + dataset1$subgroup
data.set <- cbind(dataset1, combined_label)
data.set$combined_label <- as.factor(data.set$combined_label)

## A quick look at the data
summary(dataset1)


# Clean missing data by replacing missing values with 0 (with "0" for string variable religion)
data.set[is.na(data.set)] <- 0
data.set[data.set$religion=="", "religion"] <- "0"
data.set$religion <- factor(data.set$religion)
data.set$combined_label <- relevel(data.set$combined_label, ref = '111')


# Split the data into train (75%) and validation data (25%)
nrows <- nrow(data.set)
sample_size <- floor(0.75 * nrows)
set.seed(98052) # set the seed to make your partition reproductible
train_ind <- sample(seq_len(nrows), size = sample_size)

train <- data.set[train_ind, ]
validation <- data.set[-train_ind, ]


# Skip the columns patientID, segment, subgroup, and INTNR from the feature set
ncols <- ncol(data.set)
feature_index <- c(2:18, 20:(ncols-3))

# Skip these columns from the feature set
#ncols <- ncol(data.set)
#feature_index <- c(2:5,20:32,35,37:43)


# Compose the formula for the model
col_names <- colnames(validation)
model_formula <- formula(paste('combined_label ~ ', paste(col_names[feature_index], collapse=' + '), sep=''))


# Train the Random Forest using randomForest library
rfmodel <- randomForest(model_formula, data = train, ntree=500)


#Variablea importance
varImpPlot(rfmodel,n.var=50)


# Skip these columns from the feature set
feature_index <- c(2:5,20:32,35,37:43)

#Model tuning
#the model tuning was performed using Azure ML Studio (Tune Model Hyperparameters)
#Another option is to use the R package Caret...

# Train the Random Forest using randomForest library
rfmodel <- randomForest(model_formula, data = train, ntree=500, mtry = 11)


# Predict the validation data and calculate the accuracy
predicted_labels <- predict(rfmodel, validation)
accuracy <- round(sum(predicted_labels==validation$combined_label)/nrow(validation) * 100,6)
print(paste("The accuracy on validation data is ", accuracy, "%", sep=""))



# Now assuming that you are satisified with the model, you can train the same model using the entire dataset
rfmodel <- randomForest(model_formula, data = data.set, ntree=500, mtry = 11)

# Save the model in rda file
save(rfmodel, file = model_rda_file)