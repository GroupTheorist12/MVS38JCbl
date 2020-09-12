       IDENTIFICATION DIVISION.
       PROGRAM-ID.     'CALLER'.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       
         WORKING-STORAGE SECTION.
         01 WS-PARM1.
            05 WS-STUDENT-ID PIC 9(4).
            05 WS-STUDENT-NAME PIC A(15).
         01 WS-MODULE-BLK-1.                                             
            05  WS-MODULE-NAME1     PIC X(8)   VALUE 'CALLEE'.         
            05  WS-MODULE-ADDR      PIC X(4)   VALUE LOW-VALUES.         
            05  WS-CALL-MODE1       PIC X      VALUE 'K'.                
            05  FILLER              PIC XXX    VALUE LOW-VALUES.         
      
       PROCEDURE DIVISION.
           CALL 'DYNALOAD' USING WS-MODULE-BLK-1  
                      WS-PARM1.                  
           DISPLAY 'Student Id : ' WS-STUDENT-ID
           DISPLAY 'Student Name : ' WS-STUDENT-NAME
           STOP RUN.
