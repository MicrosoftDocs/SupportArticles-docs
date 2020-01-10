---
title: Linked table connection failed when using Azure AD interactive authentication
description: You experience repetitive connection failed messages when opening objects that use an Access linked table connection.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Access for Office 365
- Access 2019
- Access 2016
- Access 2013
---

# Access: Linked table "connection failed" messages when using Azure AD interactive authentication

## Symptoms

In Microsoft Access, you create a linked table that uses Azure Active Directory interactive authentication. When you open objects that use this connection, you experience repetitive "connection failed" messages that resemble the following:

```adoc     
Connection failed: SQLState: 'FA003' SQL Server Error: 0 [Microsoft][ODBC Driver 17 for SQL Server][SQL Server] User option must be specified, if Authentication option is 'ActiveDirectoryInteractive'.     
```

After you receive these messages, you are prompted to sign in. 

## Cause

When you establish the connection in Access, the **Save Password** option is not selected. Therefore, the connection string that is stored in Access is missing the user ID (UID). 

> [!NOTE]
> Although the option is labeled as **Save Password**, selecting this option stores both the UID and PWD (if it exists) in the connection string. 

## Resolution

In this situation, Azure Active Directory (Azure AD) interactive authentication doesn't use a stored password. However, you should select the **Save Password** option to store the UID in the connection string. 

## More Information

If you create the linked table through DAO in Visual Basic for Applications (VBA), you should specify the **Save Password** option as a table attribute, as follows:

```vb
td.Attributes = dbAttachSavePWD
```

For more information about the **dbAttachSavePWD** attribute, see [TableDefAttributeEnum enumeration (DAO)](https://docs.microsoft.com/office/client-developer/access/desktop-database-reference/tabledefattributeenum-enumeration-dao).
