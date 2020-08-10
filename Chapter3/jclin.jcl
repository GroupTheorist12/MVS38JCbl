//HERJIN JOB (COBOL),
//             'Sys In Test',
//             CLASS=A,
//             MSGCLASS=A,
//             REGION=8M,TIME=1440,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//JCLIN   EXEC COBUCG,
//         PARM.COB='FLAGW,LOAD,SUPMAP,SIZE=2048K,BUF=1024K'
//COB.SYSPUNCH DD DUMMY
//COB.SYSIN    DD *
000001 IDENTIFICATION DIVISION.                                           
000002 PROGRAM-ID.  'JCLIN'.                                             
000003 ENVIRONMENT DIVISION.                                              
000004 CONFIGURATION SECTION.                                            
000005 SOURCE-COMPUTER.  IBM-360.                                        
000006 OBJECT-COMPUTER.  IBM-360.                                        
000007 INPUT-OUTPUT SECTION.                                             
000008 FILE-CONTROL.                                                     
000009      SELECT SEQRDS-SYSIN                                           
000010        ASSIGN TO UT-S-SYSIN.                                      
000011 DATA DIVISION.                                                    
000012 FILE SECTION.                                                     
000013 FD  SEQRDS-SYSIN                                                  
000014     RECORDING MODE IS F                                           
000015     RECORD CONTAINS 80 CHARACTERS                                 
000016     BLOCK  CONTAINS  5 RECORDS                                    
000017     LABEL RECORDS ARE OMITTED                                     
000018     DATA RECORD IS SEQRDS-SYSIN-RECORD.                            
000019 01  SEQRDS-SYSIN-RECORD.                                           
000020  02 STD-NO          PIC 9(03).                                                         
000021  02 STD-NAME        PIC X(20).                                                         
000022  02 STD-GENDER      PIC X(07).                                                         
000023  02 FILLER          PIC X(50).                                                         
000024 WORKING-STORAGE SECTION.  
000025 77 N PIC 99999999 COMP VALUE 5.                                    
000026 77 WS-FS           PIC 9(02).                                
000027 01 WS-EOF-SW       PIC X(01) VALUE 'N'.                      
000028      88 EOF-SW         VALUE 'Y'.                               
000029      88 NOT-EOF-SW     VALUE 'N'.                                
000030
000031 01  WS-SYSIN-RECORD.                                           
000032  02 STD-NO-IN          PIC 9(03).                                                         
000033  02 STD-NAME-IN        PIC X(20).                                                         
000034  02 STD-GENDER-IN      PIC X(07).                                                         
000035  02 FILLER             PIC X(50).                  
000036 PROCEDURE DIVISION.         
000037 MAIN-PART.                                                         
000038     OPEN INPUT SEQRDS-SYSIN.
000039     PERFORM RDR-WRTR-IT UNTIL EOF-SW.                                   
000040     CLOSE SEQRDS-SYSIN 
000041     STOP RUN.                                                      
000042 RDR-WRTR-IT.
000043      READ SEQRDS-SYSIN INTO WS-SYSIN-RECORD 
000044      AT END MOVE 'Y' TO WS-EOF-SW.
000045      IF NOT-EOF-SW 
000046         DISPLAY 'CURRENT RECORD : ' WS-SYSIN-RECORD.
 /*
//COB.SYSLIB   DD DSNAME=SYS1.COBLIB,DISP=SHR
//GO.SYSOUT DD SYSOUT=*
//GO.SYSIN  DD * 
100BRAD RIGG           M                                                       
101DUDE RIGG           M                                                       
102FUNK RIGG           M                                                       
103SETH RIGG           M                                                       
104RUTH RIGG           M                                                       
/*
//        
        