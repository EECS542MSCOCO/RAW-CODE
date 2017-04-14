%% 变量命名规则：
% q代表question a代表answer im代表image
% 形如X_Y_Z变量，如q_im_id表示该id序列是question的json文件中提取出的关于im的id

%% Read Question Feature --- Finished
% load question_feature.mat
% load question_id_in_question.mat
% load image_id_in_question.mat
% filename = 'question_feature.txt';
% fileID = fopen(filename);
% q_q_id = [];
% q_im_id = [];
% q_feature = zeros(300,443757);
% tline = fgetl(fileID);
% n = 1;
% col = 1;
% while ischar(tline)
%     if mod(n,2)==1
%         temp_id = sscanf(tline,'%d');
%         q_q_id = [q_q_id;temp_id(2)];
%         q_im_id = [q_im_id;temp_id(1)];
%         
%     else
%         temp_feature = sscanf(tline,'%f');
%         q_feature(:,col) = temp_feature;
%         col = col+1
%     end
%     tline = fgetl(fileID);
%     n = n+1;
% end
% fclose(fileID);
% save('question_feature.mat','q_feature')
% save('question_id_in_question.mat','q_q_id')
% save('image_id_in_question.mat','q_im_id')
%% Read Image Feature --- Not runned with complete data
% filename = 'image_feature.txt';
% fileID = fopen(filename);
% n = 1;
% im_im_id = [];
% im_feature = zeros(7*7*512,82783);
% tline = fgetl(fileID);
% col = 1;
% while ischar(tline)
%     if mod(n,2)==1
%         temp_id = sscanf(tline,'%d');
%         im_im_id = [im_im_id;temp_id];
%     else
%         temp_feature = sparse(sscanf(tline,'%f'));
% %         s = temp_feature(temp_feature~=0);
% %         i = find(temp_feature~=0);
% %         j = col*ones(length(s),1);
% %         temp_sparse = sparse(i,j,s,7*7*512,82783);
% %         im_feature = im_feature + temp_sparse;
%         im_feature(:,col) = temp_feature;
%         col = col+1
%     end
%     tline = fgetl(fileID);
%     n = n+1;
% end
% im_feature = sparse(im_feature);
% fclose(fileID);
% save('image_feature.mat','im_feature')
% save('image_id_in_image.mat','im_im_id')
%% Read Map --- Finished
load single_no_duplicate.mat
load single_no_duplicate_mapping.mat
% filename = 'single_map.txt';
% fileID = fopen(filename);
% single_answer = cell(1);
% a_map_single = [];
% n = 1;
% temp_index = 1;
% tline = fgetl(fileID);
% while ischar(tline)
%     if mod(n,2)==1
%         temp_a = tline;
%         single_answer{temp_index} = temp_a;
%         temp_index = temp_index+1;
%     else
%         temp_map = sscanf(tline,'%d');
%         a_map_single = [a_map_single,temp_map];
%     end
%     tline = fgetl(fileID);
%     n = n+1
% end
% fclose(fileID);
% save('single_no_duplicate.mat','single_answer')
% save('single_no_duplicate_mapping.mat','a_map_single')
%% Read Answer---Finished
% load image_id_in_answer.mat
% load label.mat
% load question_id_in_answer.mat
filename = 'single_answer.txt';
fileID = fopen(filename);
a_im_id = [];
a_q_id = [];
a_index = [];
n = 1;
label_num =0;
tline = fgetl(fileID);
while ischar(tline)
    if mod(n,4) == 1
        a_im_id = [a_im_id;str2double(tline)];
    end
    if mod(n,4) == 2
        a_q_id = [a_q_id;str2double(tline)];
    end
    if mod(n,4) == 3
        a_index = [a_index;a_map_single(strcmp(single_answer,tline)==1)];
    end
    tline = fgetl(fileID);
    n = n+1
end
fclose(fileID);
%% Training Data Constructe --- Not runned with complete data
% trian_feature = zeros(7*7*512+300,443757);
% for i = 1:443757
%     train_q_id = a_q_id(i);
%     train_i_id = a_im_id(i);
%     if ~(isempty(find(q_q_id==train_q_id, 1))) && ~(isempty(find(im_im_id==train_i_id, 1)))
%         q_index = find(q_q_id==train_q_id);
%         i_index = find(im_im_id==train_i_id);
%         temp_feature = sparse([im_feature(:,i_index);q_feature(:,q_index)]);
%         trian_feature(:,i) = temp_feature;
%         i
%     end
% end

%% Train Softmax
% net = trainSoftmaxLayer(trian_feature,label);


