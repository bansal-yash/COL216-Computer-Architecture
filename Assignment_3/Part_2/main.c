#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct
{
    float first;
    float second;
} Pair;

typedef struct
{
    float first;
    float second;
    float third;
    // float fourth;
    // float fifth;
    // float sixth;
} Pair6;

Pair6 multiply(int n)
{
    int **A, **B, **C;
    A = (int **)malloc(n * sizeof(int *));
    B = (int **)malloc(n * sizeof(int *));
    C = (int **)malloc(n * sizeof(int *));

    for (int i = 0; i < n; i++)
    {
        A[i] = (int *)malloc(n * sizeof(int));
        B[i] = (int *)malloc(n * sizeof(int));
        C[i] = (int *)malloc(n * sizeof(int));
    }

    clock_t start = clock();

    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            for (int k = 0; k < n; k++)
            {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }

    clock_t stop = clock();
    float duration1 = (double)((stop - start) * 1000000) / CLOCKS_PER_SEC;

    // start = clock();

    // for (int j = 0; j < n; j++)
    // {
    //     for (int i = 0; i < n; i++)
    //     {
    //         for (int k = 0; k < n; k++)
    //         {
    //             C[i][j] += A[i][k] * B[k][j];
    //         }
    //     }
    // }

    // stop = clock();
    // float duration2 = (double)((stop - start) * 1000000) / CLOCKS_PER_SEC;

    start = clock();

    for (int k = 0; k < n; k++)
    {
        for (int i = 0; i < n; i++)
        {
            for (int j = 0; j < n; j++)
            {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }

    stop = clock();
    float duration3 = (double)((stop - start) * 1000000) / CLOCKS_PER_SEC;

    start = clock();

    for (int k = 0; k < n; k++)
    {
        for (int j = 0; j < n; j++)
        {
            for (int i = 0; i < n; i++)
            {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }

    stop = clock();
    float duration4 = (double)((stop - start) * 1000000) / CLOCKS_PER_SEC;

    // start = clock();

    // for (int i = 0; i < n; i++)
    // {
    //     for (int k = 0; k < n; k++)
    //     {
    //         for (int j = 0; j < n; j++)
    //         {
    //             C[i][j] += A[i][k] * B[k][j];
    //         }
    //     }
    // }

    // stop = clock();
    // float duration5 = (double)((stop - start) * 1000000) / CLOCKS_PER_SEC;

    // start = clock();

    // for (int j = 0; j < n; j++)
    // {
    //     for (int k = 0; k < n; k++)
    //     {
    //         for (int i = 0; i < n; i++)
    //         {
    //             C[i][j] += A[i][k] * B[k][j];
    //         }
    //     }
    // }

    // stop = clock();
    // float duration6 = (double)((stop - start) * 1000000) / CLOCKS_PER_SEC;

    for (int i = 0; i < n; i++)
    {
        free(A[i]);
        free(B[i]);
        free(C[i]);
    }

    free(A);
    free(B);
    free(C);

    Pair6 result = {duration1, duration3, duration4};
    return result;
}

Pair in_place_transpose(int n)
{
    int **A;
    A = (int **)malloc(n * sizeof(int *));

    for (int i = 0; i < n; i++)
    {
        A[i] = (int *)malloc(n * sizeof(int));
    }
    int temp;

    clock_t start = clock();
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < i; j++)
        {
            temp = A[i][j];
            A[i][j] = A[j][i];
            A[j][i] = temp;
        }
    }

    clock_t stop = clock();
    float duration1 = (double)((stop - start) * 1000000) / CLOCKS_PER_SEC;
    start = clock();

    for (int j = 0; j < n; j++)
    {
        for (int i = 0; i < j; i++)
        {
            temp = A[i][j];
            A[i][j] = A[j][i];
            A[j][i] = temp;
        }
    }

    stop = clock();
    float duration2 = (double)((stop - start) * 1000000) / CLOCKS_PER_SEC;

    for (int i = 0; i < n; i++)
    {
        free(A[i]);
    }

    free(A);

    Pair result = {duration1, duration2};
    return result;
}

Pair additional_matrix_transpose(int n)
{
    int **A, **B;
    A = (int **)malloc(n * sizeof(int *));
    B = (int **)malloc(n * sizeof(int *));

    for (int i = 0; i < n; i++)
    {
        A[i] = (int *)malloc(n * sizeof(int));
        B[i] = (int *)malloc(n * sizeof(int));
    }

    clock_t start = clock();

    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            B[j][i] = A[i][j];
        }
    }

    clock_t stop = clock();
    float duration1 = (double)((stop - start) * 1000000) / CLOCKS_PER_SEC;

    start = clock();

    for (int j = 0; j < n; j++)
    {
        for (int i = 0; i < n; i++)
        {
            B[j][i] = A[i][j];
        }
    }

    stop = clock();
    float duration2 = (double)((stop - start) * 1000000) / CLOCKS_PER_SEC;

    for (int i = 0; i < n; i++)
    {
        free(A[i]);
        free(B[i]);
    }

    free(A);
    free(B);

    Pair result = {duration1, duration2};
    return result;
}

int main()
{
    FILE *outFile;
    outFile = fopen("data.txt", "w");

    for (int n = 1; n <= 600; n++)
    {
        printf("%d\n", n);
        // Pair x = in_place_transpose(n);
        // float duration1 = x.first;
        // float duration2 = x.second;
        // fprintf(outFile, "%d %f %f\n", n, duration1, duration2);

        // Pair x = additional_matrix_transpose(n);
        // float duration1 = x.first;
        // float duration2 = x.second;
        // fprintf(outFile, "%d %f %f\n", n, duration1, duration2);

        Pair6 x = multiply(n);
        float duration1 = x.first;
        float duration2 = x.second;
        float duration3 = x.third;
        // float duration4 = x.fourth;
        // float duration5 = x.fifth;
        // float duration6 = x.sixth;

        fprintf(outFile, "%d %f %f %f\n", n, duration1, duration2, duration3);
    }
    fclose(outFile);
    return 0;
}
