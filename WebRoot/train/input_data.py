# -*- coding: utf-8 -*-
"""
Created on Mon Jul 30 16:52:16 2018

@author: Honyo
"""

import numpy as np
import pandas as pd
import os
import sys

os.chdir(sys.path[0])
pwd = os.getcwd() #当前文件的路径
# print("Current Path：", pwd)
# 给出数据文件绝对路径
filepath = pwd + os.path.sep + "dataa.csv"
# print('Data Path:', filepath)
dataset = pd.read_csv(filepath)
#print(dataset.shape)
#print(dataset)

target = ['y']
X=['X1', 'X2', 'X3', 'X4', 'X5', 'X6', 'X7', 'X8', 'X9', 'X10', 'X11', 'X12', 'X13', 'X14', 'X15', 'X16', 'X17', 'X18', 'X19', 'X20', 'X21', 'X22', 'X23', 'X24', 'X25', 'X26', 'X27', 'X28', 'X29', 'X30', 'X31', 'X32', 'X33', 'X34', 'X35', 'X36', 'X37', 'X38', 'X39', 'X40', 'X41', 'X42', 'X43', 'X44', 'X45', 'X46', 'X47', 'X48', 'X49', 'X50', 'X51', 'X52', 'X53', 'X54', 'X55', 'X56', 'X57', 'X58', 'X59', 'X60', 'X61', 'X62', 'X63', 'X64', 'X65', 'X66', 'X67', 'X68', 'X69', 'X70', 'X71', 'X72', 'X73', 'X74', 'X75', 'X76', 'X77', 'X78', 'X79', 'X80', 'X81', 'X82', 'X83', 'X84', 'X85', 'X86', 'X87', 'X88', 'X89', 'X90', 'X91', 'X92', 'X93', 'X94', 'X95', 'X96', 'X97', 'X98', 'X99', 'X100', 'X101', 'X102', 'X103', 'X104', 'X105', 'X106', 'X107', 'X108', 'X109', 'X110', 'X111', 'X112', 'X113', 'X114', 'X115', 'X116', 'X117', 'X118', 'X119', 'X120', 'X121', 'X122', 'X123', 'X124', 'X125', 'X126', 'X127', 'X128', 'X129', 'X130', 'X131', 'X132', 'X133', 'X134', 'X135', 'X136', 'X137', 'X138', 'X139', 'X140', 'X141', 'X142', 'X143', 'X144', 'X145', 'X146', 'X147', 'X148', 'X149', 'X150', 'X151', 'X152', 'X153', 'X154', 'X155', 'X156', 'X157', 'X158', 'X159', 'X160', 'X161', 'X162', 'X163', 'X164', 'X165', 'X166', 'X167', 'X168', 'X169', 'X170', 'X171', 'X172', 'X173', 'X174', 'X175', 'X176', 'X177', 'X178' ]

from sklearn.preprocessing import StandardScaler
x = dataset.loc[:, X].values
y = dataset.loc[:, target].values
x = StandardScaler().fit_transform(x)

for i in range(len(y)):
    if y[i] == 1:
        y[i] = 1
    else:
        y[i] = 0
#print(y)

np.random.seed(42)

x = pd.DataFrame(x)
y = pd.DataFrame(y)
y.columns = [178]
#print(y)

z = [x, y]
dataset = pd.concat(z, axis=1)
#print(dataset)

from keras.utils import to_categorical
target = dataset[178]
one_hot = to_categorical(target, num_classes=2)
#print(dataset.shape)

from sklearn.model_selection import train_test_split
TrainSet, TestSet = train_test_split(dataset, test_size=0.2, random_state=42)

xTrain = TrainSet.iloc[:, :-1]
yTrain = TrainSet.iloc[:,-1]
yTrain = to_categorical(yTrain, num_classes = 2)
#print(xTrain.shape)
#print(yTrain.shape)

xTest = TestSet.iloc[:, :-1]
yTest = TestSet.iloc[:,-1]
yTest = to_categorical(yTest, num_classes = 2)
#print(xTest.shape)
#print(yTest.shape)

def nextBatchTrain(batch_size):
    high_index = np.shape(xTrain)[0] - batch_size - 1
    start = np.random.randint(0, high=high_index, size =1)[0]
#    print(start)
    data = xTrain[start:start+batch_size]
    label = yTrain[start:start+batch_size]
    return data, label

def nextBatchTest(batch_size):
    high_index = np.shape(xTest)[0] - batch_size -1
    start = np.random.randint(0, high=high_index, size =1)[0]
#    print(start)
    data = xTest[start:start+batch_size]
    label = yTest[start:start+batch_size]
    return data, label