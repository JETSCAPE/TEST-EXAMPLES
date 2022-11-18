import os
import sys

n = len(sys.argv)
if n != 3:
    print('invalid number of cmd args')
    sys.exit(-1)

# threshold for an acceptable floating point variation
err = .0001

# read cmd args for files to compare
oldFile = sys.argv[1]
newFile = sys.argv[2]

# tokenize file content
fOld = open(oldFile)
oldTokens = fOld.read().split()
fOld.close()

fNew = open(newFile)
newTokens = fNew.read().split()
fNew.close()

# each file should have the same number of tokens
if len(oldTokens) != len(newTokens):
    print('token length mismatch error')
    sys.exit(1)

for i in range(len(newTokens)):
    # if token is an exact match, no further analysis needed
    if newTokens[i] == oldTokens[i]:
        continue

    # remove scientific notation characters from string token
    temp1 = newTokens[i].replace('.', '', 1).replace('-', '', 1).replace('+', '', 1).replace('e', '', 1)
    temp2 = oldTokens[i].replace('.', '', 1).replace('-', '', 1).replace('+', '', 1).replace('e', '', 1)
    
    # if the string tokens can be converted to numbers
    if temp1.isdigit() and temp2.isdigit():
        # if the difference between the numbers is greater than the err threshold
        if abs(float(newTokens[i]) - float(oldTokens[i])) > err:
            print('err exceeds threshold ' + oldTokens[i] + ' ' + newTokens[i])
            sys.exit(2)
    else:
        # at least one token is not a valid number
        print('type mismatch error:' + oldTokens[i] + ' ' + newTokens[i])
        sys.exit(3)

# all tokens either an exact match or within the err threshold
print('pass')
sys.exit(0)
