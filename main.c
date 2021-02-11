#include <stdio.h>
#include <stdlib.h>
#include <stdio.h>
void swap(int *xp, int *yp)
{
    int temp = *xp;
    *xp = *yp;
    *yp = temp;
}
void swapc(char *xp, char *yp)
{
    char temp = *xp;
    *xp = *yp;
    *yp = temp;
}
void bubbleSort(int arr[], int n)
{
   int i, j;
   int swapped;
   for (i = 0; i < n-1; i++)
   {
     swapped = 0;
     for (j = 0; j < n-i-1; j++)
     {
        if (arr[j] > arr[j+1])
        {
           swap(&arr[j], &arr[j+1]);
           swapped = 1;
        }
     }
     // IF no two elements were swapped by inner loop, then break
     if (swapped == 0)
        break;
   }
}
void bubbleSortchar(char arr[], int n)
{
   int i, j;
   int swapped;
   for (i = 0; i < n-1; i++)
   {
     swapped = 0;
     for (j = 0; j < n-i-1; j++)
     {
        if (arr[j] > arr[j+1])
        {
           swapc(&arr[j], &arr[j+1]);
           swapped = 1;
        }
     }
     // IF no two elements were swapped by inner loop, then break
     if (swapped == 0)
        break;
   }
}

/* Function to print an array */
void printArray(int arr[], int size)
{
    int i;
    for (i=0; i < size; i++)
        printf("%d ", arr[i]);
}
void printArraychar(char arr[], int size)
{
    int i;
    for (i=0; i < size; i++)
        printf("%c ", arr[i]);
}
void selectionSort(int arr[], int n)
{
    int i, j, min_idx;

    // One by one move boundary of unsorted subarray
    for (i = 0; i < n-1; i++)
    {
        // Find the minimum element in unsorted array
        min_idx = i;
        for (j = i+1; j < n; j++)
          if (arr[j] < arr[min_idx])
            min_idx = j;

        // Swap the found minimum element with the first element
        swap(&arr[min_idx], &arr[i]);
    }
}
void selectionSortchar(char arr[], char n)
{
    int i, j, min_idx;

    // One by one move boundary of unsorted subarray
    for (i = 0; i < n-1; i++)
    {
        // Find the minimum element in unsorted array
        min_idx = i;
        for (j = i+1; j < n; j++)
          if (arr[j] < arr[min_idx])
            min_idx = j;

        // Swap the found minimum element with the first element
        swapc(&arr[min_idx], &arr[i]);
    }
}
void merge(int arr[], int l, int m, int r)
{
    int i, j, k;
    int n1 = m - l + 1;
    int n2 = r - m;

    /* create temp arrays */
    int L[n1], R[n2];

    /* Copy data to temp arrays L[] and R[] */
    for (i = 0; i < n1; i++)
        L[i] = arr[l + i];
    for (j = 0; j < n2; j++)
        R[j] = arr[m + 1 + j];

    /* Merge the temp arrays back into arr[l..r]*/
    i = 0; // Initial index of first subarray
    j = 0; // Initial index of second subarray
    k = l; // Initial index of merged subarray
    while (i < n1 && j < n2) {
        if (L[i] <= R[j]) {
            arr[k] = L[i];
            i++;
        }
        else {
            arr[k] = R[j];
            j++;
        }
        k++;
    }

    /* Copy the remaining elements of L[], if there
    are any */
    while (i < n1) {
        arr[k] = L[i];
        i++;
        k++;
    }

    /* Copy the remaining elements of R[], if there
    are any */
    while (j < n2) {
        arr[k] = R[j];
        j++;
        k++;
    }
}
void mergec(char arr[], int l, int m, int r)
{
    int i, j, k;
    int n1 = m - l + 1;
    int n2 = r - m;

    /* create temp arrays */
    char L[n1], R[n2];

    /* Copy data to temp arrays L[] and R[] */
    for (i = 0; i < n1; i++)
        L[i] = arr[l + i];
    for (j = 0; j < n2; j++)
        R[j] = arr[m + 1 + j];

    /* Merge the temp arrays back into arr[l..r]*/
    i = 0; // Initial index of first subarray
    j = 0; // Initial index of second subarray
    k = l; // Initial index of merged subarray
    while (i < n1 && j < n2) {
        if (L[i] <= R[j]) {
            arr[k] = L[i];
            i++;
        }
        else {
            arr[k] = R[j];
            j++;
        }
        k++;
    }

    /* Copy the remaining elements of L[], if there
    are any */
    while (i < n1) {
        arr[k] = L[i];
        i++;
        k++;
    }

    /* Copy the remaining elements of R[], if there
    are any */
    while (j < n2) {
        arr[k] = R[j];
        j++;
        k++;
    }
}

/* l is for left index and r is right index of the
sub-array of arr to be sorted */
void mergeSort(int arr[], int l, int r)
{
    if (l < r) {
        // Same as (l+r)/2, but avoids overflow for
        // large l and h
        int m = l + (r - l) / 2;

        // Sort first and second halves
        mergeSort(arr, l, m);
        mergeSort(arr, m + 1, r);

        merge(arr, l, m, r);
    }
}
void mergeSortchar(char arr[], int l, int r)
{
    if (l < r) {
        // Same as (l+r)/2, but avoids overflow for
        // large l and h
        int m = l + (r - l) / 2;

        // Sort first and second halves
        mergeSortchar(arr, l, m);
        mergeSortchar(arr, m + 1, r);

        mergec(arr, l, m, r);
    }
}
/* UTILITY FUNCTIONS */
/* Function to print an array */
int binarySearch(int arr[], int l, int r, int x)
{

    if (r >= l) {
        int mid = l + (r - l) / 2;

        // If the element is present at the middle
        // itself
        if (arr[mid] == x)
            return mid;

        // If element is smaller than mid, then
        // it can only be present in left subarray
        if (arr[mid] > x)
            return binarySearch(arr, l, mid - 1, x);

        // Else the element can only be present
        // in right subarray
        return binarySearch(arr, mid + 1, r, x);
    }

    // We reach here when element is not
    // present in array
    return -1;
}
int binarySearchchar(char arr[], int l, int r, char x)
{

    if (r >= l) {
        int mid = l + (r - l) / 2;

        // If the element is present at the middle
        // itself
        if (arr[mid] == x)
            return mid;

        // If element is smaller than mid, then
        // it can only be present in left subarray
        if (arr[mid] > x)
            return binarySearchchar(arr, l, mid - 1, x);

        // Else the element can only be present
        // in right subarray
        return binarySearchchar(arr, mid + 1, r, x);
    }

    // We reach here when element is not
    // present in array
    return -1;
}
int main()
{
    int flag=2;
    while(flag==2)
    {
    printf("choose the type of data you want to sort \n");
    printf("1-characters\n");
    printf("2-numbers\n");
    int check;
    int length;
    scanf("%d",&check);
    printf("choose the type of sort\n");
    printf("1-bubble sort\n");
    printf("2-selection sort\n");
    printf("3-merge sort\n");
    int y;
    scanf("%d",&y);
    printf("enter the length of array\n");
    scanf("%d",&length);
    int  arrNumber[length];
    char arrChar[length];
    if(check==1)
    {
        int i;
        printf("enter the array you want to sort\n");
        for(i=0;i<length;i++)
        {
            scanf("\n%c",&arrChar[i]);
        }
        if(y==1)
        {
            bubbleSortchar(arrChar, length);
            printf("Sorted array: \n");
            printArraychar(arrChar,length);
            printf("\nyou need to search ?\n");
            printf("1-yes\n");
            printf("2-no\n");
            int x;
            scanf("%d",&x);
            if(x==1)
            {
                printf("enter the charcter you want to search it\n");
                char s;
                scanf("\n%c",&s);
                int result = binarySearchchar(arrChar, 0, length - 1, s);
                (result == -1) ? printf("Element is not present in array")
                               : printf("Element is present at index %d",
                                        result);
            }


        }
        else
        {
            if(y==2)
            {
                selectionSortchar(arrChar, length);
                printf("Sorted array: \n");
                printArraychar(arrChar,length);
                printf("\nyou need to search ?\n");
                printf("1-yes\n");
                printf("2-no\n");
                int x;
                scanf("%d",&x);
                if(x==1)
                {
                    printf("enter the charcter you want to search it\n");
                    char s;
                    scanf("\n%c",&s);
                    int result = binarySearchchar(arrChar, 0, length - 1, s);
                    (result == -1) ? printf("Element is not present in array")
                                   : printf("Element is present at index %d\n",
                                            result);
                }
            }
            else
            {
                if(y==3)
                {
                    mergeSortchar(arrChar, 0, length-1);
                    printf("\nSorted array is \n");
                    printArraychar(arrChar, length);
                    printf("\nyou need to search ?\n");
                    printf("1-yes\n");
                    printf("2-no\n");
                    int x;
                    scanf("%d",&x);
                    if(x==1)
                    {
                        printf("enter the charcter you want to search it\n");
                        char s;
                        scanf("\n%c",&s);
                        int result = binarySearchchar(arrChar, 0, length - 1, s);
                        (result == -1) ? printf("Element is not present in array")
                                       : printf("Element is present at index %d\n",
                                                result);
                    }
                }
            }
        }
    }
    else
    {
       if(check==2)
       {
            int i;
            printf("enter the array you want to sort\n");
            for(i=0;i<length;i++)
            {
                scanf("%d",&arrNumber[i]);
            }
            if(y==1)
            {
                bubbleSort(arrNumber, length);
                printf("Sorted array: \n");
                printArray(arrNumber,length);
                printf("\nyou need to search ?\n");
                printf("1-yes\n");
                printf("2-no\n");
                int x;
                scanf("%d",&x);
                if(x==1)
                {
                    printf("enter the number you want to search it\n");
                    int s;
                    scanf("%d",&s);
                    int result = binarySearch(arrNumber, 0, length - 1, s);
                    (result == -1) ? printf("Element is not present in array ")
                                   : printf("Element is present at index %d\n",
                                            result);
                }

            }
            else
            {
                if(y==2)
                {
                    selectionSort(arrNumber, length);
                    printf("Sorted array: \n");
                    printArray(arrNumber,length);
                    printf("\nyou need to search ?\n");
                    printf("1-yes\n");
                    printf("2-no\n");
                    int x;
                    scanf("%d",&x);
                    if(x==1)
                    {
                        printf("enter the number you want to search it\n");
                        int s;
                        scanf("%d",&s);
                        int result = binarySearch(arrNumber, 0, length - 1, s);
                        (result == -1) ? printf("Element is not present in array")
                                       : printf("Element is present at index %d",
                                                result);
                    }
                }
                else
                {
                    if(y==3)
                    {
                        mergeSort(arrNumber, 0, length-1);
                        printf("\nSorted array is \n");
                        printArray(arrNumber, length);
                        printf("\nyou need to search ?\n");
                        printf("1-yes\n");
                        printf("2-no\n");
                        int x;
                        scanf("%d",&x);
                        if(x==1)
                        {
                            printf("enter the number you want to search it\n");
                            int s;
                            scanf("%d",&s);
                            int result = binarySearch(arrNumber, 0, length - 1, s);
                            (result == -1) ? printf("Element is not present in array ")
                                           : printf("Element is present at index %d\n",
                                                    result);
                        }
                    }
                }
            }
        }
    }
    printf("\nwhat you want!!?\n");
    printf("1-close\n");
    printf("2-continue\n");
    scanf("%d",&flag);
    }
    return 0;
}
