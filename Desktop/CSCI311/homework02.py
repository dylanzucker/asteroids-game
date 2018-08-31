'''
Dylan Zucker
CSCI 311 - Algorithms
Homework 02 - Implementing Min-Heap Data Structure
Due: September 22, 2017
'''

# 1.
class MinHeap:

    def __init__(self, space, tree=None, size=0):
        self.space = space   #Size of all storage space
        if(size == 0 and tree!= None): # in case they forgot the end
            self.heap_size = len(tree)  #Current location in the heap
        else:
            self.heap_size = size  #Current location in the heap
        self.heap = tree
        if self.heap == None:
            self.heap = [None] * self.space

    def insertKey(self, k):
        '''
        :param k: The value you want to insert into the heap
        :return: None
        '''
        self.heap_size += 1
        if(self.heap_size >= self.space):
            self.addSpace()
        print(self.heap)
        print(self.heap_size)
        print(self.space)
        self.heap[self.heap_size] = k
        fixUp(self.heap, self.heap_size)
        return None

    def deleteMin(self):
        '''
        delete the minumum value from the heap
        :return: The deleted minumum
        '''
        if self.heap_size < 1:
            return "ERROR"
        min = self.heap[1]
        self.heap[1] = self.heap[self.heap_size]
        self.heap[self.heap_size] = None
        self.heap_size -= 1
        self.minHeapify( 1)
        return min
    def deleteValue(self, value):
        '''
        :param value: The value you want to delete from the heap
        :return: 
        '''
        if value in self.heap:
            i = self.heap.index(value)
            self.heap[i] = self.heap[self.heap_size]
            self.heap[self.heap_size] = None
            self.heap_size -= 1
            self.minHeapify( i)
        else:
            print("Value not in the heap")

    def printHeap(self):
        '''
        Prints the contents of the heap
        :return: 
        '''
        for i in range(1,self.heap_size+1):
            print(self.heap[i], end=" ")
        print('\n')
        return

    def addSpace(self):
        '''
        Adds space to the heap to insert more values 
        '''
        t = self.space
        self.space = self.heap_size * 2
        while(t < self.space):
            self.heap.append(None)
            t += 1
        return None

    def heapSort(self):
        '''
        sorts from maximum to minumum a heap into a list 
        :return: A sorted list
        '''
        A = self.heap[0:self.heap_size+1]
        heap = self.buildMinHeap(A)
        originalSize = heap.heap_size
        for i in range(heap.heap_size, 1, -1):
            exchange(heap.heap, 1, i)
            heap.heap_size -= 1
            heap.minHeapify(1) # May need to max heapify
        heap.heap_size = originalSize
        heap.printHeap()
        self= heap
        self.space = len(self.heap)
        return heap

    def minHeapify(self, i):
        '''
        :param i: the index you want to perform min heapify on
        :return: None
        '''
        heap_size = self.heap_size
        l = left(i)
        r = right(i)
        smallest = i
        if l <= heap_size and self.heap[l] < self.heap[i]:
            smallest = l
        if r <= heap_size and self.heap[r] < self.heap[smallest]:
            smallest = r
        if smallest != i:
            exchange(self.heap, i, smallest)
            self.minHeapify( smallest)
        return None

    def maxHeapify(self, i):
        heap_size = self.heap_size
        l = left(i)
        r = right(i)
        largest = i
        if l <= heap_size and self.heap[l] > self.heap[i]:
            largest = l
        if r <= heap_size and self.heap[r] > self.heap[largest]:
            largest = r
        if largest != i:
            exchange(self.heap, i, largest)
            self.minHeapify(largest)


    def buildMinHeap(self, A):
        if(A[0] == None):
            heap_size = len(A) - 1
        else:
            heap_size = len(A)
            A = [None] + A
        heap = MinHeap(heap_size * 2, A, heap_size)
        for i in range(heap_size//2,0,-1):
            heap.minHeapify(i)

        return heap


def fixUp(a, i):
    while i > 1 and a[parent(i)] > a[i]:
        exchange(a, i, parent(i))
        i = parent(i)

def exchange(A, i, j):
    '''
    :param A: The heap as a python list
    :param i: The index of one element in the array
    :param j: The index of another element in the array
    :return: None
    '''
    if(i <  len(A) and j < len(A) and i > 0 and j > 0):
        t = A[i]
        A[i] = A[j]
        A[j] = t
    return None
def parent(i):
    '''
    :param i: index in a heap
    :return:  the index of the parent
    '''
    return i//2

def right(i):
    '''
    :param i: index in a heap
    :return: index of the right child
    '''
    return (i * 2) + 1

def left(i):
    '''
    :param i: index in a heap
    :return: index of the left child
    '''
    return i * 2


