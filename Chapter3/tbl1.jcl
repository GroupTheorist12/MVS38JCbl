//HERTBL1 JOB (COBOL),
//             'Table 1',
//             CLASS=A,
//             MSGCLASS=A,
//             REGION=8M,TIME=1440,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//TBL1   EXEC COBUCG,
//         PARM.COB='FLAGW,LOAD,SUPMAP,SIZE=2048K,BUF=1024K'
//COB.SYSPUNCH DD DUMMY
//COB.SYSIN    DD *
000001	IDENTIFICATION DIVISION.
000002	PROGRAM-ID. HELLO.
000003   ENVIRONMENT DIVISION.
000004	DATA DIVISION.
000005	WORKING-STORAGE SECTION.
000006	   01 WS-TABLE.
000007	      05 WS-A OCCURS 4 TIMES.
000008	         10 WS-NAME PIC A(5).
000009	         10 WS-AGE PIC 9(3).
000010	
000011	PROCEDURE DIVISION.
000012	      MOVE 'AB123456CD123456EF123456' TO WS-TABLE.
000013	      MOVE 'STEVE34' TO WS-A (1).
000014	      MOVE 'TIFFI32' TO WS-A (2).
000015	      MOVE 'ROBBY32' TO WS-A (3).
000016	      MOVE 'YVONN61' TO WS-A (4).
000017	    
000018	      DISPLAY 'WS-TABLE  : ' WS-TABLE.
000019	      DISPLAY 'WS-A(1)   : ' WS-A (1).
000020	      DISPLAY 'WS-NAME(1): ' WS-NAME (1).
000021	      DISPLAY 'WS-AGE(1) : ' WS-AGE (1).
000022	      DISPLAY 'WS-A(2)   : ' WS-A (2).
000023	      DISPLAY 'WS-A(3)   : ' WS-A (3).
000024	      DISPLAY 'WS-A(4)   : ' WS-A (4).
000025	
000026	      STOP RUN.
 /*
//COB.SYSLIB   DD DSNAME=SYS1.COBLIB,DISP=SHR
//GO.SYSIN  DD * 
//GO.SYSOUT DD SYSOUT=*
/*
//        
        