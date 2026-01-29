function [Ghn] = KNNgraph(X,opt)
X = X';
N = size(X,1);
Ghn = zeros(N,N);
[idx,distX] = knnsearch(X,X,'k',N);
Kn = opt.kmax;
idx_att = idx(:,1:Kn);
%%
for i = 1:N
    id_x = idx_att(i,1:Kn);
    di = distX(i,1:Kn);
    k=Kn-1;
    W = (di(Kn)-di)/(k*di(Kn)-sum(di(1:k))+eps);
    Ghn(i,id_x) = W;
end
