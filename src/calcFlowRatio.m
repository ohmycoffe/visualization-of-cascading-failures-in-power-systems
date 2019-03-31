%% calcFlowRatio 
function [ flowRatio, noBr, fb, tb, pf, qf, sf, flow_limit] = calcFlowRatio( mpr )

define_constants
    noBr = size(mpr.branch,1);
    fb = mpr.branch(:,F_BUS);
    tb = mpr.branch(:,T_BUS);
    pf = mpr.branch(:,PF);
    qf = mpr.branch(:,QF);
    sf = sqrt(pf.^2+qf.^2);
    flow_limit = mpr.branch(:,RATE_A);
    % Obciazenie danej linii
    flowRatio = sf./flow_limit;

end

