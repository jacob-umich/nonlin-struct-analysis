clf
i = [];
i=input('Do you want to plot the force-displacement response of a dof?  Y/N  [Y]:','s');
if isempty(i)
	i='Y';
end
if (i == 'y' || i == 'Y' )
    i=input('which dof(s)? input as list:');
    axis('auto');

    lambdas = structure.lambda_hist;
    for j= 1:length(i)
        hold on
        name = sprintf("DOF %i",i(j));
        plot(structure.delta_hist(i(j),:)',lambdas,'DisplayName',name);

    end
    xlabel("Displacment(in)")
    ylabel("\lambda")
    title("Load-Displacement")
    legend
    file_name = sprintf("%s_response.png",struct_name);
    print(gcf,file_name,"-dpng","-r720");
    fprintf("figure saved at %s\n",file_name)
    hold off
    clf
end