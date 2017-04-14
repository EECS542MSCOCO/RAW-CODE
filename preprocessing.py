import json
import sys

word_answer = {}
index = 1

with open("mscoco_train2017_annotations.json", "r") as json_file:
	for line in json_file:
		line = json.loads(line)
		for it in line['annotations']:
			print(it["question_type"])
			'''
			answers = it["answers"]
			for answer in answers:
				real_answer = answer['answer']
				if real_answer in word_answer.keys():
					continue
				else:
					word_answer[real_answer] = index
					index += 1

with open("word_dictionary.json", "w") as writing_file:
	json.dump(word_answer, writing_file)

'''


