function P = pyramid_multi(I,lvl)
P=cell(lvl+1,1);
P{1}=I;
for k=1:lvl
    P{k+1}=(pyramBurt_multi(P{k}));
end

function N = pyramBurt_multi(M)
a = 0.4;
burt1D = [1/4-a/2,1/4,a,1/4,1/4-a/2];
N = convSep_multi(M,burt1D);
N = N(1:2:end,1:2:end,:);
end
end