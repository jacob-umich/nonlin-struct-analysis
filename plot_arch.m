addpath classes

structure = arch();
[delta,lambda] = work_control(structure,true);

lambdas = structure.lambda_hist;
disp(structure.delta_hist)
disp(lambdas)
plot(structure.delta_hist(2,:)',lambdas);