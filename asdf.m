% Modify this line to choose the specific subset of the data attributes you
% want to use for prediction
limited_data = data;
%limited_data = [age education race sex];
perm = randperm(N);
data_reordered = limited_data(perm, :);
over50k_reordered = over50k(perm, :);

m = 20000;
X_train = data_reordered(1:m, :);
y = over50k_reordered(1:m);
svm_model = fitcsvm(X_train, y, 'Standardize', true);

X_test = data_reordered(m+1:N, :);

[label,Score] = predict(svm_model, X_test);
correct = label==over50k_reordered(m+1:N);
correct_fraction = sum(correct)/(N-m);
predicted_over50k_fraction = sum(label)/(N-m);

over50k_fraction = sum(over50k_reordered)/N;