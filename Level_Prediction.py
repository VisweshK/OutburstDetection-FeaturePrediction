#!/usr/bin/python
# -*- coding: utf-8 -*-
# Prediction of Intensity of meteor shower

'''
Decision Tree:

0.702439808087
0.575207990772
0.329717525217
0.0950744840111

0.672732716505
0.467098069843
0.307843356019
0.225058574138

0.668840415666
0.435763429479
0.325791655641
0.23844491488

MLP Classifier:

0.718695458496
0.72653877106
0.0295682874276
0.243892941512

0.724639797863
0.656270718965
0.0662211260509
0.277508154984


KNN:
0.795772060432 (Counting 0)
0.42423593412
0.317405924054
0.258358141826

0.722054667475 (Not Counting 0)
0.583983605265
0.225164866924
0.190851527811

'''

# Imports

from sklearn.neural_network import MLPClassifier, MLPRegressor
from sklearn.neighbors import KNeighborsClassifier, KNeighborsRegressor
from sklearn.tree import DecisionTreeClassifier, DecisionTreeRegressor
from sklearn.preprocessing import LabelEncoder, StandardScaler, \
    MinMaxScaler
from sklearn.model_selection import train_test_split
import pandas as pd

# Preprocessed data

data = \
    pd.read_csv('/Users/ksundar/Desktop/MeteorShowerPrediction/WithoutOutliers.csv'
                , sep=';', usecols=[
    'Start.Date',
    'End.Date',
    'Ra',
    'Decl',
    'Shower',
    'Latitude',
    'Longitude',
    'Elevation',
    'Number',
    ], infer_datetime_format=True, parse_dates=[0])

# Removing entries with 0
# data = data[data.Number != 0]

# Use only Start Month

t = pd.to_datetime(data['Start.Date'])
data['Start.Month'] = data['Start.Date'].dt.month
del data['Start.Date']
del data['End.Date']

# Replace latitude, longitude, elevation with observatory

data['Observatory'] = list(zip(data.Latitude, data.Longitude,
                           data.Elevation))
del data['Latitude']
del data['Longitude']
del data['Elevation']

# binning shower data, latitude, longitude and elevation into Intensity and observatory

le = LabelEncoder()
data['Shower'] = le.fit_transform(data['Shower'])
le_obs = LabelEncoder()
data['Observatory'] = le_obs.fit_transform(data['Observatory'])

# binning the number data

categories = [0, 5, 10, 1000]
data_1 = data.assign(Intensity=pd.cut(data['Number'], bins=categories,
                     include_lowest=True, labels=[0, 1, 2]))
data = data_1
del data['Number']

# Saving train and test data

data_input = data.drop('Intensity', axis=1)
data_output = data.filter(['Intensity'], axis=1)
(train_input, test_input, train_output, test_output) = \
    train_test_split(data_input, data_output, test_size=0.2,
                     shuffle=True)

# scaling data

scaler = StandardScaler().fit(train_input)
scaler.transform(train_input)
scaler.transform(test_input)
scaler = MinMaxScaler(feature_range=(0, 1))
train_input = scaler.fit_transform(train_input)
test_input = scaler.fit_transform(test_input)

# Build Classifier : Comment out Classifier not required

# clf = MLPClassifier(alpha=1e-3, hidden_layer_sizes=(10, 10, 10), random_state=1, learning_rate_init = 1e-3)
# clf = DecisionTreeClassifier()

clf = KNeighborsClassifier(n_neighbors=10)
clf = clf.fit(train_input, train_output)
pred_output = clf.predict(test_input)
test_output = test_output['Intensity'].tolist()
print clf.score(test_input, test_output)

# Check right and wrong

(wrong, freq, close) = (0, [0, 0, 0], 0)
for i in range(len(test_output)):
    if test_output[i] != pred_output[i]:
        wrong += 1
        freq[pred_output[i]] += 1
        if (3 <= number_values[i] <= 5 or 10<= number_values[i] <= 12) and pred_output[i] == 1:
            close += 1
        if 8 <= number_values[i] <= 10 and pred_output[i] == 2:
            close += 1
        if 5 <= number_values[i] <= 7 and pred_output[i] == 0:
            close += 1

print 'Bin 1 :',float(freq[0]) / wrong
print 'Bin 2 :',float(freq[1]) / wrong
print 'Bin 3 :', float(freq[2]) / wrong
print 'close :', float(close) / wrong
