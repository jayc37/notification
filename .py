def quicksort(arr,low,high):
    if len(arr) == 1:
        return arr
    if low < high:
        pi = partition(arr,low,high)
        quicksort(arr,pi,low-1)
        quicksort(arr,pi+1,high)

def partition(arr,low,high):
    i = low -1
    piv = arr[high]

    for j in range(low,high):
        if arr[j] <= piv:
            i+=1
            arr[i],arr[j] = arr[j],arr[i]

    arr[high],arr[i+1] = arr[i+1],arr[high]
    return (i+1)
def sort():
    ar = [1,2,6,0,2,1]
    l = len(ar)
    quicksort(ar,0,l-1)

    ar.reverse()
    for i in range(l):
        print(ar[i])

sort()