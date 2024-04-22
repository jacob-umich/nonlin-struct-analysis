function [delta,lambda] = arc_control(structure,track_changes)
    % get loads. PF is loads from fixed end forces
    [P,PF]=structure.get_loads();
    P_total = P+PF;

    % total load applied at step 0
    lambda=0;

    % initial lambda for first increment
    d_lambda=0.2;

    % establising originial stiffness matrix to measure nonlinearity
    k_orig=structure.get_stiffness();
    k_orig = k_orig(1:structure.n_free,1:structure.n_free);

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

        % getting first delta for arc control
        total = ((P_total(1:structure.n_free,1)*d_lambda)+R);
        delta_free_j_1=k_free\total(1:structure.n_free);
        d_lambda_j_1 = d_lambda;

        % 50 is an arbitrary stopping point.
        for j=1:50

            % update the lambda for the ith increment with the jth iteration
            lambda_i=lambda_i+d_lambda;

            % compute delta j
            total = ((P_total(1:structure.n_free,1)*d_lambda)+R);
            delta_free_j=k_free\total(1:structure.n_free);

            % get total displacement at step j
            delta_free=delta_free+delta_free_j;
            structure.update_disp(delta_free_j);

            % get internal force for step j
            F = structure.get_internal_force();
            F = F(1:structure.n_free,1);

            % compute residual for step j
            P = (P_total*(lambda+lambda_i));
            R=P(1:structure.n_free,1)-F;

            % stop iteration if residual is small
            if max(abs(R))<1e-3
                break
            end
            
            % compute stiffness for step j+1
            k_free= structure.get_stiffness();
            k_free = k_free(1:structure.n_free,1:structure.n_free);


            % compute d_lambda for step j+1
            dDelta_double_bar = (k_free\R(1:structure.n_free));
            dDelta_bar = (k_free\P_total(1:structure.n_free));
            numerator = -delta_free_j_1'*dDelta_double_bar;
            denominator = delta_free_j_1'*dDelta_bar+d_lambda_j_1;
            d_lambda=numerator/denominator;

        end
        % update accumulated lambda
        lambda = lambda+lambda_i;
        % compute dlambda for next increment
        d_delta_bar_1 = k_orig\P_total(1:structure.n_free);
        d_delta_bar_i = k_free\P_total(1:structure.n_free);
        S = (P_total(1:structure.n_free)'*d_delta_bar_1)/(P_total(1:structure.n_free)'*d_delta_bar_i);
        e = min(eig(k_free));
        d = min(diag(k_free));
        if e<0
            sign = -1;
        else
            sign = 1;
        end
        fprintf("lambda: %f\n",lambda)
        fprintf("S: %f\n",S)
        fprintf("e: %f\n",e)
        d_lambda=sign *0.001*abs(S)^(1/2);
        %stop condition .arbitrarily stopping slightly after post peak response.
        if lambda>=1 || e<=0 ||count>2000
            if e<0
                warning("Critical point passed. displayed reactions will not show full capacity.")
                break
            end
            break
        end
        if track_changes
            delta = zeros(structure.n_dof,1);
            delta(1:structure.n_free)=delta_free;
            structure.store_load_disp(delta,lambda)
        end

    end
    % end result is displacments. structure object now has new displacments
    delta = zeros(structure.n_dof,1);
    delta(1:structure.n_free)=delta_free;
end

