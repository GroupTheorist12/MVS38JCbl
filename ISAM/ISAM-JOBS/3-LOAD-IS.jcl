//HERC01L  JOB MSGCLASS=H,NOTIFY=HERC01,
//             USER=HERC01,PASSWORD=CUL8TR
//***
//***  LOAD ISAM DATASET
//***
//LOADIS EXEC PGM=IEBDG
//SYSPRINT DD SYSOUT=*
//SEQIN    DD DSN=HERC01.POLYFILE,DISP=SHR
//ISAMDS   DD DSN=HERC01.POLYISAM,DISP=OLD,
//            DCB=DSORG=IS
//SYSIN    DD *
  DSD OUTPUT=(ISAMDS),INPUT=(SEQIN)
  FD NAME=BYTE0,LENGTH=1,STARTLOC=1,FILL=X'00'
  FD NAME=FLD1,LENGTH=80,STARTLOC=2,FROMLOC=1,INPUT=SEQIN
  CREATE NAME=(BYTE0,FLD1),INPUT=SEQIN
  END
/*
//
