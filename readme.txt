test samples for dataset
01 - run 001
02 - run 002
20 - walk 002
33 - walk 015

test samples for dataset2
ayný ama index farklý
01 - run 001
02 - run 002
15 - walk 002
28 - walk 015


TEST1:
dataset2-tag
-> acc %75
dataset-tag
-> acc %100

TEST2:
testsample_ind = [1,2,15,28,8,11] ;% indices for test sample
1-NN
ucf->%66.67
mixed->%83.33

TEST3:
testsample_ind = [1,2,15,28,8,11] ;% indices for test sample
7-NN
ucf->%50
mixed->%66.67
