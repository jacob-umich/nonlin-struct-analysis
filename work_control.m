function [delta,lambda] = work_control(structure,track_changes=false)
    % get loads. PF is loads from fixed end forces
    [P,PF]=structure.get_loads();
    P_total = P+PF;

    % total load applied at step 0
    lambda=0;

    % initial lambda for first increment
    lambda_i=0;
    d_lambda=0.2;

    % establising originial stiffness matrix to measure nonlinearity
    k_orig=structure.get_tan_stiffness()(1:structure.n_free,1:structure.n_free);

    % setting initial stiffness matrix
    k_free=k_orig;

    % initialize displacements to be added to
    delta_free = zeros(structure.n_free,1);
    count = 1;
    while true
        fprintf("increment %i\n",count)
        count = count +1;
        % define R for first iteration
        R = zeros(structure.n_free,1);
        lambda_i=0;

        % 50 is an arbitrary stopping point.
        for j=1:50

            % update the lambda for the ith increment with the jth iteration
            lambda_i=lambda_i+d_lambda;

            % compute delta j
            delta_free_j=k_free\((P_total(1:structure.n_free,1)*d_lambda)+R)(1:structure.n_free);

            % get total displacement at step j
            delta_free=delta_free+delta_free_j;
            structure.update_disp(delta_free_j);

            % get internal force for step j
            F = structure.get_internal_force()(1:structure.n_free,1);

            % compute residual for step j
            R=(P_total*(lambda+lambda_i))(1:structure.n_free,1)-F;

            % compute stiffness for step j+1
            k_free= structure.get_tan_stiffness()(1:structure.n_free,1:structure.n_free);

            % stop iteration if residual is small
            if max(abs(R))<1e-3
                break
            end

            % compute d_lambda for step j+1
            dDelta_double_bar = (k_free\R(1:structure.n_free));
            dDelta_bar = (k_free\P_total(1:structure.n_free));
            numerator = P_total(1:structure.n_free)' *dDelta_double_bar;
            denominator = P_total(1:structure.n_free)'*dDelta_bar;
            d_lambda=-numerator/denominator;

        end
        % update accumulated lambda
        lambda = lambda+lambda_i;
        if track_changes
            delta = zeros(structure.n_dof,1);
            delta(1:structure.n_free)=delta_free;
            structure.store_load_disp(delta,lambda)
        end
        % compute dlambda for next increment
        S = (P_total(1:structure.n_free)'*k_orig*P_total(1:structure.n_free))/(P_total(1:structure.n_free)'*k_free*P_total(1:structure.n_free));
        e = min(eig(k_free));
        if e<0
            sign = -1;
        else
            sign = 1;
        end
        fprintf("lambda: %f\n",lambda)
        fprintf("S: %f\n",S)
        fprintf("e: %f\n",e)
        d_lambda=sign *0.1*abs(S)^(1/2);
        %stop condition .arbitrarily stopping slightly after post peak response.
        if lambda>=1 || e<0
            if e<0
                warning("Critical point passed. displayed reactions will not show full capacity.")
                break
            end
            break
        end

    end
    % end result is displacments. structure object now has new displacments
    delta = zeros(structure.n_dof,1);
    delta(1:structure.n_free)=delta_free;
endfunction

