# AdventureWorkProject
Sales analysis and data science predictions

The project presents an analysis of the Adventure Works store from 2011 to 2014. 

I divided the project into 3 periods:
1. first sale May 2011
2. First exchange of assortment May 2012
3. last exchange of assortment May 2013

Each period lasts 12 months and represents 36 months of bike sales in the store. 

After initial analysis, I created 2 algorithms to help estimate profit from new bike sales:
#### 1. Predicting annual ROI based on all years of sales (Logistic Regression)
The model works fine, but I don't think it can contribute much to the company because the store was selling the bikes for 50% or even 20% of their value in the past. That's why I've created a second model that accounts for this randomness.

#### 2. Predicting Quantity of the orders base on past sales (Polly Regression)
I have divided the data into different categories such as model, color, size, the parts that make up an individual product key. I then divided the bikes by selling price versus purchase price and another division by month. 

Each one usually had 3-4 different prices at which it sold. This gave me information on how many bikes at each price were sold in each month.
The R2 for the training data of the model is about 70% and for the test data is over 60%. MAE within 11 units, for average sales per month of 30 units

The project is not 100% complete yet, but I am working on it
