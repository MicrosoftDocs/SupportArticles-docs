---
title: Error when you import or delete solution
description: Provides a solution to an error that occurs when importing or deleting solution in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# Permission error "80040220" when importing or deleting solution in Microsoft Dynamics 365

This article provides a solution to an error that occurs when importing or deleting solution in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4456770

## Symptoms

When attempting to install a solution in Dynamics 365, you see the following message:

> "The import of solution: [Solution Name] failed.  
Error code 80040220"

The detail section shows the following message:

> "You do not have permission to access these records. Contact your Microsoft Dynamics 365 administrator."

When attempting to delete a solution, you see the following message:

> "Insufficient Permissions  
You do not have permission to access these records..."

## Cause

This error occurs if you're missing the necessary privileges to install or delete the solution. This issue may also occur if you don't have a license assigned.

## Resolution

Access Dynamics 365 as a user with the System Administrator or System Customizer security role to successfully remove the solution. Also verify you have a license assigned.

## More information

If you need to remove the solution using a custom security role, use the Download Log File button within the error to see details about which privilege is missing. The log file will contain error details such as the following example:

> "Principal user (Id=\<ID>, type=8) is missing prvCreateWebResource privilege (Id=\<ID>)"

The example message above indicates the user is missing the Create privilege for the Web Resource entity. For more information about how to edit a security role, see [Edit a security role](/power-platform/admin/create-edit-security-role#edit-a-security-role).

> [!NOTE]
> If a System Administrator grants access to the missing privilege and import continues to fail with this error, continue reviewing the error log to see which other privilege(s) is missing.
