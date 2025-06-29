SET SERVEROUTPUT ON;
BEGIN
    
    DBMS_OUTPUT.PUT_LINE('Case1:');
    FOR ac IN (
        SELECT AccountID, Balance
        FROM Accounts
        WHERE UPPER(AccountType) IN 'SAVINGS'
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Account: ' || ac.AccountID || 
                             ' With Balance = ' || TO_CHAR(ac.Balance * 0.01));
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('case2:');
    FOR emp IN (
        SELECT Name, Salary
        FROM Employees
        WHERE UPPER(Department) = 'IT'
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE(emp.Name || 
                             ': Bonus for the employee will be:  ' || TO_CHAR(emp.Salary * 0.10));
    END LOOP;

    -- Scenario 3: Simulated Fund Transfer
    DBMS_OUTPUT.PUT_LINE('case3:');
    DECLARE
        us1 NUMBER;
        us2   NUMBER;
    BEGIN
        SELECT Balance INTO us1 FROM Accounts WHERE AccountID = 4;
        SELECT Balance INTO us2   FROM Accounts WHERE AccountID = 5;

        IF us1 >= 500 THEN
            DBMS_OUTPUT.PUT_LINE('success');
            DBMS_OUTPUT.PUT_LINE('New (after transaction) ' || (us1 - 500));
            DBMS_OUTPUT.PUT_LINE('New (after transcation): ' || (us2 + 500));
        ELSE
            DBMS_OUTPUT.PUT_LINE('Transfer failed');
        END IF;
    END;
END;
/