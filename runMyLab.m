clear all
data_conversion
train_num = 20000;
N = 32560;
[w, b] = softsvm(data(1:train_num,:), over50k(1:train_num), 0.005);	%used gamma = 0.005 in the lab, don't know why
prediction = data((train_num+1):N,:) * w' + b;
results = zeros(1, N - train_num);
for i = 1:N-train_num
	if sign(prediction(i)) == sign(over50k(train_num + i))
		results(i) = 1;
	else
		results(i) = 0;
	end
end
sum(results) / (N - train_num)