#!/usr/bin/env/ python

import re


Vowels = ['A','E','I','O','U']

Word = str('Banana').upper()

vword=[]
kword=[]

for i in Word:
    if i in Vowels:
        vword.append(i)
    else:
        kword.append(i)

print("Vowels in Word: " + str(vword))
print("Konstonats in Word: " + str(kword))

subWord = Word
for i in vword:
    m = re.search(i, Word)
    #print(m.start())
    subWord = subWord[m.start():-1]
    print(subWord)

subWord = Word
for i in kword:
    m = re.search(i, Word)
    #print(type(m.start()))
    subWord = subWord[m.start():-1]
    print(subWord)


class Player():
    def __init__(self, name, vowel):
        self.name = name
        self.vowel = vowel
        self.score = 0

    def set_score(self, score):
        self.score = score

    def get_score(self):
        return self.score

