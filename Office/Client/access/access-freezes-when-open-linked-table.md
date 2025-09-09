---
title: Access freezes when you open a linked table to a SharePoint list
description: Describes an issue in which Microsoft Access hangs when you open a linked table to a SharePoint list.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: suesch
search.appverid: 
  - MET150
appliesto: 
  - Access 2016
  - Access 2013
  - Access for Microsoft 365
  - Access 2019
ms.date: 05/26/2025
---

# Access freezes when you open a linked table to a SharePoint list

## Symptoms

In a Microsoft Access desktop database, when you try to open a table that's linked to a SharePoint list, Access stops responding. 

## Cause

The issue occurs when the user who tries to open the existing linked table in Access doesn't have locally stored credentials for the SharePoint site that contains the list. A stored credential may be either a credential in Windows Credential Manager or a persistent cookie in Internet Explorer. 

## Resolution

To work around this issue, use one of the following methods.

### Method 1: Add the EnableLegacyListAuth registry entry

**Note** For Access 2016, you must have Click-to-Run version 1804 (build 9226.2114) or MSI version (build 16.0.4690.1000) or a later version installed to use this method. 
To add the **EnableLegacyListAuth** registry entry, follow these steps: 
 
1. Open Registry Editor, and then locate and select the following registry subkey:

   **For 32-bit Office on 32-bit Windows or 64-bit Office on 64-bit Windows**

   - For Access 2013

    HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\15.0\List    
   - For Access 2016

    HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\16.0\List    
 
   **For 32-bit Office on 64-bit Windows**

   - For Access 2013

     HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\15.0\List
   - For Access 2016

     HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\16.0\List    

2. On the **Edit** menu, point to **New**, and then click **DWORD Value**.    
3. Type **EnableLegacyListAuth**, and then press **Enter**.    
4. Right-click **EnableLegacyListAuth**, and then click **Modify**.    
5. In the **Value data** box, type **1**, and then click **OK**.    
6. Locate the following registry key:  
   - For Access 2013

     HKCU\SOFTWARE\Microsoft\Office\15.0\Common\Identity    
   - For Access 2016

     HKCU\SOFTWARE\Microsoft\Office\16.0\Common\Identity    
     
7. Make sure that the value of **EnableADAL** is **0**.    
8. Exit Registry Editor.

### Method 2: Refresh the list

To refresh the list, follow these steps: 
 
1. Open Windows Task Manager, select Microsoft Access, and then click **End task**.    
2. Reopen the database.    
3. Right-click the linked table in Access, and then select **More Options** > **Refresh List**.    
4. Log on by using your credentials.    
 
### Method 3: Programmatically relink the list

To relink the list, follow these steps: 
 
1. Open Windows Task Manager, select Microsoft Access, and then click **End task**.    
2. Reopen the database, and create a new module.    
3. In VBA code, use the **RefreshLink** method of the TableDefs collection for the linked tables:

```vb
Public Function TableRelinkSample()
           CurrentDb.TableDefs("<TableName>").RefreshLink
     End Function
```

**Note** If you have multiple linked SharePoint lists, you have to call **RefreshLink** only one time for any one of the tables.

4. Call the **TableRelinkSample()** function from the AutoExec macro or other startup code in the database.

   [TableDef.RefreshLink Method (DAO)](https://msdn.microsoft.com/library/office/ff198349.aspx)
