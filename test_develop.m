
m = vec2mat((1:1:25),5,5);

k = 0;
for i=1:size(m,1)
    for j=1:size(m,2)
        k = k + 1;
        [tx,  ty] = ind2sub([5,5], k);
        disp(num2str([i, j, k, ty, tx]))
    end
end