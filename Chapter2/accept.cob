      *Data comes from GO.SYSIN
       IDENTIFICATION DIVISION.    
       PROGRAM-ID.  'ACCPT'.      
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.    
       01 STR1         PIC X(5).   
       01 STR2         PIC X(5).   
       PROCEDURE DIVISION.         
           ACCEPT STR1.           
           ACCEPT STR2.           
                            
           DISPLAY STR1 ' ' STR2. 
           STOP RUN. 