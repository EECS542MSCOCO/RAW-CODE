function opt_theta = vqa_softmaxTrain(inputSize, numClasses, lambda, inputData, labels, options, theta)

if ~exist('options', 'var')
    options = struct;
end

if ~isfield(options, 'maxIter')
    options.maxIter = 400;
end

options.Method = 'lbfgs'; % Here, we use L-BFGS to optimize our cost
                          % function. Generally, for minFunc to work, you
                          % need a function pointer with two outputs: the
                          % function value and the gradient. In our problem,
                          % softmaxCost.m satisfies this.
minFuncOptions.display = 'on';

[softmaxOptTheta, cost] = minFunc( @(p) vqa_softmaxCost(p, ...
                                   numClasses, inputSize, lambda, ...
                                   inputData, labels), ...                                   
                              theta, options);
                          
opt_theta = reshape(softmaxOptTheta, numClasses*inputSize,1);


end

