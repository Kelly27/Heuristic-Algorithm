%algo_bat.m - Bat algorithm
function algo_bat(lbound, ubound, func)
    n=500;          % Population size
    N_gen=600;      % Number of generations
    A=0.5;          % Loudness
    r=0.5;          % Pulse rate
    d=10;           % Number of dimensions 
    N_iter=0;       % Total number of function evaluations

    Qmin=0;         % Frequency minimum
    Qmax=2;         % Frequency maximum

    Lb=lbound*ones(1,d); % Lower limit
    Ub=ubound*ones(1,d);% Upper limit

    Q=zeros(n,1);   % Frequency
    v=zeros(n,d);   % Velocities

    % Initialize the population
    for i=1:n,
      Sol(i,:)=Lb+(Ub-Lb).*rand(1,d);
      Sol(i,:)=simplebounds(Sol(i,:),Lb,Ub);
      switch func
        case 1
            Fitness(i)=func_Ackley(Sol(i,:));
        case 2
            Fitness(i)=func_zakharovfcn(Sol(i,:));
        case 3
            Fitness(i)=func_qingfcn(Sol(i,:));
        case 4
            Fitness(i)=func_xinsheyangn2(Sol(i,:));
        case 5 
            Fitness(i)=func_alpinen2fcn(Sol(i,:));
      end
    end

    % Find the initial best solution
    [fmin,I]=min(Fitness);
    best=Sol(I,:);

    for t=1:N_gen,

        for i=1:n,
            Q(i)=Qmin+(Qmax-Qmin)*rand;
            v(i,:)=v(i,:)+(Sol(i,:)-best)*Q(i);
            S(i,:)=Sol(i,:)+v(i,:);

            % Apply simple bounds
            Sol(i,:)=simplebounds(Sol(i,:),Lb,Ub);

            % Random walks using pulse
            if rand>r
                S(i,:)=best+0.1*randn(1,d);
            end

            % Apply simple bounds
            S(i,:)=simplebounds(S(i,:),Lb,Ub);

            % Evaluate new solutions
            switch func
                case 1
                    Fnew=func_Ackley(S(i,:));
                case 2
                    Fnew=func_zakharovfcn(S(i,:));
                case 3
                    Fnew=func_qingfcn(S(i,:));
                case 4
                    Fnew=func_xinsheyangn2(S(i,:));
                case 5 
                    Fnew=func_alpinen2fcn(S(i,:));
            end

            % Update if the solution improves, or not too loud
            if (Fnew<=Fitness(i)) & (rand<A) ,
                Sol(i,:)=S(i,:);
                Fitness(i)=Fnew;
            end

            % Update the current best solution
            if Fnew<=fmin,
                best=S(i,:);
                fmin=Fnew;
            end

        end

        % Store and arrange the best score for each iteration
        bestc(:,t)=fmin;
        bestc=sort(bestc,'descend');
        disp(['Iteration: ' num2str(t) ' Best Cost:' num2str(bestc(:,t))]);
        N_iter=N_iter+n;
    end

    %% Output/display
    disp(['Number of evaluations: ',num2str(N_iter)]);
    disp(['Best =',num2str(best)]);
    disp(['Fmin=',num2str(fmin)]);

    m = 1:N_gen;
    plot(m,bestc);
end