CREATE TRIGGER TR_Employee_trigger
ON Employees
AFTER UPDATE, INSERT, DELETE
AS
    BEGIN
        DECLARE @EmpID int,
                @user varchar(20),
                @activity varchar(20);

        IF EXISTS(SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
            BEGIN
                SET @activity = 'UPDATE';
                SET @user = SYSTEM_USER;
                --SET @user = CURRENT_USER;
                --@fechaReg = GETDATE();
                SELECT @EmpID = EmployeeID FROM inserted ;
                INSERT INTO Emp_Audit(EmpID,Activity, DoneBy) 
                VALUES (@EmpID,@activity,@user);
            END

        IF EXISTS(SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
            BEGIN
                SET @activity = 'INSERT';
                SET @user = SYSTEM_USER;
                --SET @user = CURRENT_USER;
                --@fechaReg = GETDATE();
                SELECT @EmpID = EmployeeID FROM inserted ;
                INSERT INTO Emp_Audit(EmpID,Activity, DoneBy) 
                VALUES(@EmpID,@activity,@user);
            END

        IF EXISTS(SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
            BEGIN 
                SET @activity = 'DELETE';
                SET @user = SYSTEM_USER;
                --SET @user = CURRENT_USER;
                --@fechaReg = GETDATE();
                SELECT @EmpID = EmployeeID FROM deleted ;
                INSERT INTO Emp_Audit(EmpID,Activity, DoneBy) 
                VALUES(@EmpID,@activity,@user);
            END
    END     


