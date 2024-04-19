clf
i = [];
i=input('Do you want to plot the load-displacement response of a dof?  Y/N  [Y]:','s');
if isempty(i)
	i='Y';
end
if (i == 'y' || i == 'Y' )
    i=input('which dof?:');
    axis('auto');
    lambdas = structure.lambda_hist;
    plot(structure.delta_hist(i,:)',lambdas);
    file_name = sprintf("%s_response.png",struct_name);
    print(gcf,file_name,"-dpng","-r720");
    fprintf("figure saved at %s\n",file_name)
    clf
end