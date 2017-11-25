#!/usr/bin/python
# -*- coding: utf-8 -*-
# Prediction of Shower Type with only the date and month of the shower

'''
Results: Classifier
0.435347861307
'''

# Imports

from sklearn.neural_network import MLPClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.preprocessing import MinMaxScaler, StandardScaler, \
    LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn import tree
import pandas as pd
import matplotlib as plt

# Preprocessed data

data = pd.read_csv(
    '/Users/ksundar/Desktop/MeteorShowerPrediction/WithoutOutliers.csv'
        ,
    sep=';',
    usecols=['Start.Date', 'End.Date', 'Shower', 'Number'],
    infer_datetime_format=True,
    parse_dates=[0, 1],
    decimal=',',
    )
data['Day'] = data['Start.Date'].dt.day
data['Month'] = data['Start.Date'].dt.month
data['Year'] = data['Start.Date'].dt.year
del data['Start.Date']
del data['End.Date']

data = data[data.Number != 0]

del data['Number']

# Saving train and test data

data_input = data.drop('Shower', axis=1)
data_output = data.filter(['Shower'], axis=1)
(train_input, test_input, train_output, test_output) = \
    train_test_split(data_input, data_output, test_size=0.2,
                     shuffle=True)

# Build Classifier : Comment out Classifier which need not be run

clf = tree.DecisionTreeClassifier()

# clf = KNeighborsClassifier(n_neighbors = 10)
# clf = MLPClassifier(alpha=1e-3, hidden_layer_sizes=(50, 10), random_state=1, learning_rate_init = 1e-3)

clf = clf.fit(train_input, train_output)
test_output = test_output['Shower'].tolist()
print clf.score(test_input, test_output)
