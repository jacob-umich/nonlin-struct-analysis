function delta = work_control(structure)
    % get loads. PF is loads from fixed end forces
    [P,PF]=structure.get_loads();
    P_total = P+PF;

    % total load applied at step 0
    lambda=0;

    % initial lambda for first increment
    lambda_i=0;
    d_lambda=0.2;

    % establising originial stiffness matrix to measure nonlinearity
    k_orig=structure.get_stiffness()(1:structure.n_free,1:structure.n_free);

    % setting initial stiffness matrix
    k_free=k_orig;

    % initialize displacements to be added to
    delta_free = zeros(structure.n_free,1);

    while true
        % define R for first iteration
        R = zeros(structure.n_dof,1);
        for j=1:2

            % update the increment lambda for the jth iteration
            lambda_i=lambda_i+d_lambda;

            % compute delta j
            delta_free_j=k_free\(P_total*d_lambda+R)(1:structure.n_free);
            % get total displacement at step j
            delta_free=delta_free+delta_free_j;
            structure.update_disp(delta_free);

            % get internal force for step j
            F = structure.get_internal_force()(structure.n_free,1);
            disp(F)

            % compute residual for step j
            R=P_total*(lambda+lambda_i)-F;

            % compute stiffness for step j+1
            k_free=structure.get_stiffness()(1:structure.n_free,1:structure.n_free);
            % stop iteration if residual is small
            if max(abs(R))<1e-3
                break
            end

            % compute d_lambda for step j+1
            d_lambda=-P_total(1:structure.n_free)'*(k_free\R(1:structure.n_free))/(P_total(1:structure.n_free)'*(k_free\P_total(1:structure.n_free)));

        end
        % update accumulated lambda
        lambda = lambda+lambda_i;

        % compute lambda for next increment
        S =P_total'*k_orig*P_total/(P_total'*k_free*P_total)
        d_lambda=0.2*S

        %stop condition
        if lambda>=1 || S<0
            break
        end

    end
    % end result is displacments. structure object now has new displacments
    delta = zeros(structure.n_dof,1)
    delta(structure.n_free)=delta_free
endfunction

