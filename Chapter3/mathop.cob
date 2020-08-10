       IDENTIFICATION DIVISION.
       PROGRAM-ID.     'MATHOP'.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
         WORKING-STORAGE SECTION.
         01 WS-U-PRICE1             PIC 9(5)V99 VALUE 123.45.
         01 WS-U-PRICE2             PIC 9(5)V99 VALUE 567.89.
         01 DISPLAY-U-PRICE         PIC ZZ,ZZ9.99. 
         01 WS-S-PRICE1             PIC S9(5)V99 VALUE -123.45. 
         01 WS-S-PRICE2             PIC S9(5)V99 VALUE  -567.89. 
         01 DISPLAY-S-PRICE         PIC ++,++9.99. 

       PROCEDURE DIVISION.
           ADD WS-U-PRICE1 TO WS-U-PRICE2.
           MOVE WS-U-PRICE2 TO DISPLAY-U-PRICE.

           ADD WS-S-PRICE1 TO WS-S-PRICE2.
           MOVE WS-S-PRICE2 TO DISPLAY-S-PRICE.

           DISPLAY  'Add unsigned: ' DISPLAY-U-PRICE.   
           DISPLAY  'Add signed: ' DISPLAY-S-PRICE.   
           
           MOVE 567.89 TO WS-U-PRICE2.
           MOVE -567.89 TO WS-S-PRICE2.

           ADD WS-U-PRICE1 TO WS-S-PRICE2.
           MOVE WS-S-PRICE2 TO DISPLAY-S-PRICE.
           DISPLAY  'Add signed, unsigned: ' DISPLAY-S-PRICE.   

           MOVE 567.89 TO WS-U-PRICE2.
           MOVE -567.89 TO WS-S-PRICE2.

           SUBTRACT WS-U-PRICE1 FROM WS-U-PRICE2.
           MOVE WS-U-PRICE2 TO DISPLAY-U-PRICE.

           SUBTRACT WS-S-PRICE1 FROM WS-S-PRICE2.
           MOVE WS-S-PRICE2 TO DISPLAY-S-PRICE.

           DISPLAY  'Subtract unsigned: ' DISPLAY-U-PRICE.   
           DISPLAY  'Subtract signed: ' DISPLAY-S-PRICE.   

           MOVE 567.89 TO WS-U-PRICE2.
           MOVE -567.89 TO WS-S-PRICE2.

           MULTIPLY WS-U-PRICE1 BY WS-U-PRICE2.
           MOVE WS-U-PRICE2 TO DISPLAY-U-PRICE.

           DISPLAY  'Multiply unsigned: ' DISPLAY-U-PRICE.   

           MOVE 567.89 TO WS-U-PRICE2.
           MOVE -567.89 TO WS-S-PRICE2.

           DIVIDE WS-U-PRICE1 INTO WS-U-PRICE2.
           MOVE WS-U-PRICE2 TO DISPLAY-U-PRICE.

           DIVIDE WS-S-PRICE1 INTO WS-S-PRICE2.
           MOVE WS-S-PRICE2 TO DISPLAY-S-PRICE.

           DISPLAY  'Divide unsigned: ' DISPLAY-U-PRICE.   
           DISPLAY  'Divide signed: ' DISPLAY-S-PRICE.   


           STOP RUN.