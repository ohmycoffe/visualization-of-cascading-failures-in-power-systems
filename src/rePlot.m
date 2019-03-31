function [hPlotN,hBar]=rePlot(mpr,hGraph,XData,YData, NodeName)

    define_constants
    mycm(1);

    noG = size(hGraph.Edges,1);
    noBr = size(mpr.branch,1);

    %wyzerowanie wag
    hGraph.Edges.Weight(:) = 0;

    %
    fb = mpr.branch(:,F_BUS);
    tb = mpr.branch(:,T_BUS);
    pf = mpr.branch(:,PF);
    qf = mpr.branch(:,QF);

    %Power flow sf ma kierunek taki jak moc czynna
    sf = sign(pf).*sqrt(pf.^2+qf.^2);
    flow_limit = mpr.branch(:,RATE_A);
    % Stosunek obciazenia danej linii
    lf = sf./flow_limit;

    % Przypisanie nowych wag do grafu dla zmodyfikowanego, przez wy³aczenia
    % systemu. Porównanie macierzy - funkcja intersect
    tempB = [fb tb];
    [~,ig,ib] = intersect(hGraph.Edges.EndNodes,tempB,'rows','legacy');
    hGraph.Edges.Weight(ig) =  lf(ib);

    %Skalowanie d³ugoœci linii za pomoc¹ power flow, jeœli s¹ jakieœ
    %nienumeryczne œmieci, to gruboœæ linii ustala siê na 0,5. 1 w funkcji find
    %przyspiesza wykonanie (ogranicza liczbê wyszukiwanych niezerowych
    %elementow)

    if  isempty(find(~isfinite(hGraph.Edges.Weight),1))
        LWidths = 3*abs(hGraph.Edges.Weight)+0.1;
    else
        LWidths = 0.5;
    end

    %Dodanie podpisów na krawêdziach
    temp_string1 = num2str(round(hGraph.Edges.Weight,2));
    temp_string2 = cellstr(repmat({''},noG,1));

    edgeLabels = strcat(temp_string1,temp_string2);
    LColor = abs(hGraph.Edges.Weight);

    hPlotN = plot(hGraph,'LineWidth',LWidths,'EdgeCData',LColor,...
             'XData', XData, 'YData', YData, 'NodeLabel', NodeName,...
             'EdgeLabel', edgeLabels);    

    %Wyzerowanie osi
    set(gca, 'XTick', [], 'YTick', [])

    %Wyroznienie linia przerywana linii wylaczonych 
    id2 = (hGraph.Edges.Weight==0);
    highlight(hPlotN,hGraph.Edges.EndNodes(id2,1),hGraph.Edges.EndNodes(id2,2),...
        'LineStyle','--')
    %Dodanie belki z kolorami
    hBar = colorbar('Ticks', [0 0.25 0.5 0.75 1 1.25 1.5]); 
    caxis(gca,[0 1.50]);
end
