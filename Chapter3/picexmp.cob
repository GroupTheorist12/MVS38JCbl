       IDENTIFICATION DIVISION.
       PROGRAM-ID.     'PICEXMP'.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
         WORKING-STORAGE SECTION.
         01 WS-NAME                 PIC A(7) VALUE 'EXAMPLE'.
         01 WS-FIELD                PIC X(7) VALUE 'ALPHA12'.
         01 WS-U-INT                PIC 9(5) VALUE 1234.
         01 DISPLAY-U-INT           PIC Z(5)9.
         01 WS-S-INT                PIC S9(5) VALUE -1234.
         01 DISPLAY-S-INT           PIC +(5)9. 
         01 WS-U-PRICE              PIC 9(5)V99 VALUE 123.45.
         01 DISPLAY-U-PRICE         PIC ZZ,ZZ9.99. 
         01 WS-S-PRICE              PIC S9(5)V99 VALUE -123.45. 
         01 DISPLAY-S-PRICE         PIC ++,++9.99. 

       PROCEDURE DIVISION.
              MOVE WS-U-INT TO DISPLAY-U-INT.
              MOVE WS-S-INT TO DISPLAY-S-INT.
              MOVE WS-U-PRICE TO DISPLAY-U-PRICE. 
              MOVE WS-S-PRICE TO DISPLAY-S-PRICE. 

              DISPLAY 'WS-NAME: ' WS-NAME.
              DISPLAY 'WS-FIELD: ' WS-FIELD.
              DISPLAY 'DISPLAY-U-INT: ' DISPLAY-U-INT. 
              DISPLAY 'DISPLAY-S-INT: ' DISPLAY-S-INT. 
              DISPLAY 'DISPLAY-U-PRICE: ' DISPLAY-U-PRICE.
              DISPLAY 'DISPLAY-S-PRICE: ' DISPLAY-S-PRICE.
           STOP RUN.