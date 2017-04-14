import json
#import gensim
from operator import add
from keras.applications.vgg16 import VGG16
from keras.preprocessing import image
from keras.applications.vgg16 import preprocess_input
import numpy as np
#from scipy import sparse
from scipy.sparse import coo_matrix
#from keras.applications.resnet50 import preprocess_input, decode_predictions

model = VGG16(weights='imagenet', include_top=False)


with open("a.json") as image_file:
	for line in image_file:
		line = json.loads(line)
		for it in line['images']:
			#print(str(it['question']))
			image_id = str(it['id'])
			image_name = str(it['file_name'])
			if image_id == "393225":
				print image_name
				break
			'''
			img_path = image_name
			img = image.load_img(img_path, target_size=(224, 224))
			x = image.img_to_array(img)
			x = np.expand_dims(x, axis=0)
			x = preprocess_input(x)
			features = model.predict(x)

			features  = features.tolist()
			features_vector = []
			for it in features:
				#print(len(it))
				for it2 in it:
					#print(len(it2))
					for it3 in it2:
						#print(len(it3))
						for it4 in it3:
							features_vector.append(it4)

			with open("../image_feature.txt", "a") as image_feature_file:
				image_feature_file.write(image_id)
				image_feature_file.write("\n")
				for it in features_vector:
					image_feature_file.write(str(it))
					image_feature_file.write(" ")
				image_feature_file.write("\n")

						


			
			with open('image_feature.txt', 'a') as result_file:
				result_file.write(str(it['id']))
				result_file.write(" ")
				result_file.write(str(it['file_name']))
				result_file.write('\n')
				print len(features)
				for value in features:
					print len(value)
					for it in value:
						print len(it)
						for it2 in it:
						#	print(it2)
							result_file.write(str(it2))
							result_file.write(" ")
					#coo_matrix(value,shape=None,dtype=None,copy=False)
				result_file.write('\n')
			'''

