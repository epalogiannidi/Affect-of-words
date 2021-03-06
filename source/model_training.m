function model_training(training_set, dim, seeds, similarity, result_dir,result_dir1,lambda)

%% Training on an affective lexicon of a language for a specific number of seed words
% The traing is achieve for continues (not binary ratings)

%% Set the specific parameters

display('Loading parameters...');

data_dir = '../data/';
similarity_type =[data_dir,training_set,'/',similarity];

if ~exist(result_dir,'dir') 
    mkdir(result_dir);
end

if ~exist(result_dir1,'dir') 
    mkdir(result_dir1);
end

display('Training starts for...');

display([num2str(seeds), ' seed words, ',dim,' emotional dimention and ',similarity,' similarity metric']);

%% Load resources
display('Loading resources');

%load similarity matrix
similarity_file = [similarity_type,'.mat'];
similarity_matrix = load(similarity_file);
similarity_matrix = similarity_matrix.matrix;

%load the affective ratings
emotion_file = [data_dir,training_set,'/',dim,'.txt'];
emotion_ratings = load(emotion_file,'-ascii');

% CREATE SIM * VAL MATRIX
for i=1:size(similarity_matrix,1)
    similarity_matrix(i,:) = similarity_matrix(i,:).*emotion_ratings';
end

%% Feature selection

display('Feature selection');

feats_filter = ones(size(emotion_ratings,1),1);% The whole affective lexicon is the training set

if seeds <= sum(feats_filter)%the sum of train_entries
    % sort by rating
    [~,IX1] = sort(emotion_ratings,'descend');%from most positive to most negative
    [~,IX2] = sort(emotion_ratings,'ascend');%from most negative to most positive
    tmp_pos = IX1(feats_filter(IX1) == 1);
    tmp_neg = IX2(feats_filter(IX2) == 1);
    
    % SELECTION - ATTEMPT TO MINIMIZE SUM OF VALENCE
    finished = 0;
    last_sum = 500;
    new_idx_pos = floor(seeds/2);
    new_idx_neg = floor(seeds/2);
    if (new_idx_pos + new_idx_neg < seeds)
        new_idx_pos = new_idx_pos+1;
    end
    % adjust to available pos/neg features
    if new_idx_pos > length(tmp_pos)
        new_idx_neg = new_idx_neg + (new_idx_pos - length(tmp_pos));
        new_idx_pos = length(tmp_pos);
    elseif new_idx_neg > length(tmp_neg)
        new_idx_pos = new_idx_pos + (new_idx_neg - length(tmp_neg));
        new_idx_neg = length(tmp_neg);
    end
    
    while finished == 0
        tmp_pos1 = tmp_pos(1:new_idx_pos);%take the half positive
        tmp_neg1 = tmp_neg(1:new_idx_neg);%take the half negative
        val_sum = sum([emotion_ratings(tmp_pos1) ; emotion_ratings(tmp_neg1)]); %the total sum of the seeds selected
        if (abs(val_sum) < abs(last_sum))
            % not finished
            last_sum = val_sum;
            old_idx_pos = new_idx_pos;
            old_idx_neg = new_idx_neg;
            if val_sum > 0%positive is greater, try to balance, take first the negative
                new_idx_pos = new_idx_pos-1;
                new_idx_neg = new_idx_neg+1;
                if new_idx_neg > length(tmp_neg)
                    finished = 1;
                end
            else%negative is greater
                new_idx_pos = new_idx_pos+1;
                new_idx_neg = new_idx_neg-1;
                if new_idx_pos > length(tmp_pos)
                    finished = 1;
                end
            end
        else
            finished = 1;
        end
    end
    tmp = [tmp_pos(1:old_idx_pos); tmp_neg(1:old_idx_neg)];
else
    display('no selection');
end

model_seeds = tmp;

%% train features
display('Training...');

train_matrix = similarity_matrix(:, model_seeds);

X = [ones(size(train_matrix,1),1) train_matrix];

if (lambda == 0)
    model_coefs = X\emotion_ratings;
else
    L = (lambda).*eye(size(X,2));
    L(1) = 0;
    model_coefs = pinv(X' * X + L) * (X'*emotion_ratings);%to avoid singular warning
end

model_seed_ratings = emotion_ratings(model_seeds);

display(['Saving the model under ', result_dir1,' directory']);

save([result_dir1,dim,'_',num2str(seeds),'_',similarity,'_l_',num2str(lambda)],'model_seed_ratings','model_seeds','model_coefs')
end
