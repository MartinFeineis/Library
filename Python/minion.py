streng = "BANANA"
Vowels = ['A', 'E', 'I', 'O', 'U']
words = []
length = range(len(streng)+1)
for i in length:
    j =0
    while j < i:
        words.append(streng[j:i])
        j += 1

#words = [ x for x in l if x  != '' ]
#print(words)
words = l
print(l)

scores = {}
for i in words:
    if i in scores:
        scores[i] += 1
    else:
        scores[i] = 1

#print(scores)
Stuart = 0
Kevin = 0
for i in scores:
    if i[0] in Vowels:
        Stuart += scores[i]
    else:
        Kevin += scores[i]

if Stuart > Kevin:
    print("Stuart: " + str(Stuart))
elif Kevin > Stuart:
    print("Kevin: " + str(Kevin))
else:
    print("Draw")
