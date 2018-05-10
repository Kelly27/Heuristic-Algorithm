
%% algo_grey_wolf.m - Grey Wolf Optimizer
function algo_grey_wolf(lbound, ubound, func)

    %% Problem Definition
    % Cost Function
    switch func 
        case 1
            CostFunction = @(x) func_Ackley(x);
        case 2
            CostFunction = @(x) func_zakharovfcn(x);
        case 3
            CostFunction = @(x) func_qingfcn(x);
        case 4
            CostFunction = @(x) func_xinsheyangn2(x);
        case 5 
            CostFunction = @(x) func_alpinen2fcn(x);
    end

    nVar = 10;              % Number of Unknown (Dimension) Variables
    VarMin = lbound;       % Lower Bound
    VarMax = ubound;        % Upper Bound

    %% Parameters of GWO
    MaxIt = 3000;        % Maximum Number of Iterations
    %iteration_vector = 1:MaxIt;
    nPop = 100;          % Population Size (number of search agents)

    %% Initialization
    % Initialize Alpha, Beta, and Delta Position
    Alpha.Position = zeros(1,nVar);
    Alpha.Cost = inf;%change this to -inf for maximization problems
    Beta.Position = zeros(1,nVar);
    Beta.Cost = inf;%change this to -inf for maximization problems
    Delta.Position = zeros(1,nVar);
    Delta.Cost = inf;%change this to -inf for maximization problems

    %Initialize the positions of search agents
    Positions = rand(nPop,nVar).*(VarMax-VarMin)+VarMin;
    convergence_curve=zeros(1,MaxIt);
    current_cost=0;

    %% Main Loop of GWO
    for it=1:MaxIt
       for i=1:size(Positions,1)

            % Return back the search agents that go beyond the boundaries of the search space
            flag4ub = Positions(i,:)>VarMax;
            flag4lb = Positions(i,:)<VarMin;
            Positions(i,:) = (Positions(i,:).*(~(flag4ub+flag4lb)))+VarMax.*flag4ub+VarMin.*flag4lb;

            % Calculate objective function for each search agent
            fitness = CostFunction(Positions(i,:));

            % Update Alpha, Beta, and Delta
            if fitness<Alpha.Cost 
                Alpha.Cost = fitness;
                Alpha.Position = Positions(i,:);
            end

            if fitness>Alpha.Cost && fitness<Beta.Cost 
                Beta.Cost = fitness;
                Beta.Positions = Positions(i,:);
            end

            if fitness>Alpha.Cost && fitness>Beta.Cost && fitness<Delta.Cost 
                Delta.Cost = fitness;
                Delta.Positions = Positions(i,:);
            end
       end

       a = 2-1*((2)/MaxIt);   % a decreases linearly fron 2 to 0

       % Update the Position of search agents including omegas
       for i=1:size(Positions,1)
           for j=1:size(Positions,2)

                % part 1
                r1.Alpha = rand();        % r1 is a random number in [0,1]
                r2.Alpha = rand();        % r2 is a random number in [0,1] 
                A.Alpha = 2*a*r1.Alpha-a;      % Equation (3.3)
                C.Alpha = 2*r2.Alpha;          % Equation (3.4)

                D.Alpha = abs(C.Alpha*Alpha.Position(j)-Positions(i,j));     % Equation (3.5)
                X.Alpha = Alpha.Position(j)-A.Alpha*D.Alpha;                      % Equation (3.6)

                % part 2
                r1.Beta = rand();        % r1 is a random number in [0,1]
                r2.Beta = rand();        % r2 is a random number in [0,1] 
                A.Beta = 2*a*r1.Beta-a;      % Equation (3.3)
                C.Beta = 2*r2.Beta;          % Equation (3.4)

                D.Beta = abs(C.Beta*Beta.Position(j)-Positions(i,j));       % Equation (3.5)
                X.Beta = Beta.Position(j)-A.Beta*D.Beta;                        % Equation (3.6)

                % part 3
                r1.Delta = rand();        % r1 is a random number in [0,1]
                r2.Delta = rand();        % r2 is a random number in [0,1] 
                A.Delta = 2*a*r1.Delta-a;      % Equation (3.3)
                C.Delta = 2*r2.Delta;          % Equation (3.4)

                D.Delta = abs(C.Delta*Delta.Position(j)-Positions(i,j));     % Equation (3.5)
                X.Delta = Delta.Position(j)-A.Delta*D.Delta;                      % Equation (3.6)

                Positions(i,j) = (X.Alpha+X.Beta+X.Delta)/3;% Equation (3.7)

           end
       end
       convergence_curve(:,it) = Alpha.Cost;


       % Show Iteration Information
       if(current_cost ~= convergence_curve(:,it) || it == MaxIt)
        disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(convergence_curve(it))]);
        current_cost = convergence_curve(:,it);
       end
    end

    Best.Position = Alpha.Position;
    Best.Cost = Alpha.Cost;
    %abc(loop,:)=Best.Cost;

    %% Results

    %Draw objective space
    figure;
    semilogy(convergence_curve,'LineWidth',2);
    % plot(iteration_vector,convergence_curve);
    title('Objective space');
    xlabel('Iteration');
    ylabel('Best Cost');

    grid on

    display(['The best solution obtained by GWO is : ', num2str(Best.Position)]);
    display(['The best optimal value of the objective funciton found by GWO is : ', num2str(Best.Cost)]);

end