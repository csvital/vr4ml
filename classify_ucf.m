clear all
close all
clc
%
% dataset2
% testsample_ind = [1,2,15,28] ; % indices for test sample
testsample_ind = [1,2,15,28,8,11] ; % indices for test sample

load 'features-dataset2-TAG.mat';
feature_vectors = cell2mat({features(:).mean_response}');
% feature_vectors = cell2mat({features(:).mean_response});

test_sample=feature_vectors([testsample_ind],:);
test_labels=[features([testsample_ind]).tag]';
feature_vectors([testsample_ind],:)=[];
train_sample=feature_vectors;
train_labels=[features(setdiff((1:end),[testsample_ind])).tag]';

%knn classification
md1 = fitcknn(train_sample,train_labels,'NumNeighbors',7);
predicted_labels = predict(md1,test_sample);
accuracy = calculate_accuracy(test_labels,predicted_labels);