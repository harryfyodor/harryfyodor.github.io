

Five core steps

### 1. Exploratory Analysis
First, "get to know" the data. This step should be quick, efficient, and decisive.

使用pandas引入数据

* 初步看看数据
* Visualization
seaborn matplotlib
* Statical Test

```python
train_df = pd.read_csv('../input/train.csv')
test_df = pd.read_csv('../input/test.csv')
combine = [train_df, test_df]
print(train_df.columns.values)
train_df.tail()
```
https://elitedatascience.com/python-seaborn-tutorial
https://elitedatascience.com/exploratory-analysis
### 2. Data Cleaning
Then, clean your data to avoid many common pitfalls. Better data beats fancier algorithms.
* Missing Data
* Outlier
* Noise
Based on previous data


### 3. Feature Engineering
Next, help your algorithms "focus" on what's important by creating new features.
* Feature Selection
使用Random Forest来找出最好的特征
* Feature Encoding
使用一些数值来代替一些量
使用Dummy Variables

### 4. Algorithm Selection
Choose the best, most appropriate algorithms without wasting your time.
线性：
* SVM
* Linear Regression
* Logistic Regression
* Neural Networks
常用：
* Gradient Boosting
* Random Forest
* Extra Randomized Trees
* Xgboost

### 5. Model Training
Finally, train your models. This step is pretty formulaic once you've done the first 4.
Of course, there are other situational steps as well:
调参
grid search

Xgboost
* eta：每次迭代完成后更新权重时的步长。越小训练越慢。
* num_round：总共迭代的次数。
* subsample：训练每棵树时用来训练的数据占全部的比例。用于防止 Overfitting。
* colsample_bytree：训练每棵树时用来训练的特征的比例，类似 RandomForestClassifier 的 max_features。
* max_depth：每棵树的最大深度限制。与 Random Forest 不同，Gradient Boosting 如果不对深度加以限制，最终是会 Overfit 的。
* early_stopping_rounds：用于控制在 Out Of Sample 的验证集上连续多少个迭代的分数都没有提高后就提前终止训练。用于防止 Overfitting。

分训练集验证集
eta设置0.1

cross validation

### 6. Ensembling
You can squeeze out even more performance by combining multiple models.
* stacking
* bagging
* boosting
* blending