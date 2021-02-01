import json
from collections import Counter
from itertools import chain

class Drawing(object):
    """Draw of Powerball numbers and powerball"""
    def __init__(self):
        pass

    def getAllNumbers(self, listOfPersons):
        allNumbers = []
        for i in listOfPersons:
            allNumbers = chain(allNumbers, i['favourite_numbers'])
        return allNumbers

    def getAllPballs(self, listOfPersons):
        allPballs = []
        for i in listOfPersons:
            allPballs.append(i['Powerball'])
        return allPballs

    def drawFavNumbers(self, allNumbers):
        co = Counter(allNumbers).most_common(5)
        winningNums = ""
        for i in co:
            winningNums += str(i[0]) + " "
        print("The Winning numbers are: " + winningNums)

    def drawPowerball(self, allPballs):
        ca = Counter(allPballs)
        print("The Powerball is: " + str(ca.most_common(1)[0][0]))
        
class Person(object):
    """A Class defining Greenphire Employees their numbers and powerball for the powerball lottery, invoke like employee = Person('firstname','lastname', [int, int, int, int, int], int)"""
    def __init__(self):
        self.firstname = input("Enter employee first name: ")
        self.lastname = input("Enter employee last name: ")
        def getNumber(numberlist, lotteryList):
            excludes = "".join(str(numberlist))
            while True:
                try:
                    number = int(input("between 1 and 69, excluding {} ".format(excludes)))
                except ValueError:
                    print("I don't know this number")
                    continue
                try:
                    lotteryList.remove(number)
                    break
                except ValueError: 
                    print("numbers may only be chosen once and between 1 and 69 ")
            return number

        def getPowerball(pballs):
            while True:
                pball = int(input("put in your powerball number: "))
                try:
                    pballs.remove(pball)
                    break
                except ValueError:
                    print("Powerball must be between 1 and 26, try again")
            return pball

        numberlist = []
        lotteryList = list(range(1,70))
        pballList = list(range(1,27))
        print("Enter your 5 favourite numbers for your lottery ")
        print("Your first number ", end='')
        firstnumber = getNumber(numberlist, lotteryList)
        numberlist.append(firstnumber)
        print("Your second number ", end='')
        secondnumber = getNumber(numberlist, lotteryList)
        numberlist.append(secondnumber)
        print("Your third number ", end='')
        thirdnumber = getNumber(numberlist, lotteryList)
        numberlist.append(thirdnumber)
        print("Your fourth number ", end='')
        fourthnumber = getNumber(numberlist, lotteryList)
        numberlist.append(fourthnumber)
        print("Your fifth number", end='')
        fifthnumber = getNumber(numberlist, lotteryList)
        numberlist.append(fifthnumber)
        self.numbers = numberlist
        print("Your is powerball: ")
        self.powerball = getPowerball(pballList)

    def __str__(self):
        nums = str()
        for i in self.numbers:
            nums += str(i)
            nums += " "
        return str(self.firstname+ " " + self.lastname + " " + nums + "Powerball: " + str(self.powerball))

    def save(self):
        jsonnotated = { "firstname":self.firstname, "lastname":self.lastname, "favourite_numbers" : self.numbers, "Powerball" : self.powerball }
        return jsonnotated

def getAllPlayers():
    try:
        with open("allParticipants.json",mode='r',encoding='utf-8') as data_file:
            data=json.load(data_file)
    except IOError:
        print("File with all Participants does not exists")
    except json.JSONDecodeError:
        print("json File is corrupted")
        dummy = '[{"Powerball": 0, "favourite_numbers": [0, 0, 0, 0, 0], "firstname": "N.A.", "lastname": "N.A."}]'
        data = json.loads(dummy)
    return data

def printAllemployees(data):
    for i in data:
        a=str(str(i['firstname']) + " " + str(i['lastname']) + " " + str(i['favourite_numbers']) + " Powerball "+  str(i['Powerball']))
        print(a)

def addNewPlayer(person):
    newPlayer = person.save()
    try:
        with open("allParticipants.json",mode='r+',encoding='utf-8') as data_file:
            data=json.load(data_file)
            data.append(newPlayer)
            data_file.seek(0,0)
            json.dump(data, data_file, sort_keys=True)
    except IOError:
        print("File with all Participants did not exist and gets created")
        with open("allParticipants.json",mode='w',encoding='utf-8') as data_file:
            l=[newPlayer]
            json.dump(l, data_file)
    except json.JSONDecodeError:
        print("cannot write to FILE, existing Data is corrupted")

def main():
    print("\nChoose how to proceed, type in the number in front of the options:",end='')
    while True:
        print("\n 1: add a new Player \n 2: list all Players \n 3: draw the winning numbers and the powerball \n 0: to end the program")
        try:
            choice = int(input("What do you want to do? put in the corresponding number: "))
        except ValueError:
            choice = ''
        if choice == 1:
            newPlayer = Person()
            addNewPlayer(newPlayer)
        elif choice == 2:
            allPersons = getAllPlayers()
            printAllemployees(allPersons)
        elif choice == 3:
            newGame = Drawing()
            allPersons = getAllPlayers()
            choosenNums = newGame.getAllNumbers(allPersons)
            choosenPBalls = newGame.getAllPballs(allPersons)
            newGame.drawFavNumbers(choosenNums)
            newGame.drawPowerball(choosenPBalls)
        elif choice == 0:
            exit()
        else:
            print("\nThis is not a valid option! Try again")

if __name__ == '__main__':
    main()
