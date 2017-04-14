import json
import gensim
from operator import add

model = gensim.models.KeyedVectors.load_word2vec_format('./GoogleNews-vectors-negative300.bin', binary=True)

print "model loaded"
target_answer_type = "other"
question_ids = []
with open("mscoco_val2017_annotations.json") as question_file:
	for line in question_file:
		line = json.loads(line)
		annotations = line['annotations']
		for it in annotations:
			answer_type = it["answer_type"]
			if answer_type == target_answer_type:
				question_ids.append(it["question_id"])


with open("OpenEnded_mscoco_val2017_questions.json") as question_file:
	for line in question_file:
		line = json.loads(line)
		for it in line['questions']:
			#print(str(it['question']))
			if it["question_id"] not in question_ids:
				continue

			question = str(it['question']).split(" ")
			feature = []
			length = 0
			for word in question:
				if len(word) == 0:
					continue
				if word[-1] == '?':
					word = word[0:len(word)-2]
				if len(feature) == 0:
					try:
						feature = model[word]
						length += 1
					except:
						feature = feature
				else:
					try:
						feature = map(add, feature, model[word])
						length += 1
					except:
						feature = feature

			for i in range(len(feature)):
				feature[i] = feature[i] / float(length)

			with open('question_feature_val_other.txt', 'a') as result_file:
				result_file.write(str(it['image_id']))
				result_file.write(" ")
				result_file.write(str(it['question_id']))
				result_file.write('\n')
				for value in feature:
					result_file.write(str(value))
					result_file.write(" ")
				result_file.write('\n')


