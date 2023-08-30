CREATE USER MaskingTestUser WITHOUT LOGIN;  

GRANT SELECT ON SCHEMA::Data TO MaskingTestUser;  
  
  -- impersonate for testing:
EXECUTE AS USER = 'MaskingTestUser';  

SELECT * FROM Data.Membership 
INSERT INTO Data.Membership (FirstName, LastName, Phone, Email, DiscountCode)
VALUES   
('Douglas', 'Castro', '555.123.4567', 'douglas.castro@rvc.law', 10)

update Data.Membership set discountcode = 200 where email = 'douglas.castro@rvc.law'
REVERT;  