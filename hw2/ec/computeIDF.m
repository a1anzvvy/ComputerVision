function [IDF] = computeIDF(HorR,k)
    % Set Path
    alpha = 50;
    if strcmp(HorR,'Harris')
        RandomORHarris = '_H/';
    end
    
    if strcmp(HorR,'Random')
        RandomORHarris = '_R/';
    end
    
    % Build path
    path = strcat('../result_p',num2str(alpha),'_k',num2str(k),RandomORHarris);
    load('../data/traintest.mat');
    filterBank = createFilterBank();

    % Count each word frequency
    wordCounts = zeros(k,1);
    for i = 1:size(train_imagenames,2)
        eachPath = train_imagenames{i}(1:end-3);
        eachPath = strcat(path,eachPath,'mat');
        wordMap = load(eachPath);
        wordMap = wordMap.wordMap;
        for j = 1:k
           if sum(sum(wordMap(wordMap==j))) > 0
               wordCounts(j) = wordCounts(j)+1;
           end
        end
    end
    
    IDF = log(size(train_imagenames,2)./wordCounts);
    IDF = IDF';
    IDF = IDF/norm(IDF,1);
    
    save('idf.mat','IDF');

end