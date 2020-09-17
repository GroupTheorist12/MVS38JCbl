//HCOBCALL JOB (COBOL), 
//             'Caller',
//             CLASS=A,
//             MSGCLASS=A,
//             REGION=8M,TIME=1440,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//IEBGENER EXEC PGM=IEBGENER,REGION=128K
//SYSIN    DD  DUMMY
//SYSPRINT DD  SYSOUT=A
//SYSUT1   DD  *
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#pragma linkage(CENTRY,COBOL)
void CENTRY(int x)
{
    printf("%d", x);
}
/*
//SYSUT2   DD DSN=HERC01.CODE.SOURCE(COBCALLC),DISP=(OLD,CATLG)
//SYSIN    DD DUMMY
//

