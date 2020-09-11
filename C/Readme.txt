DYNALOAD install directions from zip file

1.  These instruction assume you are installing these software to an MVS 38j system running under Hercules.
2.  If not already done so, extract the other files from this zip file that this file was in.
3.  The jcl stream for installing DYNALOAD is "install.jcl".  This jcl will create 3 pds for the
    assembler code, Cobol code and load modules.  The names will be:
    HERC01.DYNALOAD.ASM, HERC01.DYNALOAD.COBOL and HERC01.DYNALOAD.LOADLIB
4.  If you want to use different dataset names, you may do a global change to the dataset names.
5.  Start MVS if not already running.
6.  Submit the install.JCL using the hercrdr
7.  All the steps should end with condition code zero.  See HERC01I-J176.txt for an example of what the
    install should look like.
8.  Submit the installe.jcl using the hercrdr.  This tests the DYNALOAD subroutine.  See HERC01I-J177 for
    what the test should print.  If it matches, the install was successful.

DYNALOAD install directions from aws tape

1.  These instruction assume you are installing these software to an MVS 38j system running under Hercules.
2.  Start MVS if not already running.
3.  If not already done so, restore the DYNALOAD.aws tape using jcl similar to below.
4.  The jcl stream for installing DYNALOAD is "herc01.install".  This jcl will create 3 pds for the
    assembler code, Cobol code and load modules.  The names will be:
    HERC01.DYNALOAD.ASM, HERC01.DYNALOAD.COBOL and HERC01.DYNALOAD.LOADLIB
5.  If you want to use different dataset names, you may do a global change to the dataset names.
6.  Submit the "install" JCL using the hercrdr
7.  All the steps should end with condition code zero.  See HERC01I-J176.txt for an example of what the
    install should look like.
8.  Submit the "installe" jcl using the hercrdr.  This tests the DYNALOAD subroutine.  See HERC01I-J177 for
    what the test should print.  If it matches, the install was successful.


//RESTORE JOB MSGCLASS=A                                                00000010
//*                                                                     00000020
//*  THIS WILL COPY THE INSTALL JCL TO TSO USERID HERC01.               00000030
//*  AFTER THIS JOB COMPLETES, SUBMIT THE JCL IN                        00000040
//*  HERC01.INSTALL.  TO TEST THE INSTALL,                              00000050
//*  SUBMIT HERC01.INSTALLE                                             00000060
//*                                                                     00000070
//S1  EXEC PGM=IEBGENER                                                 00000080
//SYSUT1 DD DSN=DYNALOAD.INSTALL1,DISP=OLD,                             00000090
//       UNIT=(480,,DEFER),VOL=(,RETAIN,SER=T00000),                    00000100
//       LABEL=(1,SL)                                                   00000110
//SYSUT2 DD DSN=HERC01.INSTALL,DISP=(NEW,CATLG),                        00000120
//       UNIT=DISK,VOL=SER=PUB002,                                      00000130
//       SPACE=(TRK,(3,3),RLSE),                                        00000140
//       DCB=(RECFM=FB,LRECL=80,BLKSIZE=3120)                           00000150
//SYSIN  DD DUMMY                                                       00000160
//SYSPRINT DD SYSOUT=A                                                  00000170
//*                                                                     00000180
//S2  EXEC PGM=IEBGENER                                                 00000190
//SYSUT1 DD DSN=DYNALOAD.INSTALL2,DISP=OLD,                             00000200
//       UNIT=(480,,DEFER),VOL=(,RETAIN,SER=T00000),                    00000210
//       LABEL=(2,SL)                                                   00000220
//SYSUT2 DD DSN=HERC01.INSTALLE,DISP=(NEW,CATLG),                       00000230
//       UNIT=DISK,VOL=SER=PUB002,                                      00000240
//       SPACE=(TRK,(1,1),RLSE),                                        00000250
//       DCB=(RECFM=FB,LRECL=80,BLKSIZE=3120)                           00000260
//SYSIN  DD DUMMY                                                       00000270
//SYSPRINT DD SYSOUT=A                                                  00000280
