# Affect-of-words
The module in this repositoty is used fot the estimation of affect in word level
Based on the code that first created by Nikos Malandrakis  
Author: Elisavet Palogiannidi,School of ECE, Technical Univeristy of Crete   

It requires an affective lexicon and a semantic similarity model 
It selects the seeds from the affective lexicon and estimates the 
appropriate weight that represents each seed's importance through
supervised learning.

Example of how to run:
affect_of_words('anew_el','val',600,'pmi',0,'pmi');

estimates the valence scores of a test dataset with name pmi, using 600 seeds from the anew_el lexicon (Greek) and least square estimation for the weights estimation (lambda =0).

To add a new language (affective lexicon) add under data a directory with the name of the lexicon e.g anew_en for English.
Place inside the directory the words of the affective lexicon, the affective scores (val.txt, aro.txt, dom.txt) the semantic similarity matrix for the affective lexicon (pmi.mat). In order to find the affect of new words then place inside the new directory a .mat file of size NxM that its raws are the unknown words and the columns are the words of the corresponding affective lexicon (The name of this file is the last argument e.g., if you insert a matrix with name english_voc for estimating the affective scores of unknown words using pmi similarity metric the foutrh argument should be 'pmi' and the last 'english_voc').


Contact person: Elisavet Palogiannidi epalogiannidi@gmail.com

Related papers - citations:

First proposed on:

@article{malandrakis2013distributional,
  title={Distributional semantic models for affective text analysis},
  author={Malandrakis, Nikolaos and Potamianos, Alexandros and Iosif, Elias and Narayanan, Shrikanth},
  journal={Audio, Speech, and Language Processing, IEEE Transactions on},
  volume={21},
  number={11},
  pages={2379--2392},
  year={2013},
  publisher={IEEE}
}

Evaluated on multiple languages and enhanced with Ridge regression on:

@inproceedings{palogiannidi2015valence,
  title={Valence, Arousal and Dominance Estimation for English, German, Greek, Portuguese and Spanish Lexica Using Semantic  
  Models},
  author={Palogiannidi, Elisavet and Iosif, Elias and Koutsakis, Polychronis and Potamianos, Alexandros},
  booktitle={In Proceedings of Interspeech},
  year={2015}
}

