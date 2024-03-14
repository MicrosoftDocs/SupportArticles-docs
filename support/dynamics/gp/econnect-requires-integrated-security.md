---
title: eConnect requires Integrated Security
description: Provides a solution to an error that occurs when you use eConnect version 8.x.x.x.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# eConnect requires Integrated Security

This article provides a solution to an error that occurs when you use eConnect version 8.x.x.x.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 883895

## Symptoms

When you use eConnect version 8.x.x.x, you receive the following error message:

> Version=8.0.0.0  
Unique MessageId =  
Error Number = 1010  
Error Description = Integrated Security is required.  
Please ensure that the ConnectionString input parameter is valid.  
Example: Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist  Security Info=False;Initial Catalog=TWO;Data  Source=MySQLServerName  
Error Source = ExecProcsXML.ExecStoredProc  
Line Number=1120

## Cause

eConnect requires Integrated Security when it calls the eConnect8.dll file (COM object) and the Microsoft.GreatPlains eConnect.dll file (.NET assembly). If eConnect hasn't been configured in the connection string that eConnect is using, you may receive the error message that is mentioned in the [Symptoms](#symptoms) section. If you're testing an XML document by using the eConnect Document Sending Utility, you must configure the connection string to use Integrated Security.

## Resolution

To enable Integrated Security, add a domain account to the SQL Server that you use to communicate with the eConnect objects. The sign-in must have access to the Dynamics database and to the Company database. Additionally, the sign-in must be a part of the database role in DYNGRP.

There are two other options for the eConnect Document Sending Utility. The first is to manually change the connection string so that it appears like the following example:
`Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=True;;Initial Catalog=MyDB;Data Source=MySQLServerName`

The second is to make a change when you set up the connection string in the Data Links Properties window. To do it, follow these steps:

1. In the Data Links Properties window, select the ellipse that is next to the **Connection String** field.
2. Select the SQL Server name, and then select **Use Windows NT Integrated security**.
3. Select the database where the XML Document will be integrated, and then select **OK**.

You can now use the eConnect Document Sending Utility to test XML documents with the COM object.

## More information

Versions of eConnect that are earlier than eConnect 8.0 don't require Integrated Security.
