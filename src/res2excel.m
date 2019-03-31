function res2excel(res, filename)

    names = fieldnames(res);

    for i = 1: numel(names)
        if(~isstruct(res.(names{i})));
          xlswrite(filename,res.(names{i}),names{i});
        end
    end
end