m = 1000;
X_train = data(1:m, :);
y = overorunder50k(1:m);
svm_model = fitcsvm(X_train, y, 'Standardize', true);

X_test = data(m+1:N, :);

[label,Score] = predict(svm_model, X_test);
correct = label==overorunder50k(m+1:N);
correct_fraction = sum(correct)/(N-m);