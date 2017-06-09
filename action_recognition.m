close all
clear all
clc

load('ucf101-img-vgg16-split1.mat');
net_ = dagnn.DagNN.loadobj(net) ;
net_.mode = 'test' ;

all_files = dir ('D:\Users\hayat\Google Drive\pofconcept\dataset');
dirFlags = [all_files.isdir];
subFolders = all_files(dirFlags);

% Find only files with videos remove '.' and '..' folders
count=0;
for k = 1 : length(subFolders) 
    if subFolders(k).isdir && ~strcmpi(subFolders(k).name,'.') && ~strcmpi(subFolders(k).name, '..')
% 	  fprintf('Sub folder #%d = %s\n', k, subFolders(k).name);
      count=count+1;
      VideoFolders(count).name=subFolders(k).name;
    end
end
path='D:\Users\hayat\Google Drive\pofconcept\dataset\';

%for dataset2
features(48,1)=struct('action',[],'sample_id',[],'mean_response',[]);

%for dataset
% All_features(10,1)=struct('Label',[],'action_name',[],'Feature_Vector',[]);

idx=1;
label=0;
q = 3;
for k=1:length(VideoFolders) 
    new_path=[path,VideoFolders(k).name,'\'];  
%   sub_video=dir(fullfile(new_path,'*.jpg'));
    
    samples=dir(new_path);
    isDir = [samples.isdir];
    subSamples = samples(isDir);
    count=0;
    for x = 1 : length(subSamples) 
        if subSamples(x).isdir && ~strcmpi(subSamples(x).name,'.') && ~strcmpi(subSamples(x).name, '..')
%           fprintf('frame folder #%d = %s\n', x, subSamples(x).name);
          count=count+1;
          frameFolders(count).name=subSamples(x).name;
        end
    end
    
    for l=1:length(frameFolders) 
        actionPath = [new_path,frameFolders(l).name,'\'];
        sub_frames =dir(fullfile(actionPath,'*.jpg'));
       
        % calculate mean for each frame folder
        appendIndex = 1;
        toMean = [];
        C = [];
        for i=1:length(sub_frames)
            imgPath = [actionPath,sub_frames(i).name];
            im = imread(imgPath);
            im_ = single(im);
            im_ = imresize(im_, net_.meta.normalization.imageSize(1:2));
            im_ = bsxfun(@minus, im_, net_.meta.normalization.averageImage);

            net_.vars(net_.getVarIndex('x35')).precious = true;
            % net_.eval({'input',gpuArray(im_)}) ;
            net_.eval({'input',im_}) ;
            x = gather(net_.vars(net_.getVarIndex('x35')).value);
            C = horzcat(x,C);     
        end
        M = mean(C);
        disp('exracted');
        features(idx).action = VideoFolders(k).name;
        features(idx).sample_id = frameFolders(l).name;
        features(idx).mean_response = M;
        idx = idx+1;
    end
end

% feature_vectors = cell2mat({features(:).mean_response}');
testsample_ind = [] ; % indices for test sample
% test_sample=feature_vectors([testsample_ind],:);
test_sample=features([testsample_ind],:);
% test_labels=[All_features([testsample_ind]).Label]';
% feature_vectors([testsample_ind],:)=[];
% train_sample=feature_vectors;
% train_labels=[All_features(setdiff((1:end),[testsample_ind])).Label]';
% 
% %knn classification
% md1 = fitcknn(train_sample,train_labels)
% predicted_labels = predict(md1,test_sample);
% accuracy=calculate_accuracy(test_labels,predicted_labels)
