import json

with open("OpenEnded_mscoco_val2017_questions.json") as question_file:
	for line in question_file:
		line = json.loads(line)
		for it in line['questions']:
			#print(str(it['question']))
			if it["question_id"] == 393225001:
				print it["question"]
# Is this a creamy soup?