%algo_Cuckoo.m - Cuckoo Search Algorithm
function algo_Cuckoo(lbound, ubound, func)
    
    %%Initialization
    %% n, max_iteration, pa can be adjust
    n = 100; %number of nests
    max_iteration = 3000;
    max_ite_vector = 1:max_iteration; 
    pa = 0.5;

    % Random initial solution
    for index=1:n,

    x = (ubound-lbound).*rand(1,10) + lbound; %rand(rownum, colnum)
    %x = zeros(1,10);
    switch func
        case 1
            nest(:,index)=func_Ackley(x);
        case 2
            nest(:,index)=func_zakharovfcn(x);
        case 3
            nest(:,index)=func_qingfcn(x);
        case 4
            nest(:,index)=func_xinsheyangn2(x);
        case 5 
            nest(:,index)=func_alpinen2fcn(x);
    end

    nest = sort(nest, 'descend');
    end

    %%While iteration is not max
    for iteration = 1:max_iteration
        %Generate and cuckoo egg by Levy flight
        cuckoo_egg = levy(1,10);
        switch func
            case 1
                cuckoo_egg_fitness=func_Ackley(cuckoo_egg);
            case 2
                cuckoo_egg_fitness=func_zakharovfcn(cuckoo_egg);
            case 3
                cuckoo_egg_fitness=func_qingfcn(cuckoo_egg);
            case 4
                cuckoo_egg_fitness=func_xinsheyangn2(cuckoo_egg);
            case 5 
                cuckoo_egg_fitness=func_alpinen2fcn(cuckoo_egg);
        end

        %choose a random nest
        rand_nest_index = round(((n-1)*rand(1) + 1));
        if nest(:, rand_nest_index) > cuckoo_egg_fitness
            nest(:, rand_nest_index) = cuckoo_egg_fitness;
        end

        nest = sort(nest,'descend');
        %abandon a fraction pa of worst nest and generate new nest

        worst_nest_index = round(pa * n);
        for worst_counter = 1:worst_nest_index
            x = (ubound-lbound).*rand(1,10) + lbound; %rand(rownum, colnum)
            switch func
                case 1
                    nest(:, worst_counter) = func_Ackley(x);
                case 2
                    nest(:, worst_counter) = func_zakharovfcn(x);
                case 3
                    nest(:,worst_counter)=func_qingfcn(x);
                case 4
                    nest(:,worst_counter)=func_xinsheyangn2(x);
                case 5 
                    nest(:,worst_counter)=func_alpinen2fcn(x);
            end
            nest = sort(nest, 'descend');
        end

        best(:,iteration) = nest(:,n);
        disp(['Best solution in iteration ', num2str(iteration), ' is: ' ,num2str(nest(end))]);
    end

    plot(max_ite_vector, best);
    disp(['Best solution is: ' num2str(nest(end))]);
    %disp(['Your choice was ' num2str(algo) ' with upper bound of ' num2str(ubound) ', and lower bound of ' num2str(lbound) ]);
end