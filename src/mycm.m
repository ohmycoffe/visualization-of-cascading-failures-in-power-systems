function mycm(choice)
    switch choice
        case 1
            c = jet;
        case 2
            c = [0 0 0
                0 0 1
                0 1 1
                1 1 0
                1 0.75 0
                1 0 0
                ];
        otherwise
            c=jet;
    end

    colormap(c);
end

