
% set conditions
condition=true
condition2=true

% get loads. PF is loads from fixed end forces

[P,PF]=structure.get_loads();
P_total = P+PF;

lambda=0;
lambda_i=0.2;
R=zeros(structure.n_free,1);
delta_free=zeros(structure.n_free,1);
k_orig=structure.get_stiffness()(1:structure.n_free,1:structure.n_free);
k_free=k_orig

while condition
    R=zeros(structure.n_free,1);
    dp = P_total*lambda_i;
    delta_free_j=zeros(structure.n_free,1);
    d_lambda=0;     
    for j=1:50

        % update lambda for this increment for the jth iteration
        lambda_i=lambda_i+d_lambda;

        % compute delta j
        delta_free_j=k_free\(P_total*d_lambda+R);

        % get total displacement at step j
        delta_temp=delta_free+delta_free_j;
        structure.update_disp(delta_temp);

        % get internal force for step j
        F = structure.get_internal_force()(structure.n_free,1);

        % compute residual for step j
        R=P_total(lambda+lambda_i)-F;

        % compute stiffness for step j+1
        k_free=structure.get_stiffness()(1:structure.n_free,1:structure.n_free);

        % compute d_lambda for step j+1
        d_lambda=-P_total'*k_free\R/(P_total'*k_free\P_total);

        % stop iteration if residual is small
        if max(abs(R))<1e-3
            break
        end
    end
    lambda = lambda+lambda_i;
    S =P_total'*k_orig*P_total/(P_total'*k_free*P_total)
    lambda_i=0.2*S
end


