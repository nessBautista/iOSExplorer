# %% test
import pandas as pd

adver = pd.read_csv("../../datasets/advertising.csv")
adver.head()

from sklearn.model_selection import train_test_split
X, y = adver.iloc[:, :-1], adver.iloc[:, -1]
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.25, random_state=42)



from sklearn.linear_model import LinearRegression
import sklearn.svm as svm
linear_regression = LinearRegression()  
linear_regression.fit(X_train, y_train)    # 2
linear_regression.score(X_test, y_test)    # 3z


X_new = [[ 50.0, 150.0, 150.0],
         [250.0,  50.0,  50.0],
         [100.0, 125.0, 125.0]]

linear_regression.predict(X_new)
import sklearn


# %%
""" import coremltools
print(coremltools.__version__)
 """
import coremltools as ct


input_features = ["tv", "radio", "newspaper"]
output_feature = "sales"

model = ct.converters.sklearn.convert(linear_regression,
                                     input_features,
                                     output_feature)
model.save("Advertising.mlmodel") 
