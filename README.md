# Audio-command-recognition
Audio command recognition by DTW and classification methods

This is a scientific computing project at Paul Sabatier University.
### Author:
- Thang Nguyen
- Clement Poull
### Abstract
Speech recognition can be used in many fields, including command recognition for voice drone control. The state of the arts methods for spoken word recognition often base on MFCCs (Mel Frequency Cepstral Coefficients) to extract feature of audio. In this report, we present some approaches to classify the 13 drone commands in French. Firstly, We use dynamic time warping (DTW) algorithm. Second approach, using Principal Component Analysis (PCA) to get feature data reduction of MFCC and then apply k-nearest neighbors (KNN) to classify them. A upgrade of this approach, we combine MFCC and Delta Coefficients to get more features about sound and frame signals change. And finally, we use Convolution neural networks (CNN) into MFCCs directly. The dataset is composed of  235 records without noise and 53 records with noise from 13 native speakers. We use 80\% of our dataset to train model, 20\% dataset to test and measure the accuracy of approaches. During training, we augment data to variety of situations dataset like pitch, shift, stretch, ignore noise,\dots The best results base on F1 score, when we use DTW is 83%, PCA + KNN is 91% and CNN is 89%. We also evaluate independently on own dataset (~ 40 files) from native accent and Vietnamnese accent with DTW is 79%, PCA + KNN is 95% and CNN is 79%.
