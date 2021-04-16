---
title: Timeout when administrator changes user record
description: This article provides a resolution for the problem where administrator is unable to make changes to a user record in Microsoft Dynamics CRM 2011 and receives a generic SQL Server error message.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# A SQL Server Timeout may occur when changing a name field for a Microsoft Dynamics CRM User

This article helps you resolve the problem where administrator is unable to make changes to a user record in Microsoft Dynamics CRM 2011 and receives a generic SQL Server error message.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2637855

## Symptoms

An administrator is unable to make changes to a user record in Microsoft Dynamics CRM 2011 and receives a generic SQL Server error message.

## Cause

This can be caused by the user owning a high number of related records that need to be updated in the **ActivityPartyBase** table in the Microsoft Dynamics CRM organization database.

## Resolution

Increase the `HKLM\Software\Microsoft\MSCRM\OLEDBTimeout` to a higher value either on a temporary basis or permanent basis on the Microsoft Dynamics CRM Server.

Create or change the **OleDbTimeout** value

1. In Registry Editor, locate and then click the following registry subkey:

   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSCRM`

2. Double-click the **OleDbTimeout** value.

    > [!NOTE]
    > If the **OleDbTimeout** value does not exist, create an **OleDbTimeout** value. To do this, follow these steps:
    >
    > 1. Right-click **MSCRM**, point to **New**, and then click **DWORD** value.
    > 2. Type *OleDbTimeout*.

3. In the **Edit DWORD Value** dialog box, click **Decimal**, type *600* in the **Value** data field, and then click **OK**.

    > [!NOTE]
    > The value of 600 represents 600 seconds. By default, the value is 30 seconds. Also note that if required on a temporary basis to allow this operation to complete, you may need to set this to 86400 which is equivalent to a value of 24 hours.

> [!NOTE]
> It's recommended to run with the **OLDDBTimeout** setting set to a value between 30 to 600 decimal as a best practice to help minimize excessive SQL Blocking that a long running or expensive query may cause.
