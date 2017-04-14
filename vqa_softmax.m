%% Initialize
inputSize = 812; % Size of input vector (MNIST images are 28x28)
numClasses = 162501;     % Number of classes (MNIST images fall into 10 classes)
lambda = 1e-4; % Weight decay parameter


% load pooled_train_feature.mat
% load label.mat
% 
% [~,labels] = max(label,[],1);
% labels = labels';

%% Loading data

% images = loadMNISTImages('\train-images.idx3-ubyte');
% labels = loadMNISTLabels('\train-labels.idx1-ubyte');
% labels(labels==0) = 10;

% inputData = images;

%% Learning parameters
% initialize parameters
options.maxIter = 10;
%theta = 0.005 * randn(numClasses * inputSize, 1);
train_numClasses = 162501; % change to 16w
train_inputSize = size(train_feature,1);
train_size = size(train_feature,2);
batch_size = 1000;

%(train_size/batch_size)*2
tic
for i = 1:300
    i
    index = randsample(train_size,batch_size);
    train_input = train_feature(:,index);
    train_label = labels(index,:);
    %train_input = inputData(:,1+batch_size*(i-1):batch_size*i);
    %train_label = labels(1+batch_size*(i-1):batch_size*i,:);
    theta = vqa_softmaxTrain(train_inputSize, train_numClasses, lambda, ...
                            train_input, train_label, options, theta); 
    if mod(i,5) == 0
       save('current_theta.mat','theta','-v7.3');
    end
end
toc
    opt_theta = reshape(theta, numClasses, inputSize);                    
%                         