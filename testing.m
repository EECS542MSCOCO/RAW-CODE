load theta.mat
load zipped_map.mat
load single_no_duplicate.mat
load vali_answer_modified.mat
load image_id_in_valianswer.mat
load validation_image_feature.mat
load question_id_in_valianswer.mat
load single_no_duplicate_mapping.mat
load validation_question_feature.mat
load validation_image_id_in_image.mat
load validation_image_id_in_question.mat
load validation_question_id_in_question.mat

theta = reshape(theta,[300,812]);
score = 0;
vali_ans_num = 1;
predic_answer = cell(3,1) ;
for i = 1:214354
    im_id =find(im_im_id == a_im_id(i));
    q_id = find(q_q_id == a_q_id(i));
    temp_im_feature = reshape(im_feature(:,im_id),[49,512]);
    temp_im_feature = max(temp_im_feature,[],1);
    temp_im_feature = temp_im_feature';
    feature = [temp_im_feature;q_feature(:,q_id)];
    pred_label = theta*full(feature);
    [sort_label,I] = sort(pred_label,1,'descend');
    vali_label = sort_label(1:vali_ans_num);
    vali_index = I(1:vali_ans_num);
    temp_score = zeros(vali_ans_num,1);
    for j = 1:vali_ans_num
        predic_answer{j} = single_answer(find(a_map_single==(zipped_map(vali_index(j)))));
        predic_answer{j}(ismember(predic_answer{j},' ,.:;!')) = [];
        predic_answer{j} = lower(predic_answer{j});
        for k = 1:10
            true_answer = vali_answer_modified{k,i};
            temp_score(j) = temp_score(j)+strcmp(true_answer,predic_answer{j});
        end
    end
    score = score + min(max(temp_score),3)/3;
    index_an = find(temp_score == max(temp_score));
    predic_answer{index_an}
end
accuracy = score/214354;