%% �������ݸ�ʽ����ѡ�����ݼ�
switch DataName
    
    
    case 'Multilabel1'
% 25k������ 15kѵ�� 10k����
        load('bibtex_new.mat');
        image_labeled_feature = image_labeled_without_sift';   %ֻ����1857ά������
        text_labeled_feature  = text_labeled'; 
        
%  ��Ӧsplits �� epoch
        splits_index = 1;
        epoch_index = 1;
        
        prepar.trindx  =  flicker_splits{splits_index}.tr_index; % 25000 ��ѵ����index
        prepar.teindx  =  flicker_splits{splits_index}.te_index; % 25000 �в��Ե�index
        prepar.splits_index = splits_index;
        prepar.epoch_index  = epoch_index;
        
        
    case 'flicker_25k'
% 25k������ 15kѵ�� 10k����
        load('flicker_labeled_split_10_epoch_5.mat');
        image_labeled_feature = image_labeled_without_sift';   %ֻ����1857ά������
        text_labeled_feature  = text_labeled'; 
        
%  ��Ӧsplits �� epoch
        splits_index = 1;
        epoch_index = 1;
        
        prepar.trindx  =  flicker_splits{splits_index}.tr_index; % 25000 ��ѵ����index
        prepar.teindx  =  flicker_splits{splits_index}.te_index; % 25000 �в��Ե�index
        prepar.splits_index = splits_index;
        prepar.epoch_index  = epoch_index;
        
        
    case 'flicker_25_w10'
%  1995������ 1500ѵ�� 495���� ÿ����������>=10
%  check by chaos 2017/5/23
        
        load('labeled_w10.mat');
        image_labeled_feature = labeled_feature_w10'; %D*N
        text_labeled_feature  = labeled_tags__w10'; 

%  ��Ӧsplits �� epoch
        splits_index = 1;
        epoch_index = 1;
        
        prepar.trindx = 1:1500;
        prepar.teindx = 1501:1995;
        prepar.splits_index = splits_index;
        prepar.epoch_index  = epoch_index;
        
end


%% ���ݸ�ʽ��Ҫ�������ݸ�ʽ
switch DataType
    
    case 'Postive'
%%  ����ά�ȸ�˹��һ���ټ���ÿ��ά�ȵ���Сֵ����֤��postive��
%  check by chaos 2017/5/23
%  ����ǰ������ʽ  ͼ�� D*N
%  �����������ʽ  ͼ�� D*N        
        image_labeled_norm = normalization_2(image_labeled_feature',3); % mode =3Ϊ��˹��һ  N*D
        image_labeled_norm = image_labeled_norm';                      % D*N
        image_labeled_norm_min = min(image_labeled_norm,[],2);
        image_labeled_process = image_labeled_norm - repmat(image_labeled_norm_min,1,size(image_labeled_norm,2));
        X_img_all   = sparse(double(image_labeled_process));
        
%  ����ǰ������ʽ  �ı� D*N
%  �����������ʽ  �ı� D*N  
        X_tags_all = sparse(double(text_labeled_feature));        % �ܹ�25000��               

        
    case 'Count'
%  ����ά�ȹ�һ����ɢ����0-25
%  check by chaos 2017/5/23
%  ����ǰ������ʽ  ͼ�� D*N
%  �����������ʽ  ͼ�� D*N                     
        image_labeled_min = min(image_labeled_feature,[],2);
        image_labeled_max = max(image_labeled_feature,[],2);
        image_labeled_norm = (image_labeled_feature - repmat(image_labeled_min,1,size(image_labeled_feature,2)))...
                        ./repmat(image_labeled_max-image_labeled_min,1,size(image_labeled_feature,2));
        image_labeled_process = round(image_labeled_norm*25);
        X_img_all   = sparse(double(image_labeled_process));
        
%  ����ǰ������ʽ  �ı� D*N
%  �����������ʽ  �ı� D*N  
        X_tags_all = sparse(double(text_labeled_feature*150));        % �ܹ�25000��               
  
        
    otherwise
        error('Wrong "ToBeAnalized"')
end

clearvars -EXCEPT X_img_all X_tags_all prepar DataName DataType dataname ToBeAnalized SystemInRuningLinux SuPara Settings;