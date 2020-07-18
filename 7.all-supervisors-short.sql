insert into EmployeeAttribute (EMPATTR_EmployeeID, EMPATTR_AttributeID)
select EMP_ID, ATTR_ID from Employee, Attribute where EMP_ID in
(select DISTINCT e1.EMP_ID from Employee as e1 
join Employee as e2
on e1.EMP_ID = e2.EMP_Supervisor)
and EMP_ID not in(
select EMPATTR_EmployeeID from EmployeeAttribute inner join Attribute
on EMPATTR_AttributeID = ATTR_ID
and ATTR_Name = 'Height'
)
and ATTR_ID = (select TOP (1) ATTR_ID from Attribute where ATTR_Name = 'Height' and ATTR_Value = 'Short')
group by EMP_ID, ATTR_ID;
update EmployeeAttribute set EMPATTR_AttributeID = (select TOP (1) ATTR_ID from Attribute where ATTR_Name = 'Height' and ATTR_Value = 'Short')  
where EMPATTR_AttributeID in (select ATTR_ID from Attribute where ATTR_Name = 'Height')
and EMPATTR_EmployeeID in (select DISTINCT e1.EMP_ID from Employee as e1 
join Employee as e2
on e1.EMP_ID = e2.EMP_Supervisor);