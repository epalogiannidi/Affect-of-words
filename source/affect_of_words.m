function affect_of_words(affective_lexicon,dim,seeds,similarity,lambda,test)

%%----------------------------------------------------------------------%%
%  affect_of_words is a function that estimate the affective scores of   %
%  words.                                                                %
%------------------------------------------------------------------------%
%  affect_of_words(a,b,c,d,e) takes as input the name of the affective
%  lexicon, the affective dimension, i.e., val (for valecne), aro (for
%  arousal) or dom (for dominance), the number of seeds that are going to
%  be selected from the affective lexicon (some hundreds; e.g. between 100
%  and 600), the semantic similarity metric (the name you have saved it)
%  and the regularization factor (0 corresponds to lse and >0 corresponds
%  to ridge regression), test is the name of the test dataset [should be a
%  semantic similarity matrix] 
%  The output is the affective model [selected seeds and weights] stored in
%  a .mat file and an affective lexicon for the current dimension
%----------------------------------------------------------------------%
data_dir = '../data/';
l = lambda*10;
result_dir = '../results/';
result_dir1 = [result_dir,dim,'_',num2str(seeds),'_',similarity,'/'];

saved_model = [result_dir1,dim,'_',num2str(seeds),'_',similarity,'_l_',num2str(l),'.mat'];
test_similarity_matrix =[data_dir,affective_lexicon,'/',test,'.mat'];

% seeds selection
model_training(affective_lexicon,dim,seeds,similarity,result_dir,result_dir1,l);

% affect estimation
affect_estimation(saved_model,test_similarity_matrix,result_dir1, dim, similarity,l);

end