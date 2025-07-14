---
title: Can't process transactions in multi-user environment
description: Describes the File sharing lock count exceeded error that occurs when one or more users process many transactions in a multi-user environment and provides workarounds.
author: helenclu
manager: dcscontentpm
ms.custom: 
  - CI 111294
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Access for Microsoft 365
  - Access LTSC 2021
  - Access 2019
  - Access 2016
  - Access 2013
ms.date: 05/26/2025
---

# "File sharing lock count exceeded…" error during large transaction processing

## Symptoms

When one or more users process many transactions in a multi-user environment, the transactions may fail with the following error message:

**File sharing lock count exceeded. Increase MaxLocksPerFile registry entry.**

## Cause

The error occurs if the number of locks required to perform a transaction exceeds the maximum number of locks per file.

## Workaround

Important This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:

[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

To work around this problem, increase the maximum number of locks per file. To do this, use one of the following methods.

### Method 1: Set the registry key to MaxLocksPerFile to increase the maximum number of locks per file

1. Click **Start**, and then click **Run**.
2. Type `regedit`, and then click **OK**.
3. Locate the following registry key depending on your Access installation:

   **Windows Installer (MSI) installation**

    - For 32-bit version of Access running on 32-bit version of Windows, or 64-bit version of Access running on 64-bit version of Windows

      `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\<x.0>\Access Connectivity Engine\Engines\ACE`

    - For 32-bit version of Access running on 64-bit version of Windows

      `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\<x.0>\Access Connectivity Engine\Engines\ACE`

   **Click-to-Run installation**

     - For 32-bit version of Access running on 32-bit version of Windows, or 64-bit version of Access running on 64-bit version of Windows

       `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Microsoft\Office\<x.0>\Access Connectivity Engine\Engines\ACE`

     - For 32-bit version of Access running on 64-bit version of Windows

       `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Wow6432Node\Microsoft\Office\<x.0>\Access Connectivity Engine\Engines\ACE`

     > [!NOTE]
     > The \<x.0> placeholder represents your version of Office (16.0 = Office 2016, Office 2019, Office LTSC 2021, or Microsoft 365, 15.0 = Office 2013).

4. In the right pane of Registry Editor, double-click **MaxLocksPerFile**.
5. On the **Edit DWORD Value** dialog box, select **Decimal**.
6. Modify the value of the **Value data** box as required, and then select **OK**.

**Note** that this method changes the registry setting for all applications that use Microsoft Jet database engine version 4.0.

### Method 2: Use the SetOption method to temporarily change MaxLocksPerFile

> [!NOTE]
> The sample code in this article uses Microsoft Data Access Objects. For this code to run correctly, you must reference the Microsoft DAO 3.6 Object Library. To do so, click **References** on the **Tools** menu in the Visual Basic Editor, and make sure that the **Microsoft DAO 3.6 Object Library** check box is selected.

The SetOption method temporarily overrides the default number of locks per file. You set the default number of locks per file when you set the MaxLocksPerFile registry key. You set the new value by using the SetOption method. The new value is valid until you close the DBEngine object. To use Method 2, follow these steps:

1. Open Microsoft Access.
2. Open a database, and then press Alt+F11 to launch the Visual Basic editor.  
3. On the **Microsoft Visual Basic -\<Database Name>-[\<Module Name> (Code)]** window, select **Immediate Window** in the **View** menu.
4. In **Immediate Window**, enter the following code:

   `DAO.DBEngine.SetOption dbmaxlocksperfile,15000`
  
5. Press the ENTER key to run the line of code. This command temporarily sets the MaxLocksPerFile value to 15,000.

To process large transactions, set the MaxLocksPerFile value to meet your requirement, and then run the transactions in the session.

Changes you make to the MaxLocksPerFile setting by using the SetOption method are available only for the current session.

## More information

The MaxLocksPerFile setting determines the maximum number of locks Microsoft Jet places against a file. The default MaxLocksPerFile value is 9,500. However, don't change this value if you're working on a Novell NetWare server, because the maximum server record locks per connection is 10,000.
