quicksort(int a[], int l, int r)
{
	int i;
	if (r>1) {
		i = partition(1, r);
		quicksort(a, 1, i-1);
		quicksort(a, i+1, r);
	}
}
