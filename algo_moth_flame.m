%Moth Flame Optimization
function algo_moth_flame(lbound, ubound, func)
    SearchAgents_no=1000; % Number of search agents

    Max_iteration=300; % Maximum number of iterations

    % Load details of function
    lb=lbound;  
    ub=ubound;   
    dim=10;
    [fobj]=load_var_mfo(func);

    %%write into file 
    %filetemp = fopen('D:/UMS/4th Year Sem 2/Heuristic Algorithm/HW/HA result/alpinen2.csv','a');
    %fprintf(filetemp,'\n\n');%'Iteration,Best solution\n');
    %fclose(filetemp);
    %%

    %MFO algorithm
    [Best_flame_score,Best_flame_pos,cg_curve]=mfo(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);

    %Draw convergence curve
    plot(cg_curve) 
    title('Convergence curve')
    xlabel('Iteration');
    ylabel('Best flame (score)');

    axis tight
    legend('MFO')

    display(['The best solution obtained by MFO is : ', num2str(Best_flame_pos)]);
    display(['The best optimal value of the objective function found by MFO is : ', num2str(Best_flame_score)]);

    %%write into file
    %filetemp = fopen('D:/UMS/4th Year Sem 2/Heuristic Algorithm/HW/HA result/alpinen2.csv','a');
    %fprintf(filetemp,'Best position,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n',num2str(Best_flame_pos(1)),num2str(Best_flame_pos(2)),num2str(Best_flame_pos(3)),num2str(Best_flame_pos(4)),num2str(Best_flame_pos(5)),num2str(Best_flame_pos(6)),num2str(Best_flame_pos(7)),num2str(Best_flame_pos(8)),num2str(Best_flame_pos(9)),num2str(Best_flame_pos(10)));
    %fclose(filetemp);
    %%
end