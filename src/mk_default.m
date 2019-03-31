function mpc = mk_default(mpc,I_MAX)
    %mk_default: Funkcja nadaj¹ca domyslne wartoœci limitow 
    %   S_lim [MVA] = sqrt(3) * 1.1 [kA] * Un_bus [kV]
    %   Jesli nie zdefiniowano napiêæ na wêz³ach to przyjmuje siê 220kV

    define_constants
    id = find(~mpc.branch(:, RATE_A));
    %Napiêcia wêz³ów
    mpc.bus(find(mpc.bus(:,BASE_KV)==0), BASE_KV) = 220;
    %Limity na liniach
    if(~isempty(id))
        noMpcBr = size(mpc.branch,1);
        which_bus(:,1) = mpc.branch(:, F_BUS);

        for i = 1 : noMpcBr 
            which_bus(i,2) = mpc.bus(find(mpc.bus(:,BUS_I)==which_bus(i,1)),BASE_KV);
        end

        mpc.branch(id, RATE_A) = sqrt(3)*I_MAX*which_bus(id,2)
    end
end

