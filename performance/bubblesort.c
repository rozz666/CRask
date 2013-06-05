#include <stdio.h>
#include <stdlib.h>

int main()
{
    FILE *f = fopen("numbers.txt", "rt");
    int count;
    fscanf(f, "%i", &count);
    int *numbers = malloc(count * sizeof(numbers[0]));
    for (int i = 0; i < count; ++i)
        fscanf(f, "%i", numbers + i);
    fclose(f);
    
    for (int i = 0; i < count; ++i)
        for (int j = 1; j < (count - i); ++j)
            if (numbers[j - 1] > numbers[j])
            {
                int tmp = numbers[j - 1];
                numbers[j - 1] = numbers[j];
                numbers[j] = tmp;
            }
            
    f = fopen("sorted.txt", "wt");
    for (int i = 0; i < count; ++i)
        fprintf(f, "%i ", numbers[i]);
    fclose(f);
    return 0;
}