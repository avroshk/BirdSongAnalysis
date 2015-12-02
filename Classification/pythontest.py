import numpy as np
import matplotlib.pyplot as plt
  
from sklearn import svm, preprocessing
# from sklearn.multiclass import OneVsRestClassifier
import pandas as pd

from matplotlib import style
style.use("ggplot")

FEATURES = ["SF_mean",
			"SF_std",
			"MFCC1_mean",
			"MFCC1_std",
			"MFCC2_mean",
			"MFCC2_std",
			"MFCC3_mean",
			"MFCC3_std",
			"MFCC4_mean",
			"MFCC4_std",
			"MFCC5_mean",
			"MFCC5_std",
			"MFCC6_mean",
			"MFCC6_std",
			"MFCC7_mean",
			"MFCC7_std",
			"MFCC8_mean",
			"MFCC8_std",
			"MFCC9_mean",
			"MFCC9_std",
			"MFCC10_mean",
			"MFCC10_std",
			"MFCC11_mean",
			"MFCC11_std",
			"MFCC12_mean",
			"MFCC12_std",
			"MFCC13_mean",
			"MFCC13_std"]



def Build_Data_Set():
	data_df = pd.DataFrame.from_csv("mfcc_dataset.csv");

	X = np.array(data_df[FEATURES].values)

	y = (data_df["Species"].values)

	X = preprocessing.scale(X)

	return x,y

def Analysis():

	test_size = 500



	X,y = Build_Data_Set()
	print(len(X))

	clf = svm.SVC(kernel="linear",c=1.0)
	# clf.fit(X,y)

	clf.fit(X[:-test_size],y[:-test_size])

	correct_count = 0

	for x in range(1, test_size+1):
		if clf.predict(X[-x])[0] == y[-x]:
			correct_count += 1

	print("Accuracy:",(correct_count/test_size) * 100)

	# w = clf.coef_[0]

	# a = -w[0] /w[1]

	# xx = np.linsapce(min(X[:,0]))
	# yy = a * xx - clf.intercept_[0] / w[1] 

	# h0 = plt.plot(xx,yy, "k-",label="non weighted")

	# plt.scatter(X[])

Analysis()







