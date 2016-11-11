# Data4People-Women-s-Health-Risk-Assessment

Summary

In this article, we are going to present the solution for the Women’s Health Risk Assessment data science competition on Microsoft’s Cortana Intelligence platform which was ranked among the top 5%.
In this page, you can find the published Azure ML Studio experiment., a description of the data science process used, and finally a link to the R code (in GitHub).


Competition
Here is the description from the Microsoft Cortana Competition

“To help achieve the goal of improving women's reproductive health outcomes in underdeveloped regions, this competition calls for optimized machine learning solutions so that a patient can be accurately categorized into different health risk segments and subgroups. Based on the categories that a patient falls in, healthcare providers can offer an appropriate education and training program to patients. Such customized programs have a better chance to help reduce the reproductive health risk of patients.
This dataset used in this competition was collected via survey in 2015 as part of a Bill & Melinda Gates Foundation funded project exploring the wants, needs, and behaviors of women and girls with regards to their sexual and reproductive health in nine geographies.
The objective of this machine learning competition is to build machine learning models to assign a young woman subject (15-30 years old) in one of the 9 underdeveloped regions into a risk segment, and a subgroup within the segment.”
https://gallery.cortanaintelligence.com/Competition/Womens-Health-Risk-Assessment-1

Dataset
The contains 9000 observations
The original training dataset is in CSV format and can be found in the competition’s description.
To submit a solution, two options are possible: build it in Azure ML Studio or build your solutions locally in R and then submit it through Azure ML Studio. 
An Azure ML’s solution, and a R script code where given as example. The two solutions are based on the use of a Generalized Linear Model is automatically downloaded. 
You can find a detailed description of the dataset, the R sample Code and a tutorial using Azure ML and R in the competition page 

Solution
I started following the R tutorial for this competition. 
Then I have submitted the exact same R solution. The sample model has a 77% accuracy
Pre-processing & Cleaning
The first thing I did was changing the initial multinomial model (nnet package) for a random forest model (RandomForest package). 
All missing values have been replaced by 0
Feature selection
Features have been selected using the function varImpPlot from the randomforest package
Parameter tuning
I have chosen (for educational matter) to use the module Tune Model Hyperparameters in Azure ML Studio. I could have also used the R Package Caret.
Evaluation
The final model has an accuracy of 86.36% (18 position over almost 500 participants)
You can find the Azure ML Studio experiment here : http://gallery.cortanaintelligence.com/Experiment/Women-s-Health-Risk-Assessment-Random-Forest-1

