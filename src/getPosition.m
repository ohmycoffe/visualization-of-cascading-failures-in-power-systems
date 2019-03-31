function Position = getPosition(figure_type, widthF, heighF)

    screenSize = get(0,'Screensize');
    xp = screenSize(3);
    yp = screenSize(4);
    
        switch figure_type
        case 'menu'     
                Position = [(xp-2*widthF)/2,(yp-heighF)/2,widthF,heighF];
        case 'graph'  
                Position = [(xp)/2+10,(yp-heighF)/2,widthF,heighF];
        otherwise
            warning('Unexpected type')
        end
end

