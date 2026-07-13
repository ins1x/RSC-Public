-- Add test account to accounts.db (without admin rights)
-- Accounts.db
BEGIN TRANSACTION;
INSERT INTO "Accounts" VALUES (
    'Testaccount', 
    0, 
    '678AF675A790D8E65D7F9B30EB78FC1D4D9CAF72E5266CCF29E01C6692FF43ED', 
    'C4EE5AAE444859EDDEC8C999CE98DAD4ED80DAFE', 
    0, 
    160, 
    2, 
    11, 
    1, 
    1, 
    1, 
    2, 
    0, 
    1137, 
    1, 
    1, 
    0, 
    50, 
    -1, 
    -1, 
    -1, 
    '127.0.0.1', 
    '2.12.2022 15:39', 
    'United States', 
    'Ashburn', 
    0, 
    0, 
    1, 
    NULL, 
    0, 
    1
);
COMMIT;