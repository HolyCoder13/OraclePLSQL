CREATE OR REPLACE 
PACKAGE TEKSTOWE2 AS 
 FUNCTION ZLICZ_ZNK(napis IN VARCHAR2, znak IN CHAR) return NUMBER;
 FUNCTION OD_KONCA( napis in VARCHAR2) return varchar2;
 FUNCTION SRODEK (napis in varchar2) return varchar2;
 PROCEDURE POWT(napis in Varchar2);
END TEKSTOWE2;
/
Create or Replace PACKAGE BODY Tekstowe2 AS
    FUNCTION ZLICZ_ZNK(napis in varchar2, znak in char) return number is
    ile NUMBER:= 0;
    BEGIN
       FOR i IN 1..LENGTH(napis) LOOP
            IF SUBSTR(napis, i, 1) = znak THEN
                ile := ile + 1;
            END IF;
        END LOOP;
        RETURN ile;
    END ZLICZ_ZNK ;   
    FUNCTION OD_KONCA(napis IN VARCHAR2) RETURN VARCHAR2 IS
        odwr_napis VARCHAR2(32767);
    BEGIN
        FOR i IN REVERSE 1..LENGTH(napis) LOOP
            odwr_napis := odwr_napis || SUBSTR(napis, i, 1);
        END LOOP;
        RETURN odwr_napis;
    END OdKonca;


END TEKSTOWE2