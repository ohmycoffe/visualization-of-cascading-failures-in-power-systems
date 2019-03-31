function [mpr, isolData,mpck] = solvePF(mpr, solverType)
    %solvePF: Funkcja izoluj¹ca wêz³y pozbawione po³¹czeñ z sieci¹ oraz
    %rozwi¹zuj¹ca rozp³yw mocy
    %   
    define_constants

    isolData.bus = [];
    isolData.branch = [];
    isolData.gen = [];

    mpck = extract_islands(mpr);

    noIslands = numel(mpck);
    if noIslands > 1

        for id=1:noIslands
            if ~isempty(find(mpck{id}.bus(:, BUS_TYPE) == 3,1))
                mpr = mpck{id};
            else
                isolData.bus = [ isolData.bus; mpck{id}.bus(:, BUS_I) ...
                                mpck{id}.bus(:, PD)];
                isolData.branch = [ isolData.branch; mpck{id}.branch(:, F_BUS) ...
                                mpck{id}.branch(:, T_BUS)];   
                isolData.gen = [ isolData.gen; mpck{id}.gen(:, GEN_BUS) ...
                                mpck{id}.gen(:, PG)];  
            end
        end
        %06-11-2016 Dodanie generacji do struktury isolData.bus
        % isolData.bus = ['idBus' 'PD' 'PG']
        isolData.bus(:,3) = 0;
        [~,temp,~] = intersect(isolData.bus(:,1), isolData.gen(:,1),'rows','stable');
        isolData.bus(temp,3) = isolData.gen(:,2); 
    else
        mpr = mpck{1};
    end    

    if ~isempty(mpr.gen(:, GEN_STATUS)>0)
    switch nargin
        case 1
            mpr = runpf(mpr);
        case 2    
            solverType = mpoption('model', solverType);
            mpr = runpf(mpr, solverType);
    end
    else 
        mpr.success = 0;
    end
end

