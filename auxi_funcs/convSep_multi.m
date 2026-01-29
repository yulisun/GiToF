function res = convSep_multi(I,fen)
c = size(I,3);
if c<2
    res = conv2(conv2(I,fen','same'),fen,'same');
else
    R = I(:,:,1);  % Red channel
    G = I(:,:,2);  % Green channel
    B = I(:,:,3);  % Blue channel
    conv_R = conv2(conv2(R,fen','same'),fen,'same');
    conv_G = conv2(conv2(G,fen','same'),fen,'same');
    conv_B = conv2(conv2(B,fen','same'),fen,'same');
    res = cat(3, conv_R, conv_G, conv_B);
end