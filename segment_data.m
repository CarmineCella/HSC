function [positions, segments] = segment_data (sc, indexes, K, labels)
segments = cell (1, K);
positions = cell (1, K);
for i = 1 : K
    %t1 = zeros (size (sc));
    %t1 (:, labels == i) = sc (:, labels == i);
    segments{i} = sc (:, labels == i);
    positions{i} = indexes (1, labels == i);
end
