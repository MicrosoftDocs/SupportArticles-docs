---
title: A Get/Change First Operation failed
description: Provides a solution to an error that occurs when you sign into Microsoft Dynamics GP after you've migrated to Microsoft SQL Server 2005 from Microsoft SQL Server 2000 with a different server name.
ms.reviewer: theley, v-jomcc
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# "A Get/Change First Operation on Table coProcess failed Accessing SQL Data" error message when you sign into Microsoft Dynamics GP after moving from one server to another

This article provides a solution to an error that occurs when you sign into Microsoft Dynamics GP after you've migrated to Microsoft SQL Server 2005 from Microsoft SQL Server 2000 with a different server name.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850997

## Symptoms

When you sign into Microsoft Dynamics GP after you've migrated to Microsoft SQL Server 2005 from Microsoft SQL Server 2000 with a different server name, you receive the following error message:
> A Get/Change First Operation on Table coProcess failed Accessing SQL Data

Additionally, if you select the **More Info** button, you receive the following message:
> [Microsoft][SQL Native Client][SQL Server] The server principal "XXXX" is not able to access the database "XXXX" under the current security context Microsoft ODBC XXXX is not valid user.

## Cause

The passwords for Microsoft Dynamics GP are encrypted based on the server name used in the ODBC connection. If the server name is different, the passwords will be encrypted differently. Because of it, if you move to a server with a different name, your passwords will no longer be valid. It will cause these errors.

## Resolution

To resolve this error, you'll need to change your user's passwords. You may do it by manually changing the user's passwords through method 1 or by allowing them to set up a new password upon sign-in through method 2.

### Method 1

1. Sign into Microsoft Dynamics GP as sa user.
2. On the **Tools** menu, select **Setup**, and then select **User**.
3. Select the **Lookup** button next to User ID and select the appropriate user.
4. In the password fields, enter a new password.
5. Select **Save**.

### Method 2

1. Sign into SQL Management Studio and expand the Security folder in Object Explorer.
2. Expand the Logins folder.
3. Right-click on the appropriate **Login** and go to **Properties**
4. Remove the passwords from both password fields.
5. Select **OK**.

### Method 3

In SQL, select **DATABASES | COMPANY |SECURITY | USERS** and right-click on the user and select **DELETE**. Then one folder up in SQL, select **SECURITY | LOGINS**, right-click on the user and select **PROPERTIES | USER MAPPING**. Give them access to the Company database and the DYNGRP role. It will insert them back into the company users folder again with permissions so they can sign in successfully now.
