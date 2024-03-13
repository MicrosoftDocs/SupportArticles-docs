---
title: Cannot access Management Reporter after making changes to domain
description: Describes the steps to take that will give users access to Management Reporter after changing the domain.
ms.reviewer: theley, erikjohn
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# No longer have permission to access Management Reporter after you make changes to your domain

This article provides a resolution for the permission issue that occurs after you make changes to your domain.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP, Microsoft Dynamics AX 2009, Microsoft Dynamics SL 2015, Microsoft Dynamics SL 2011  
_Original KB number:_ &nbsp; 3163587

## Symptoms

After making changes to your domain, users are not able to access Management Reporter.

## Cause

Windows SID has changed for the user and is no longer valid.

## Resolution

Update Windows SID for a user that has the Administrator role in Management Reporter.

1. Sign in to the SQL server as one of the users that has the Administrator role in Management Reporter.

2. Select **Start** > **Run** and enter CMD.

    1. At the Dos command type:

       `Whoami /user`
    2. In the DOS window, right-click, select **Select All**, and then press Enter.
    3. Paste the information into Notepad.

3. Open SQL Server Management Studio and run the following SQL statement, against the Management Reporter database.

    1. Management Reporter 2012 CU13 and later

        ```sql
        SELECT A.UserName, 
        B.Name, 
        CASE A.ROLETYPE 
        WHEN 2 THEN 'VIEWER' 
        WHEN 3 THEN 'GENERATOR' 
        WHEN 4 THEN 'DESIGNER' 
        WHEN 5 THEN 'ADMINISTRATOR' 
        END AS SecurityRole, 
        A.WindowsSecurityIdentifier, 
        A.UserID, 
        CASE A. AccountDisabled 
        When 0 Then 'Enabled' 
        When 1 Then 'Disabled'
        End AS AccountStatus 
        FROM Reporting.SecurityUser A 
        JOIN Reporting.SecurityPrincipal B 
        ON A.USERID = B.ID 
        ORDER BY A.UserName
        ```

    2. Management Reporter CU12 or earlier.

        ```sql
        SELECT A.UserName, 
        B.Name, 
        CASE A.ROLETYPE 
        WHEN 2 THEN 'VIEWER' 
        WHEN 3 THEN 'GENERATOR' 
        WHEN 4 THEN 'DESIGNER' 
        WHEN 5 THEN 'ADMINISTRATOR' 
        END AS SecurityRole, 
        A.WindowsSecurityIdentifier, 
        A.UserID, 
        CASE A. AccountDisabled 
        When 0 Then 'Enabled' 
        When 1 Then 'Disabled'
        End AS AccountStatus 
        FROM SECURITYUSER A 
        JOIN SECURITYPRINCIPAL B 
        ON A.USERID = B.ID 
        ORDER BY A.UserName
        ```

4. Note the UserID.

5. Make a backup of your Management Reporter database and then run the following SQL statement. You must modify the statement to include the new user's Windows SID and their existing UserID.

    1. Management Reporter CU13 or later

        ```sql
        UPDATE Reporting.SecurityUser 
        SET WindowsSecurityIdentifier = '<copy/paste new Windows SID>' 
        WHERE UserID = '<paste UserId from step4>'
        ```

    2. Management Reporter CU12 or earlier

        ```sql
        UPDATE SecurityUser 
        SET WindowsSecurityIdentifier = '<copy/paste new Windows SID>' 
        WHERE UserID = '<paste UserId from step4>'
        ```

6. Run the following SQL statement, modifying the statement to include the new user's domain\alias.

    1. Management Reporter 2012 CU13 or later.

        ```sql
        UPDATE Reporting.SecurityPrincipal 
        SET Name = '<enter new domain\alias>' 
        WHERE ID = '<paste UserId from step4>'
        ```

    2. Management Reporter 2012 CU12 or earlier

        ```sql
        UPDATE SecurityPrincipal 
        SET Name = '<enter new domain\alias>' 
        WHERE ID = '<paste UserId from step4>'
        ```

7. The user should now be able to log into Management Reporter. To update the other users, select **Security**. Select **Users** and then remove the users that are unable to access Management Reporter. You can then add the users back with their new domain name.
