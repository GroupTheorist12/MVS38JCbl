#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#pragma linkage(CENTRY,COBOL)
void CENTRY(int x)
{
    printf("%d", x);
}