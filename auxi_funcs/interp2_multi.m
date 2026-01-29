function Iw = interp2_multi(I,x,y)
R = I(:,:,1);  % Red channel
G = I(:,:,2);  % Green channel
B = I(:,:,3);  % Blue channel
Iw_R = interp2(R,x,y,'linear');
Iw_G = interp2(G,x,y,'linear');
Iw_B = interp2(B,x,y,'linear');
Iw = cat(3, Iw_R, Iw_G, Iw_B);