function [accuracy] = calculate_accuracy(ground_truth,predicted_labels)

cp = classperf(ground_truth,predicted_labels);
accuracy = cp.CorrectRate;
fprintf('KNN Classifier Accuracy: %.2f%%\n',100*cp.CorrectRate )
end

