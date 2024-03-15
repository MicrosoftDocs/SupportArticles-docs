---
title: Unable to export to Excel from SharePoint Online
description: Export to excel from SharePoint Online doesn't work, An unexpected error has occurred. Changes to your data cannot be saved. error returned.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Excel
ms.date: 03/31/2022
---

# Unable to export to Excel from SharePoint Online

## Symptoms

When you use the **Export to Excel** button in Microsoft SharePoint Online, Excel starts and shows the following error message:

> An unexpected error has occurred. Changes to your data cannot be saved.  

## Cause

Excel has a 55-second timeout when fetching data from SharePoint.Therefore, you may receive the error message when the timeout of this client is exceeded. 

## Resolution

You can increase the default Excel timeout value by using a registry key. To increase the Excel timeout value, follow these steps:

1. Open Registry Editor. Locate and select the following registry subkey:  
      - For an MSI installation of Excel

        **For 32-bit Excel on 32-bit Windows or 64-bit Excel on 64-bit Windows**

        `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\16.0\Access Connectivity Engine\Engines`

        **For 32-bit Excel on 64-bit Windows**

        `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\16.0\Access Connectivity Engine\Engines`

      - For Click-to-Run installation of Excel

        **For 32-bit Excel on 32-bit Windows or 64-bit Excel on 64-bit Windows**  

        `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Microsoft\Office\16.0\Access Connectivity Engine\Engines`

        **For 32-bit Excel on 64-bit Windows**

        `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Wow6432Node\Microsoft\Office\16.0\Access Connectivity Engine\Engines`

2. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
3. Type **DataFetchTimeout**, and then press **Enter**.
4. Right-click **DataFetchTimeout**, and then select **Modify**.
5. Select **Decimal** for **Base**, type **90000** in the **Value data** box, and then select **OK**.

    > [!NOTE]
    > If the new value doesn't resolve the issue, try a larger value. **DataFetchTimeout** is in milliseconds.

6. Exit Registry Editor.
