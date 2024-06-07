from mpmath import mp

letters = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z')
mp.dps = 10000
f = mp.pi
lwords =[]
digits = [ int(digit) for digit in str(f).replace(".","")]
#j=-1 remove j if statement
for j,i in enumerate(digits):
    if j != len(digits)-1:
        #print("current pair ",digits[j],digits[j+1])
        if int(str(i)+str(digits[j+1]))<=25:
            #print(letters[int(str(i)+str(digits[j+1]))])
            lwords.append(letters[int(str(i)+str(digits[j+1]))]) #More optimized?
        else:
            #print("else: ", letters[i])
            lwords.append(letters[i])
print(lwords)
