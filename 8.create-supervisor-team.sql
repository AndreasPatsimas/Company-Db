USE Company;  
GO  
CREATE PROCEDURE HumanResources   
    @empId nvarchar(50)   
AS   

	if @empId in (select EMP_Supervisor from Employee)
	begin
		DECLARE @teamName varchar(30) = (select EMP_Name from Employee where EMP_ID = @empId)

		insert into Attribute values ((SELECT NEWID()), 'Team', @teamName);

		insert into EmployeeAttribute (EMPATTR_EmployeeID, EMPATTR_AttributeID)
		select EMP_ID, ATTR_ID from Employee, Attribute where EMP_ID in
		(
			select EMP_ID from Employee where EMP_Supervisor 
			in (select EMP_ID from Employee where EMP_Supervisor = @empId)
			or EMP_Supervisor = @empId
		)
		and ATTR_ID = (select TOP (1) ATTR_ID from Attribute where ATTR_Name = 'Team' and ATTR_Value = @teamName)
		group by EMP_ID, ATTR_ID;
	end  
GO 