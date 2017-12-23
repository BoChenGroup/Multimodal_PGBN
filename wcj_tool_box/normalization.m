function [ traindata,testdata ] = normalization( traindata,testdata,mode )
%UNTITLED3 Summary of this function goes here
%   traindata��testdata:N*D����NΪ����������DΪ��������������ά��
switch mode
    case 0   %%����һ��
        
    case 1   %%����ǿ�ȹ�һ
        temp=traindata';
        temp1=testdata';
        traindata=traindata./repmat((max(temp))',1,size(traindata,2));
        testdata=testdata./repmat((max(temp1))',1,size(traindata,2));
    case 2      %%����������һ
        traindata=traindata./repmat((sqrt(sum(traindata'.^2)))',1,size(traindata,2));
        testdata=testdata./repmat((sqrt(sum(testdata'.^2)))',1,size(traindata,2));
    case 3      %%����ά�ȱ�׼����˹��һ
        [traindata,mu,sigma]=zscore(traindata);
        testdata=bsxfun(@minus,testdata,mu);
        testdata=bsxfun(@rdivide,testdata,sigma);
    case 4      %%������һ֮���ټ���ֵ
        traindata=traindata./repmat((sqrt(sum(traindata'.^2)))',1,size(traindata,2));
        testdata=testdata./repmat((sqrt(sum(testdata'.^2)))',1,size(traindata,2));
        mu=mean(traindata);
        traindata=bsxfun(@minus,traindata,mu);
%         mu=mean(testdata);
        testdata=bsxfun(@minus,testdata,mu);
end

