function mpc = reNum(mpc)
    define_constants
    noBus = size(mpc.bus,1);
    copyMpc = mpc;
    mpc.bus(:,BUS_I) = 1:noBus;

    for i = 1 : noBus
       idBusNoF = mpc.branch(:,F_BUS)==copyMpc.bus(i,BUS_I);
       mpc.branch(idBusNoF,F_BUS) = mpc.bus(i,BUS_I);
       idBusNoT = mpc.branch(:,T_BUS)==copyMpc.bus(i,BUS_I);
       mpc.branch(idBusNoT,T_BUS) = mpc.bus(i,BUS_I); 

       idGenNo = mpc.gen(:,GEN_BUS)==copyMpc.bus(i,BUS_I); 
       mpc.gen(idGenNo,GEN_BUS) = mpc.bus(i,BUS_I); 

    end
end    