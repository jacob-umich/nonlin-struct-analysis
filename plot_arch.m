addpath classes

structure = arch();
[delta,lambda] = work_control(structure,true);

lambdas = structure.lambda_hist;
plot(structure.delta_hist(2,:)',lambdas);
print(gcf,"arch_response.png","-dpng","-r720");