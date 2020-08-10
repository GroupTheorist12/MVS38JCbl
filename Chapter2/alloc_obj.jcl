//ALLOOBJ JOB (COBOL), 
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
//DD1      DD DSN=HERC01.TEST.OBJ,                                   
//            DISP=(NEW,CATLG),                
//            SPACE=(TRK,(30,4,1),RLSE),UNIT=SYSDA,VOL=SER=PUB002,                        
//            DCB=(DSORG=PO,RECFM=U,BLKSIZE=19040)              
//*  
