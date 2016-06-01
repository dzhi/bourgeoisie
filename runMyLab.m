clear all
data_conversion

original_data = data;
for iteration = 0:3
	
	if iteration == 0
		data = original_data;
	elseif iteration == 1
		data = [age education martialstatus race sex country];
	elseif iteration == 2
		data = [age workclass education relationship race sex capitalgain capitalloss ];
	elseif iteration == 3
		data = [capitalgain capitalloss];
	end

	%attempt to run on the adult.test, but we run out of memory or our results do not conclude anything (currently)

	%[w, b] = softsvm(data, over50k, 0.005);
	%prediction = test * w' + b;
	%results = zeros(1, size(test, 1));
	%for i = 1:size(test,1)
	%	if sign(prediction(i)) == sign(testY(i))
	%		results(i) = 1;
	%	else
	%		results(i) = 0;
	%	end
	%end




	%this code did things using ONLY the adult_data file, proportionalizing it into a test/train

	train_num = 20000;
	N = 32560;
	[w, b] = softsvm(data(1:train_num,:), over50k(1:train_num), 0.005);	%used gamma = 0.005 in the lab
	prediction = data((train_num+1):N,:) * w' + b;
	results = zeros(1, N - train_num);
	for i = 1:N-train_num
		if sign(prediction(i)) == sign(over50k(train_num + i))
			results(i) = 1;
		else
			results(i) = 0;
		end
	end
	
	if iteration == 0
		fprintf('Using the original data (no subsets)\n');
	elseif iteration == 1
		fprintf('Using only age, education, martialstatus, race, sex, and country\n');
	elseif iteration == 2
		fprintf('Using age, workclass, education, relationship, race, sex, and capital gain/loss\n');
	elseif iteration == 3
		fprintf('Using ONLY capitalgain/loss')
	end
	
	total_accuracy = sum(results) / (N - train_num);
	fprintf('Overall accuracy is: %f \n', total_accuracy);

	num_under_test = 0;
	num_over_test = 0;
	num_under_correct = 0;
	num_over_correct = 0;
	for i = (train_num+1):N
		if over50k(i) == 1
			num_over_test = num_over_test + 1;
			if results(i-train_num) == 1
				num_over_correct = num_over_correct + 1;
			else
				continue;
			end
		elseif over50k(i) == -1
			num_under_test = num_under_test + 1;
			if results(i-train_num) == 1
				num_under_correct = num_under_correct + 1;
			else
				continue;
			end
		end
	end

	overaccuracy = num_over_correct / num_over_test;
	fprintf('Accuracy for those Over 50K income: %f\n', overaccuracy);
	underaccuracy = num_under_correct / num_under_test;
	fprintf('Accuracy for those Under 50K income: %f\n', underaccuracy);
	
	fprintf('-------------------------------------\n');
	
end