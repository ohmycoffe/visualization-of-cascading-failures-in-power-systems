function mpc = check_graph( mpc )

    define_constants
    noMpcBr = size(mpc.branch,1);
    ftb=[mpc.branch(:,F_BUS) mpc.branch(:,T_BUS)];
    [~,id,~] = unique(ftb, 'rows', 'stable');
    temp_From = zeros(noMpcBr,1);
    repId = ones(noMpcBr,1);
    repId(id) = 0;
    repId = logical(repId);
    temp_From(repId) = mpc.branch(repId, F_BUS);
    mpc.branch(repId, F_BUS) = mpc.branch(repId, T_BUS);
    mpc.branch(repId, T_BUS) = temp_From(repId);
    %Posortowanie linii
    mpc.branch = sortrows(mpc.branch,[F_BUS T_BUS])
    clear repId temp_From;

end

