
function [Best_flame_score,Best_flame_pos,cg_curve]=mfo(SearchAgents_no,Max_iteration,lb,ub,dim,fobj)

display('MFO is optimizing your problem');

%Initialize the positions of first random population of moths
Moth_pos=rand(SearchAgents_no,dim).*(ub-lb)+lb;

cg_curve=zeros(1,Max_iteration);

Iteration=1;

% Main loop
while Iteration<Max_iteration+1
    
    % Number of flames 
    Flame_no=round(SearchAgents_no-Iteration*((SearchAgents_no-1)/Max_iteration));
    
    for i=1:size(Moth_pos,1)
        
        % Check if moths go out of the search space and bring it back
        Flag4ub=Moth_pos(i,:)>ub;
        Flag4lb=Moth_pos(i,:)<lb;
        Moth_pos(i,:)=(Moth_pos(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;  
        
        % Calculate the score of moths
        Moth_score(1,i)=fobj(Moth_pos(i,:));  
        
    end
       
    if Iteration==1
        % Sort the first population of moths
        [score_sorted I]=sort(Moth_score);
        sorted_population=Moth_pos(I,:);
        
        % Update the flames
        best_flames=sorted_population;
        best_flame_score=score_sorted;
    else
        
        % Sort the moths
        double_population=[previous_population;best_flames];
        double_score=[previous_score best_flame_score];
        
        [double_score_sorted I]=sort(double_score);
        double_sorted_population=double_population(I,:);
        
        score_sorted=double_score_sorted(1:SearchAgents_no);
        sorted_population=double_sorted_population(1:SearchAgents_no,:);
        
        % Update the flames
        best_flames=sorted_population;
        best_flame_score=score_sorted;
    end
    
    % Update the best flame position obtained so far
    Best_flame_score=score_sorted(1);
    Best_flame_pos=sorted_population(1,:);
      
    previous_population=Moth_pos;
    previous_score=Moth_score;
    
    % cg_constant linearly decreases from -1 to -2 to calculate t
    cg_constant=-1+Iteration*((-1)/Max_iteration);
    
    for i=1:size(Moth_pos,1)
        for j=1:size(Moth_pos,2)
            % Update the position of the moth with respect to its corresponding flame
            if i<=Flame_no 
                
                % Eq. 1
                distance_to_flame=abs(sorted_population(i,j)-Moth_pos(i,j));
                b=1;
                t=(cg_constant-1)*rand+1;
                
                % Eq. 2
                Moth_pos(i,j)=distance_to_flame*exp(b.*t).*cos(t.*2*pi)+sorted_population(i,j);
            end
            
            % Update the position of the moth with respect to one flame
            if i>Flame_no 
                
                % Eq. 1
                distance_to_flame=abs(sorted_population(i,j)-Moth_pos(i,j));
                b=1;
                t=(cg_constant-1)*rand+1;
                
                % Eq. 2
                Moth_pos(i,j)=distance_to_flame*exp(b.*t).*cos(t.*2*pi)+sorted_population(Flame_no,j);
            end
        end
    end
    
    cg_curve(Iteration)=Best_flame_score;
    
    % Display the iteration and best optimum obtained so far
    if mod(Iteration,10)==0
        display(['At iteration ', num2str(Iteration), ' the best solution is ', num2str(Best_flame_score)]);
        
        %%write into file
        %filetemp = fopen('D:/UMS/4th Year Sem 2/Heuristic Algorithm/HW/HA result/alpinen2.csv','a');
        %fprintf(filetemp,'%s,%s\n',num2str(Iteration),num2str(Best_flame_score));
        %fclose(filetemp);
        %%
    end
    Iteration=Iteration+1; 
end