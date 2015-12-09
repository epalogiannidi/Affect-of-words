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
