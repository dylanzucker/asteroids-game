from homework02 import *

def main():
    heap1 = MinHeap(10)
    heap2 = MinHeap(10)
    print("There are two empty heaps heap1 and heap2.")
    while(True):
        s = input("Enter: \'i\' for insert, \'d\' for deleteMin, \'r\' to remove a specific value, \'p\' for print, or any other character for sort data from max to min.\n")
        if(s == 'i'):
            i = eval(input("What integer would you like to insert into a heap?\n"))
            s = input("Enter: \'1\' to insert into heap1 or anything else to insert into heap2.\n")
            if(s == '1'):
                heap1.insertKey(i)
                print("inserted",i,"into heap1")
            else:
                heap2.insertKey(i)
                print("inserted", i, "heap2")
        elif(s == 'd'):
            s = input("Enter: \'1\' to delete from heap1 or anything else to delete from heap2.\n")
            if s == '1':
                x = heap1.deleteMin() # Check if possible
                print(type(x))
                if(x != "ERROR"):
                    print("Deleted",x, "from heap1")
                else:
                    print("there was an error in deleting from heap")
            else:

                x = heap2.deleteMin() # Check if possible
                if (x != "ERROR"):
                    print("Deleted", x, "from heap2")
                else:
                    print("there was an error in deleting from heap")

        elif(s== 'r'):
            i = eval(input("What integer would you like to remove the first instance of from a heap?\n"))
            s = input("Enter: \'1\' to delete from heap1 or anything else to delete from heap2.\n")
            if s == '1':
                heap1.deleteValue(i) # Check if possible
                print("Deleted",i, "from heap1 if heap 1 contained it")
            else:
                heap2.deleteValue(i) # Check if possible
                print("Deleted", i, "from heap2 if heap2 contained it")

        elif( s == 'p' ):
            print("Heap1: ", end = " ")
            heap1.printHeap()
            print("Heap2: ", end= " ")
            heap2.printHeap()
        else:
            s = input("Enter: \'1\' to sort heap1 or anything else to sort heap2.\n")
            if s == '1':
                print("Sorting Heap1")
                heap1 = heap1.heapSort()
                buildMinHeap(heap1.heap)
            else:
                print("Sorting Heap2")
                heap2 = heap2.heapSort()
                buildMinHeap(heap2.heap)

        x = input("Would you like to exit the program? (Y or N) \n")
        if(x.upper() == "Y"):
            break
        elif (x.upper() == "N"):
            continue
        else:
            print("You didn't enter \'Y\' or \'N\'...")
            continue


main()