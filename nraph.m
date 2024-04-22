function [delta,lambda] = nraph(structure,track_changes)
    % get loads. PF is loads from fixed end forces
    [P,PF]=structure.get_loads();
    P_total = P+PF;

    % total load applied at step 0
    lambda=0;

    % initial lambda for first increment
    d_lambda=0.2;

    % establising originial stiffness matrix to measure nonlinearity
    k_orig=structure.get_tan_stiffness();
    k_orig=k_orig(1:structure.n_free,1:structure.n_free);

    % setting initial stiffness matrix
    k_free=k_orig;

    % initialize displacements to be added to
    delta_free = zeros(structure.n_free,1);
    count = 1;
    while true
        count = count +1;
        % define R for first iteration
        R = zeros(structure.n_free,1);
        lambda_i=0;

        % save an old delta for when solution cant converge
        delta_old=delta_free;

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
            p = (P_total*(lambda+lambda_i));
            R=p(1:structure.n_free,1)-F;

            % compute stiffness for step j+1
            k_free= structure.get_tan_stiffness();
            k_free = k_free(1:structure.n_free,1:structure.n_free);

            % stop iteration if residual is small
            if max(abs(R))<1e-3
                break
            end

            % compute d_lambda for step j+1
            d_lambda=0;

        end

        % break loop and send warning if critical point is found
        if max(abs(R))>=1e-3
            warning("maximum iterations achieved. critical point observed. stopping simulation")
            fprintf("final lambda: %f\n", lambda)
            structure.reset_pos()
            structure.update_disp(delta_old)
            break
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
        d_lambda=0.001*S;
        %stop condition .arbitrarily stopping slightly after post peak response.
        if lambda>=1 || S<-0.5||count>2000
            break
        end

    end
    % end result is displacments. structure object now has new displacments
    delta = zeros(structure.n_dof,1);
    delta(1:structure.n_free)=delta_free;
end
