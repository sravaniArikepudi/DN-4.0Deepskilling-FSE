--WEEK 2: PL/SQL, JUnit_Basic Testing, Mockito, SL4J Logging.
--PL/SQL:
--Exercise 1: Control Structures:
--Code:
--Tables used:Customers, loans
ALTER TABLE CUSTOMERS ADD ISVIP VARCHAR2(5);
SET SERVEROUTPUT ON;
BEGIN
    
    DBMS_OUTPUT.PUT_LINE('Case1:');
    
    FOR c IN (
        SELECT c.CustomerID, c.DOB, l.LoanID, l.InterestRate
        FROM Customers c
        JOIN Loans l ON c.CustomerID = l.CustomerID
    )
    LOOP
        IF MONTHS_BETWEEN(SYSDATE, c.DOB) / 12 > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE LoanID = c.LoanID;

            DBMS_OUTPUT.PUT_LINE('DISCOUNT:' || c.LoanID || 
                                 ' (CUSTOMERID: ' || c.CustomerID );
        END IF;
    END LOOP;

   
    DBMS_OUTPUT.PUT_LINE('CASE2:');

    FOR c IN (
        SELECT CustomerID, Name, Balance 
        FROM Customers
        WHERE Balance > 10000
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('VIP:' || c.Name || ' | Balance:' || c.Balance);
    END LOOP;

   
    DBMS_OUTPUT.PUT_LINE('CASE3:');

    FOR l IN (
        SELECT c.Name, l.LoanID, l.EndDate 
        FROM Loans l
        JOIN Customers c ON c.CustomerID = l.CustomerID
        WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Reminder:' || l.LoanID || ' for ' || l.Name || 
                             TO_CHAR(l.EndDate, 'YYYY-MM-DD'));
    END LOOP;

    COMMIT;
END;
/