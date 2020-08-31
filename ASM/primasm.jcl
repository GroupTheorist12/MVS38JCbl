//PRIMASM  JOB (BAL),
//             'Eratosthenes Sieve',
//             CLASS=A,
//             MSGCLASS=A,
//             TIME=1440,
//             MSGLEVEL=(1,1)
//********************************************************************
//*
//* Name: SYS2.JCLLIB(PRIMASM)
//*
//* Desc: Sieve of Eratosthenes programmed in Basic Assembler Language
//*       All prime numbers up to the value entered via PARM.GO
//*       are computed.
//*
//********************************************************************
//PRIMES  EXEC ASMFCG,PARM.ASM=(OBJ,NODECK),MAC1='SYS2.MACLIB',
//             REGION.GO=128K,PARM.GO='/2000'
//ASM.SYSIN DD *
PRIMASM  TITLE 'Sieve of Eratosthenes: Find Prime Numbers'              00010000
*********************************************************************** 00020000
***                                                                 *** 00030000
*** Program:  PRIMASM                                               *** 00040000
***                                                                 *** 00050000
*** Purpose:  Find all prime numbers up to a given limit            *** 00060000
***           using Eratothenes' sieve algorithm.                   *** 00070000
***                                                                 *** 00080000
*** Usage:    The following JCL is required to run PRIMASM:         *** 00090000
***                                                                 *** 00100000
***           //PRIMASM EXEC PGM=PRIMASM,REGION=<size>,PARM=<limit> *** 00110000
***           //STEPLIB  DD  DSN=<loadlib>,DISP=SHR                 *** 00120000
***           //SYSPRINT DD  SYSOUT=*                               *** 00130000
***                                                                 *** 00140000
***           The parameters are defined as follows:                *** 00150000
***                                                                 *** 00160000
***           <limit>   the largest number to sieve. All primes     *** 00170000
***                     up to this number will be found. If the     *** 00180000
***                     limit given is too high for the algorithm   *** 00190000
***                     to execute within the bounds of the         *** 00200000
***                     available virtual storage, <limit> will be  *** 00210000
***                     adjusted to fit into the given region. If   *** 00220000
***                     no PARM value is given, a default limit of  *** 00230000
***                     2000 will be used.                          *** 00240000
***                                                                 *** 00250000
***           <size>    the amount of virtual storage the program   *** 00260000
***                     is allowed to use. The program will always  *** 00270000
***                     allocate the maximum amount of storage      *** 00280000
***                     allowed by the REGION parameter. If no      *** 00290000
***                     REGION parameter is specified, results will *** 00300000
***                     be unpredictable.                           *** 00310000
***                                                                 *** 00320000
***           <loadlib> the load library containing the PRIMASM     *** 00330000
***                     program.                                    *** 00340000
***                                                                 *** 00350000
*** Function: 1. Allocate all virtual storage available and adjust  *** 00360000
***              the sieve limit if necessary. This storage is      *** 00370000
***              used as flags, where each bit indicates whether    *** 00380000
***              the odd number corresponding to the bit's position *** 00390001
***              is prime or not. Odd numbers are assigned to these *** 00394001
***              bits in sequence, i.e. numbers 1,3,5,7,9,11,13,15  *** 00398001
***              correspond to bits 0,1,2,3,4,5,6,7 and so forth.   *** 00402001
***                                                                 *** 00410000
***           2. Set all prime flags to one, except the first.      *** 00420001
***              The first flag corresponds to the number one,      *** 00425001
***              which isn't prime. Note that there don't exist     *** 00430001
***              flags for even numbers, because even numbers       *** 00435001
***              (except the two) are never prime.                  *** 00440001
***                                                                 *** 00450000
***           3. Run Eratothenes' sieve which will result in        *** 00460000
***              clearing the prime flags of all none prime numbers *** 00470000
***              up to the given limit.                             *** 00480000
***                                                                 *** 00490000
***           4. Print all numbers having their prime flag set to   *** 00500000
***              SYSPRINT. The "irregular" two is printed manually  *** 00510001
***              for the sake of completeness.                      *** 00513001
***                                                                 *** 00520000
***           5. Print a summary message indicating the number of   *** 00530000
***              primes found up to the given limit to SYSPRINT and *** 00540000
***              to the job log.                                    *** 00550000
***                                                                 *** 00560000
***           6. Release the allocated storage.                     *** 00570000
***                                                                 *** 00580000
***           7. Exit.                                              *** 00590000
***                                                                 *** 00600000
*** Updates:  2014/07/18 original implementation.                   *** 00610001
***           2014/07/21 eliminate even numbers from prime flags.   *** 00613001
***                                                                 *** 00620000
*** Author:   Juergen Winkelmann, ETH Zuerich.                      *** 00630001
***                                                                 *** 00640000
*********************************************************************** 00650000
PRIMASM  CSECT                                                          00660000
         SAVE  (14,12),,*       save registers                          00670000
         LR    R12,R15          establish module addressability         00680000
         USING PRIMASM,R12      tell assembler of base                  00690000
         LA    R2,SAVEA         chain ..                                00700000
         ST    R13,4(,R2)         .. the ..                             00710000
         ST    R2,8(,R13)           .. save ..                          00720000
         LR    R13,R2                 .. areas                          00730000
*                                                                       00740000
* Initialize sieve limit and virtual storage                            00750000
*                                                                       00760000
         L     R2,0(,R1)        parameter list address                  00770000
         LH    R1,0(,R2)        length of PARM field                    00780000
         LTR   R1,R1            PARM field specified?                   00790000
         BZ    NOPARM           no, use default sieve limit             00800000
         L     R3,HIGHLIM       maximum PARM allowed                    00810000
         LA    R4,10            maximum PARM length allowed             00820000
         CR    R1,R4            maximum PARM length exceeded?           00830000
         BH    HIGHPARM         yes -> use maximum as sieve limit       00840000
         LA    R3,PARM+10       right justify ..                        00850000
         SR    R3,R1              .. to 10 digits                       00860000
         BCTR  R1,0             decrement for EXecute                   00870000
         EX    R1,MOVEPARM      get PARM                                00880000
         PACK  NUMDEC(8),PARM(10) pack PARM and ..                      00890000
         CVB   R3,NUMDEC            .. convert to binary                00900000
HIGHPARM ST    R3,LIMIT         set sieve limit                         00910000
NOPARM   OPEN  (SYSPRINT,OUTPUT) open SYSPRINT                          00920000
         GETMAIN VU,LA=GETMAX,A=ISPRIME allocate all available storage  00930000
         L     R7,MAXMEM        storage amount obtained times 16 ..     00940001
         SLL   R7,4               .. is maximum sieve limit possible    00946001
         C     R7,LIMIT         does requested limit fit into storage?  00960000
         BNL   *+8              yes -> use requested limit              00970000
         ST    R7,LIMIT         no  -> use maximum possible             00980000
         L     R6,ISPRIME       address of storage obtained             00990000
         L     R8,LIMIT         sieve limit                             01000000
         XR    R9,R9            clear R9 for modulo                     01010000
         SRDL  R8,4             divide sieve limit by 16                01020001
         LR    R7,R8            amount of storage to be initialized     01030000
         LTR   R9,R9            sieve limit modulo 16 = 0?              01040001
         BZ    *+8              yes -> use computed storage amount      01050000
         LA    R7,1(,R7)        no  -> increment amount by one          01060000
         XR    R8,R8            clear R8 for MVCL                       01070000
         L     R9,FF            get initialization pattern for MVCL     01080001
         MVCL  R6,R8            initialize prime indication flags       01090000
         L     R6,ISPRIME       start of prime indication flags         01100000
         MVI   0(R6),X'7F'      make one not prime                      01110001
*                                                                       01120000
* Sieve of Eratosthenes                                                 01130000
*                                                                       01140000
         L     R1,ISPRIME       address of prime flag array             01150000
         LA    R2,CROSSOUT      masks to cross out primes               01160000
         XR    R3,R3            clear for prime test EXecuted later     01170000
         LA    R4,PRIMFLGS      masks for prime test                    01180000
         LA    R5,1             candidate bit offset \  sieve starts    01190001
         LR    R6,R1            candidate address     >      at         01200000
         LA    R7,3             candidate value      /     three        01210000
         LA    R14,2            incrementor for large numbers           01220001
SIEVE    LR    R9,R7            is square of ..                         01230000
         MR    R8,R7              .. candidate value ..                 01240000
         C     R9,LIMIT             .. higher than sieve limit?         01250000
         BH    PRNTPRIM         yes -> sieve complete, go print         01260000
         IC    R3,0(R5,R4)      is prime flag for ..                    01270000
         EX    R3,TESTPRIM        .. this candidate set?                01280000
         BNO   SIEVENXT         no  -> check next candidate             01290000
CLRMULT  SLL   R7,1             only odd multiples need to be cleared   01300001
CLRMULTL LR    R10,R9           current prime multiple                  01303001
         BCTR  R10,0            decrement for addressing                01310000
         SRL   R10,1            divide by two (address compression)     01315001
         SRDL  R10,3            divide by eight                         01320000
         AR    R10,R1           address of prime multiple               01330000
         SRL   R11,29           bit offset of prime multiple            01340000
         IC    R3,0(R11,R2)     get cross out mask                      01350000
         EX    R3,CLRPRIM       cross out prime multiple                01360000
         AR    R9,R7            is next odd prime multiple ..           01370001
         C     R9,LIMIT           .. not higher than sieve limit?       01380000
         BNH   CLRMULTL         yes -> go cross it out                  01390001
         SRL   R7,1             restore candidate value                 01393001
SIEVENXT AR    R7,R14           next please, skip even numbers          01400000
         LA    R5,1(,R5)        next bit position                       01410001
         CH    R5,EIGHT         end of byte reached                     01420000
         BL    SIEVE            no  -> check candidate                  01430000
         LA    R5,0             yes -> reset candidate bit offset ..    01440001
         LA    R6,1(,R6)                 .. and increment to next byte  01450001
         B     SIEVE            go check it                             01470000
*                                                                       01480000
* Print primes                                                          01490000
*                                                                       01500000
PRNTPRIM LA    R5,1             candidate bit offset \  print starts    01510001
         LR    R6,R1            candidate address     >      at         01520000
         LA    R7,3             candidate value      /     three        01530000
         LA    R2,2             incrementor for large limits            01540000
         LA    R8,1             number of primes found, the two is ..   01550000
         LA    R10,1              .. pre set and ..                     01560000
         LA    R9,PRNTLINE+11     .. pre printed                        01570000
         XR    R11,R11          no lines printed on this page yet       01580000
         B     *+16             skip page initialization on first page  01590000
NEWLINE  MVC   CC(166),NL       new line                                01600000
         LA    R9,PRNTLINE      current print position                  01610000
         XR    R10,R10          no numbers printed on this line yet     01620000
         CH    R11,LPP          page full?                              01630000
         BNE   CHKPRIME         no -> check next number                 01640000
         XR    R11,R11          no lines printed on this page yet       01650000
         MVI   CC,C'1'          next line starts a new page             01660000
CHKPRIME C     R7,LIMIT         sieve limit reached?                    01670000
         BH    LASTLINE         yes -> print last line                  01680000
         IC    R3,0(R5,R4)      is prime flag for ..                    01690000
         EX    R3,TESTPRIM        .. this candidate set?                01700000
         BNO   CHKNEXT          no  -> check next candidate             01710000
         LA    R8,1(,R8)        yes -> increment number of primes found 01720000
         CVD   R7,NUMDEC        convert prime to decimal                01730000
         MVC   0(11,R9),EDIT    get print format into print position    01740000
         ED    1(11,R9),NUMDEC+3 format prime                           01750000
         LA    R10,1(,R10)      increment number of primes and ..       01760000
         LA    R9,11(,R9)         .. print position                     01770000
         CH    R10,NPL          is current line filled up?              01780000
         BNE   CHKNEXT          no  -> check next candidate             01790000
         PUT   SYSPRINT,CC      yes -> print line                       01800000
         LA    R11,1(,R11)      increment number of lines on this page  01810000
         LA    R15,NEWLINE      next loop initializes a new line        01820000
         B     *+8              skip adding to current line             01830000
CHKNEXT  LA    R15,CHKPRIME     next loop adds to current line          01840000
         AR    R7,R2            next please, skip even numbers          01850000
         LA    R5,1(,R5)        next bit position                       01860001
         CH    R5,EIGHT         end of byte reached                     01870000
         BLR   R15              no  -> check candidate                  01880000
         LA    R5,0             yes -> reset candidate bit offset ..    01890001
         LA    R6,1(,R6)                 .. and increment to next byte  01900001
         BR    R15              go check it                             01920000
LASTLINE LTR   R10,R10          not yet printed primes in this line?    01930000
         BZ    SUMMARY          no  -> print summary                    01940000
         PUT   SYSPRINT,CC      yes -> print last primes                01950000
         MVC   CC(166),NL       new line                                01960000
         LA    R11,1(,R11)      increment number of lines on this page  01970000
SUMMARY  CLI   CC,C'1'          new page already started?               01980000
         BE    PRINTSUM         yes -> print summary line               01990000
         LA    R11,1(,R11)      no  -> increment number of lines        02000000
         CH    R11,LPP          page almost full?                       02010000
         BNL   *+12             yes -> start new page                   02020000
         MVI   CC,C'0'          no  -> skip one line                    02030000
         B     *+8              print summary                           02040000
         MVI   CC,C'1'          start new page                          02050000
PRINTSUM CVD   R8,NUMDEC        convert number of primes to decimal     02060000
         MVC   PRNTLINE(LSUMMARY),EDIT get summary line and formats     02070000
         ED    PRNTLINE+1(11),NUMDEC+3 format number of lines           02080000
         L     R8,LIMIT         get sieve limit                         02090000
         CVD   R8,NUMDEC        convert to decimal                      02100000
         ED    PRNTLINE+LIMITEBC+1(11),NUMDEC+3 format sieve limit      02110000
         PUT   SYSPRINT,CC      print number of primes and sieve limit  02120000
         MVC   TELLUSER(4),SUMWTOP get WTO prefix and suffix ..         02130000
         MVC   PRNTLINE+LSUMMARY(4),SUMWTOS .. around summary line      02140000
         WTO   MF=(E,TELLUSER)  print summary line in job log           02150000
*                                                                       02160000
* Cleanup and return                                                    02170000
*                                                                       02180000
         FREEMAIN VU,A=ISPRIME  release storage                         02190000
         CLOSE SYSPRINT         close printer                           02200000
         L     R13,4(,R13)      caller's save area pointer              02210000
         RETURN (14,12),RC=0    restore registers and return            02220000
*                                                                       02230000
* Data area                                                             02240000
*                                                                       02250000
SAVEA    DS    18F              save area                               02260000
MOVEPARM MVC   0(1,R3),2(R2)    EXecuted to retrieve PARM field         02270000
TESTPRIM TM    0(R6),0          EXecuted to test for being prime        02280000
CLRPRIM  NI    0(R10),0         EXecuted to cross out a prime multiple  02290000
NUMDEC   DS    D                target for decimal conversion           02300000
HIGHLIM  DC    F'2147483647'    highest possible fullword value         02310000
LIMIT    DC    F'2000'          default sieve limit                     02320000
FF       DC    X'FF000000'      prime flags initialization pattern      02330001
LPP      DC    H'64'            lines to print per page                 02340000
NPL      DC    H'15'            prime numbers to print per line         02350000
EIGHT    DC    H'8'             used for loops and comparisons          02360000
PARM     DC    10C' '           PARM field goes here                    02370000
PRIMFLGS DC    B'10000000'      .. the set      ..                      02380000
         DC    B'01000000'        .. bit's        ..                    02390000
         DC    B'00100000'          .. position     ..                  02400000
         DC    B'00010000'            .. represents   ..                02410000
         DC    B'00001000'              .. a            ..              02420000
         DC    B'00000100'                .. potential    ..            02430000
         DC    B'00000010'                  .. prime        ..          02440000
         DC    B'00000001'                    .. number       ..        02450000
CROSSOUT DC    B'01111111'      .. masks        ..                      02460000
         DC    B'10111111'        .. used         ..                    02470000
         DC    B'11011111'          .. to           ..                  02480000
         DC    B'11101111'            .. cross        ..                02490000
         DC    B'11110111'              .. out          ..              02500000
         DC    B'11111011'                .. none         ..            02510000
         DC    B'11111101'                  .. prime        ..          02520000
         DC    B'11111110'                    .. numbers      ..        02530000
         DS    0F                                                       02540000
TELLUSER DS    H                WTO plist for summary message goes here 02550000
NL       DC    C' '             newline carriage control                02560000
CC       DC    C'1'             formfeed on first output line           02570000
PRNTLINE DC    10C' '           line to be printed ..                   02580000
         DC    C'2'               .. the prime two is ..                02590000
         DC    154C' '            .. pre printed on initial line        02600000
         DC    C' '             filler to receive EDit garbage          02610000
SUMWTOP  DC    X'002D8000'      prefix for summary message WTO          02620000
SUMWTOS  DC    X'02000020'      suffix for summery message WTO          02630000
EDIT     DC    2C' ',9X'20'     EDit pattern to format 9 digits         02640000
         DC    C' primes up to' .. skeleton ..                          02650000
LIMITEBC EQU   *-EDIT             .. for      ..                        02660000
         DC    2C' ',9X'20'         .. summary  ..                      02670000
         DC    C' found'              .. line     ..                    02680000
LSUMMARY EQU   *-EDIT           summary line length                     02690001
SYSPRINT DCB   DSORG=PS,MACRF=PM,DDNAME=SYSPRINT,                      X02700000
               RECFM=FBA,LRECL=166,BLKSIZE=16600  DCB for SYSPRINT      02710000
GETMAX   DC    F'8'             GETMAIN plist to obtain maximum ..      02720000
         DC    X'00FFFFF8'        .. storage available in region        02730000
ISPRIME  DS    F                address of allocated storage            02740000
MAXMEM   DS    F                amount of storage allocated             02750000
         YREGS ,                register equates                        02760000
         END   PRIMASM          end of PRIMASM                          02770000
/*
//GO.SYSPRINT DD SYSOUT=*
//
