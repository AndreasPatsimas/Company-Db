insert into EmployeeAttribute (EMPATTR_EmployeeID, EMPATTR_AttributeID)
select EMP_ID, ATTR_ID from Employee, Attribute where EMP_ID not in
(select EMPATTR_EmployeeID from EmployeeAttribute inner join Attribute
on EMPATTR_AttributeID = ATTR_ID
and ATTR_Name = 'Weight')
and ATTR_Name = 'Weight' and ATTR_Value = 'Thin'
group by EMP_ID, ATTR_ID;
update EmployeeAttribute set EMPATTR_AttributeID = (select ATTR_ID from Attribute where ATTR_Name = 'Weight' and ATTR_Value = 'Thin')  
where EMPATTR_AttributeID in (select ATTR_ID from Attribute where ATTR_Name = 'Weight');