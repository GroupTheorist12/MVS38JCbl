       IDENTIFICATION DIVISION.
       PROGRAM-ID.     'CALLEE'.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
         LINKAGE SECTION.
         01 LS-PARM1.
            05 LS-STUDENT-ID PIC 9(4).
            05 LS-STUDENT-NAME PIC A(15).
      
       PROCEDURE DIVISION USING LS-PARM1.
           DISPLAY 'In Called Program'.
           MOVE 2222 TO LS-STUDENT-ID.
           MOVE 'MARLENE RIGG' TO LS-STUDENT-NAME.
           MOVE ZERO TO RETURN-CODE. 
           GOBACK.      
                 