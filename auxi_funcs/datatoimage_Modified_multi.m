function [x] = datatoimage_Modified_multi(x_data,window_size,H,W,cx)
i_d = floor(window_size/2);
i_u = window_size - (i_d + 1);
j_d = floor(window_size/2);
j_u = window_size - (j_d + 1);
k = 1;
for i = i_d+1:window_size:H-i_u
    for j = j_d+1:window_size:W-j_u
        x(i-i_d:i+i_u,j-j_d:j+j_u,1:cx) = reshape(x_data(:,k),[window_size window_size cx]);
        k = k + 1;
    end
    if mod(W,window_size)~=0
        x(i-i_d:i+i_u,W-window_size+1:W,1:cx) = reshape(x_data(:,k),[window_size window_size cx]);
        k = k + 1;
    end
end
if mod(H,window_size)~=0
    for j = j_d+1:window_size:W-j_u
        x(H-window_size+1:H,j-j_d:j+j_u,1:cx) = reshape(x_data(:,k),[window_size window_size cx]);
        k = k + 1;
    end
    if mod(W,window_size)~=0
        x(H-window_size+1:H,W-window_size+1:W,1:cx) = reshape(x_data(:,k),[window_size window_size cx]);
        k = k + 1;
    end
end