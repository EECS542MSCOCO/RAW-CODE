import json
import collections

index = 1
store = []
with open("map.txt", "r") as map_file:
	for line in map_file:
		if index % 2 == 1:
			index += 1
			continue
		else:
			index += 1
			line = line[0: len(line)-1]
			line_num = int(line)
			store.append(line_num)

store = sorted(store)

with open("test.txt", "w") as test_file:
	for it in store:
		test_file.write(str(it))
		test_file.write("\n")



