function [hPlot,hGraph,hBar]=plotGrid_o(mpr)

    define_constants
    mycm(1);

    noBr = size(mpr.branch,1);
    nodeLabel = mpr.bus(:,BUS_I);
    fb = mpr.branch(:,F_BUS);
    tb = mpr.branch(:,T_BUS);
    pf = mpr.branch(:,PF);
    qf = mpr.branch(:,QF);

    %Power flow sf ma kierunek taki jak moc czynna
    sf = sign(pf).*sqrt(pf.^2+qf.^2);
    flow_limit = mpr.branch(:,RATE_A);
    % Obciazenie danej linii
    lf = sf./flow_limit;

    hGraph = digraph(fb, tb, lf);

    LWidths = 5*abs(hGraph.Edges.Weight)+0.001;

    LColor = abs(hGraph.Edges.Weight);

    %Dodanie podpisów na krawêdziach
    temp_string1 = num2str(round(hGraph.Edges.Weight,2));
    temp_string2 = cellstr(repmat({''},noBr,1));
    edgeLabels = strcat(temp_string1,temp_string2);

    %wyroznienie gruboscia linii oraz kolorem w funkcji obciazenia
    hPlot = plot(hGraph,'Layout','force','Iterations', 250,'LineWidth',LWidths,...
            'EdgeCData',LColor,'EdgeLabel', edgeLabels, 'NodeLabel', nodeLabel);
    % Options: 'auto' (default) | 'circle' | 'force' | 'layered' | 'subspace'

    %Wyzerowanie osi
    set(gca, 'XTick', [], 'YTick', [])

    %Wyroznienie linia przerywana linii wylaczonych 
    id2 = (hGraph.Edges.Weight==0);
    highlight(hPlot,hGraph.Edges.EndNodes(id2,1),hGraph.Edges.EndNodes(id2,2),...
        'LineStyle','--')

    %dodanie belki z kolorami
    hBar = colorbar('Ticks', [0 0.25 0.5 0.75 1 1.25 1.5]); 
    caxis(gca,[0 1.50]);
end

