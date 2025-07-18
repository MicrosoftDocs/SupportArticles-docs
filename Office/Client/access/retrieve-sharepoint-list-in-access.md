---
title: Issues when you retrieve SharePoint list data
description: Describes issues that you may encounter when you request data from SharePoint lists in Access, and provide resolutions.
author: Cloud-Writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: meerak
search.appverid: 
  - MET150
appliesto: 
  - Access 2016
  - Access 2013
  - Access 2010
  - Access for Microsoft 365
ms.date: 05/26/2025
---

# Issues when you retrieve SharePoint list data in Access

## Symptoms

When you request data from Microsoft SharePoint lists in Microsoft Access, you may receive one of the following error messages:

- There were errors executing the bulk query or sending data to the server. Reconnect the tables to resolve the conflicts or discard the pending changes.
- All SharePoint tables are disconnected.
- Cannot update. Database or object is read-only.
- The Microsoft Office Access database engine could not find the object '\<linked table name>'. Make sure the object exists and that you spell its name and the path name correctly.
- Linked table '\<linked table name>' is unavailable. Microsoft Access cannot contact the server. Check your network connection or contact the server administrator.
- You do not have the necessary permissions to use the '\<linked table name>' object. Have your system administrator or the person who created this object establish the appropriate permissions for you.

Or, you may experience one of the following issues:

- Access exits unexpectedly or crashes when you try to open a linked table.
- Access appears deadlocked when you try to open a linked table.

## Cause

When Access requests list items from a SharePoint list, Access waits a finite period of time for that data to be returned. Specifically, if Access doesn't receive the data for the given batch after 30 seconds, it aborts the request and may resend the batch as a new request. If Access encounters failures when sending these batches, the program may give up and return an error message.

Some conditions that may cause this issue are:

- There's a problem with the health of the Microsoft SharePoint Server, for example, it runs slowly.
- You have a low-bandwidth connection.
- You have a large or complex SharePoint list or document library.
- There's a long distance between you and the server.
- There are more than 255 columns in the SharePoint list or document library.
- You are throttled when you use SharePoint Online. For more information about throttling in SharePoint Online, see [Avoid getting throttled or blocked in SharePoint Online](/sharepoint/dev/general-development/how-to-avoid-getting-throttled-or-blocked-in-sharepoint-online).

## Resolution

To fix the issue, use one of the following methods:

- Method 1: Reduce the response time by avoiding the conditions that may cause the issues.
- Method 2: Reduce the amount of data requested from the server by using a view in SharePoint and then linking Access to that view.

  For detailed information on how to create a linked table which uses the SharePoint view, see [ImportSharePointList Macro Action](https://support.office.com/article/importsharepointlist-macro-action-f4e107b1-5513-4868-a2d9-42be1d08e7fd?ocmsassetID=HA001226463&ctt=1&CorrelationId=a428142f-dbd9-4c35-b758-2717d8f57de5).
- Method 3: Increase the time-out in Access by adding the DataFetchTimeout registry entry

    > [!IMPORTANT]
    > This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see
    [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

    > [!NOTE]
    > The DataFetchTimeout registry entry originally only applied to read requests when Access synchronizes its cached data with the SharePoint list. Starting in Access 2016 Click-to-Run builds 16.0.9215.5830, this registry entry also applies to Insert, Update, and Delete operations.

### Add the DataFetchTimeout registry entry in Access 2010
  
1. Apply the following hotfix package:

   [Description of the Access 2010 hotfix package (Stslist-x-none.msp): June 28, 2011](https://support.microsoft.com/help/2552989)
2. Open Registry Editor, and then locate and select the following registry subkey:

   **For 32-bit Access on 32-bit Windows or 64-bit Access on 64-bit Windows**

   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\14.0\Access Connectivity Engine\Engines`

   **For 32-bit Access on 64-bit Windows**

   `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\14.0\Access Connectivity Engine\Engines`
3. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
4. Type **DataFetchTimeout**, and then press **Enter**.
5. Right-click **DataFetchTimeout**, and then click **Modify**.
6. Select **Decimal** in **Base**, type **90000** in the **Value data** box, and then click **OK**.

   If the value doesn't fix the issue, try a larger value. DataFetchTimeout is in milliseconds.
7. Exit Registry Editor.

### Add the DataFetchTimeout registry entry in Access 2013

1. Open Registry Editor, and then locate and select the following registry subkey:

   **For 32-bit Access on 32-bit Windows or 64-bit Access on 64-bit Windows**

   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\15.0\Access Connectivity Engine\Engines`

   **For 32-bit Access on 64-bit Windows**

   `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\15.0\Access Connectivity Engine\Engines`
2. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
3. Type **DataFetchTimeout**, and then press **Enter**.
4. Right-click **DataFetchTimeout**, and then click **Modify**.
5. Select **Decimal** in **Base**, type **90000** in the **Value data** box, and then click **OK**.

   If the value doesn't fix the issue, try a larger value. DataFetchTimeout is in milliseconds.
6. Exit Registry Editor.

### Add the DataFetchTimeout registry entry in Access 2016

1. Open Registry Editor, and then locate and select the following registry subkey:

   - For MSI installation of Access

     **For 32-bit Access on 32-bit Windows or 64-bit Access on 64-bit Windows**

     `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\16.0\Access Connectivity Engine\Engines`

     **For 32-bit Access on 64-bit Windows**

     `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\16.0\Access Connectivity Engine\Engines`
   - For Click-to-Run installation of Access

     **For 32-bit Access on 32-bit Windows or 64-bit Access on 64-bit Windows**

     `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Microsoft\Office\16.0\Access Connectivity Engine\Engines`

     **For 32-bit Access on 64-bit Windows**

     `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Wow6432Node\Microsoft\Office\16.0\Access Connectivity Engine\Engines`  
2. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
3. Type **DataFetchTimeout**, and then press **Enter**.
4. Right-click **DataFetchTimeout**, and then click **Modify**.
5. Select **Decimal** in **Base**, type **90000** in the **Value data** box, and then click **OK**.

   If the value doesn't fix the issue, try a larger value. DataFetchTimeout is in milliseconds.
6. Exit Registry Editor.
