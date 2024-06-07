from mpmath import mp

letters = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z')
mp.dps = 10000
f = mp.pi
word = str()
digits = [ int(digit) for digit in str(f).replace(".","")]
#j=-1 remove j if statement
for j,i in enumerate(digits):
    if j != len(digits)-1:
        #print("current pair ",digits[j],digits[j+1])
        if int(str(i)+str(digits[j+1]))<=25:
            #print(letters[int(str(i)+str(digits[j+1]))])
            word=word+letters[int(str(i)+str(digits[j+1]))]
        else:
            #print("else: ", letters[i])
            word=word+letters[i]
print(word)
