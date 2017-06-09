clear
clc

load('ucf101-img-vgg16-split1.mat');

net_ = dagnn.DagNN.loadobj(net) ;

net_.mode = 'test' ;
% net_.move('gpu') ;
% net_.conserveMemory = false;


% im = imread('dataset\walk\sentetik\001\SubUrbanEngine_000001_img.png');
im = imread('dataset\walk\ucf\001\3206-12_70000.jpg');
im_ = single(im);
im_ = imresize(im_, net_.meta.normalization.imageSize(1:2));
im_ = bsxfun(@minus, im_, net_.meta.normalization.averageImage);

net_.vars(net_.getVarIndex('x35')).precious = true;
% net_.eval({'input',gpuArray(im_)}) ;
net_.eval({'input',im_}) ;
x = gather(net_.vars(net_.getVarIndex('x35')).value);

% frames = dir('dataset\walk\ucf\001\');



% INDEX = getLayerIndex(net_, 'fc7');
% 
% fully = net_.layers(INDEX);
% 
% i = net_.getVarIndex('x3') ;
% output = net_.vars(i).value ;


% derOutputs = {'x36', 1} ;

% net_.eval({'input', im_});

% outputname = net_.getOutputIndex('fc7b');


% fc7b = net_.getParamIndex('fc7b');
% feature = net_.params(fc7b).value;
% 
% i = net_.getVarIndex('27');
% output = net_.vars(i).value;

% scores = net_.vars(net_.getVarIndex('fc7')).value ;



% visdiff('duz.mat', 'sentters.mat')


% load('ucf101-img-vgg16-split1.mat');
% im = imread('dataset\walk\ucf\001\3206-12_70000.jpg');
% im_ = single(im);
% im_ = imresize(im_, net.meta.normalization.imageSize(1:2));
% % imshow(im);
% % pause;
% % imshow(im_);
% im_ = im_ - net.meta.normalization.averageImage ;
% 
% net.params = net.params(1:30);
% 
% res = vl_simplenn(net, im_) ;
