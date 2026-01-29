clear;
close all
addpath(genpath(pwd))
%%
img_t1=imread('img_t1.bmp');
img_t2=imread('img_t2.bmp');
Ref_gt = imread('Refgt.bmp');
Ref_gt = double(Ref_gt(:,:,1));
Ref_gt= Ref_gt/max(Ref_gt(:));
figure;
subplot(131);imshow(img_t1,[]);
subplot(132);imshow(img_t2,[]);
subplot(133);imshow(Ref_gt,[]);
%%
opt.type_t1 = 'sar'; % 'optical', 'sar'
opt.type_t2 = 'optical';
[row, col,cy] = size(img_t1);
opt.levels = floor(log2(sqrt(col*row)/100));
opt.lamda = 2^-5;
opt.alfa = 0.5; 
opt.radius =  32:-4:8;
%% GiToF
fprintf(['\n' '====================================================================== ' '\n'])
fprintf(['\n GiToF is running...... ' '\n'])
time = clock;
[DI_all] = GiToF_main(img_t1,img_t2,opt);
fprintf(['\n' '====================================================================== ' '\n'])
fprintf('\n');fprintf('The total computational time of GiToF is %i \n' ,etime(clock,time));
fprintf(['\n' '====================================================================== ' '\n'])
%% Displaying results
fprintf(['\n Displaying the results...... ' '\n'])
num_DI = size(DI_all,3);

figure
for i = 1:num_DI-1 
    subplot(1,num_DI,i);imshow(remove_outlier(DI_all(:,:,i)),[]),title(['DI of the' num2str(i) '-th level'])
end
subplot(1,num_DI,num_DI);imshow(remove_outlier(DI_all(:,:,num_DI)),[]),title(['fused DI'])
colormap(spring)

for i = 1:size(DI_all,3)
    [TPR_forward, FPR_forward]= Roc_plot(DI_all(:,:,i),Ref_gt,500);
    [Precision_forward, Recall_forward]= PR_plot(DI_all(:,:,i),Ref_gt,500);
    [AUR(i), ~] = AUC_Diagdistance(TPR_forward, FPR_forward);
    [AUP(i),~] = AUC_Diagdistance(Precision_forward, Recall_forward);
end

fprintf('Level\tAUR\t\tAUP\n');
fprintf('---------------------------\n');
for i = 1:length(AUP)-1
    fprintf('%d\t%.4f\t%.4f\n', i, AUR(i), AUP(i));
end
fprintf('Fused\t\t%.4f\t%.4f\n', AUR(end), AUP(end));