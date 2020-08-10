//ALLOC2 JOB (COBOL), 
//             'New PDS',
//             CLASS=A,
//             MSGCLASS=H,
//             REGION=8M,TIME=1440,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//STEP10   EXEC PGM=IEFBR14                                             
//SYSPRINT DD SYSOUT=*                                                  
//SYSOUT   DD SYSOUT=*                                                  
//SYSDUMP  DD SYSOUT=*                                                  
//DD1      DD DSN=HERC01.TEST.SOURCE,                                   
//            DISP=(NEW,CATLG),                
//            SPACE=(TRK,(15,1,1),RLSE),UNIT=SYSDA,VOL=SER=PUB002,                        
//            DCB=(DSORG=PO,RECFM=FB,LRECL=80,BLKSIZE=19040)              
//*  
