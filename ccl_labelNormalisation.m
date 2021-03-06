%function [ components_img, labelCount ] = ccl_labelNormalisation(runlengthTable, bw_img)
runlengthTable = ccl_runLengthLabeling();


% hier werden die Werte der Labels zuerst normalisiert, sodass diese eine
% durchgehende Nummerierung haben,
% anschlie?end wird das Ursprungsbild anhand dieser Labels ge?ndert
% zur?ckgegeben wird das gelabelte Logical-Bild und die Anzahl der darin
% enthaltenen Components

[~, num] = size(runlengthTable);

% Wir bauen eine Label Map aus (altemLabel, normalisiertesLabel) auf. 
% Die normalisierten Label beginnen bei 1 und zaehlen ohne Luecke nach oben. 
labelMap = containers.Map('KeyType','int32','ValueType','int32');
normalizedLabelCount = 0;

for x=1:num
    
    currentLabel = runlengthTable{x}(4);
    
    % Exisiert fuer ein altes Label noch kein Eintrag in der Map, so wir
    % einer erstellt und diesem alten Label ein neues normalisiertes Label
    % zugewiesen
    if ~labelMap.isKey(currentLabel) 
       normalizedLabelCount = normalizedLabelCount + 1;
       labelMap(currentLabel) = normalizedLabelCount;
    end
    
    % nun ersetzen wir noch gleich jedes Label durch sein zugehoeriges 
    % normalisiertes Label
    runlengthTable{x}(4) = labelMap(currentLabel);
    
end

% der erste Rueckgabeparameter ist bereits fertig!
num = normalizedLabelCount;


% jetzt bauen wir aus unserem Binaerbild noch ein neues Bild auf, in dem
% alle Pixel einer Components mit ihrem Componentlabel versehen ist

components_img = zeros(size(bw_img));

for tableIndex = 1:num
    
    data = runlengthTable{tableIndex};
    row = data(1);
    startX = data(2);
    endX = data(3);
    label = data(4);
    %[row, startX, endX, label] = runlengthTable{tableIndex};
    
    for x=startX:endX
        components_img(row,x) = label;
    end
  
end

% TEST
imshow(label2rgb(components_img))
     
     

