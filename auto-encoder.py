from keras.layers import Input, Dense
from keras.models import Model
from keras.datasets import mnist
import numpy as np

def changeToFloat(line):
	for i in range(0, len(line)):
		line[i] = float(line[i])
	return line


encoding_dim = 32

# this is our input placeholder
input_img = Input(shape=(300,))
# "encoded" is the encoded representation of the input
encoded = Dense(encoding_dim, activation='relu')(input_img)
# "decoded" is the lossy reconstruction of the input
decoded = Dense(300, activation='sigmoid')(encoded)

# this model maps an input to its reconstruction
autoencoder = Model(input_img, decoded)

encoder = Model(input_img, encoded)

encoded_input = Input(shape=(encoding_dim,))
decoder_layer = autoencoder.layers[-1]
decoder = Model(encoded_input, decoder_layer(encoded_input))

autoencoder.compile(optimizer='adadelta', loss='binary_crossentropy')

x_train = []

with open("question_feature.txt", "r") as feature_file:
	for line in feature_file:
		line = line.split(" ")
		line = line[0:len(line) - 1]
		if len(line) < 5:
			continue
		else:
			line = changeToFloat(line)
			x_train.append(line)

x_train = np.asarray(x_train)

autoencoder.fit(x_train, x_train,
                epochs=50,
                batch_size=256,
                shuffle=True,
                validation_data=(x_train, x_train))




