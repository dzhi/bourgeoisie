clear all
data_conversion
train_num = 20000;
N = 32560;
[w, b] = softsvm(data(1:train_num,:), over50k(1:train_num), 0.005)	%used gamma = 0.005 in the lab, don't know why
prediction = data(N-train_num:N,:) * w' + b
results = []
for i = 1:N-train_num
	if sign(prediction(i)) == sign(over50k(i))
		results(end + 1) = 1;
	else
		results(end + 1) = 0;
	end
end
sum(results) / (N - train_num)