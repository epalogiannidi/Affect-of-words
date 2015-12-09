function affect_estimation(model,test_similarity_matrix,result_dir,dim, test_file,lambda)

% load the model
load(model);
seeds = model_seeds;
weights = model_coefs;
ratings = model_seed_ratings;

%load similarity matrix
load(test_similarity_matrix);
similarity_matrix = matrix;

%keep only the selected seeds
similarity_matrix = similarity_matrix(:,seeds);

%CREATE SIM * VAL MATRIX
for i=1:size(similarity_matrix,1)
    similarity_matrix(i,:) = similarity_matrix(i,:).*ratings';
end

Y = [ones(size(similarity_matrix,1),1) similarity_matrix]*(weights);

Y(Y > 1) = 1;
Y(Y < -1) = -1;

% store results

FID = fopen([result_dir,test_file,'_',dim,'_l_',num2str(lambda),'.txt'],'w');
for i = 1: length(Y)
   fprintf(FID,'%f\n',Y(i)); 
end
fclose(FID);
end