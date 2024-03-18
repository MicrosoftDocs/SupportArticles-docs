---
title: ODBC Data Source Administrator crashes when you add a system DSN
description: Discusses a problem in which the ODBC Data Source Administrator crashes when you add a system DSN. Provides a workaround.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Access 2016
ms.date: 03/31/2022
---

# ODBC Data Source Administrator crashes when you add a system DSN

## Symptoms

Consider the following scenario:
- You're using a physical computer that has Microsoft Access Database Engine 2016 installed.    
- Hardware acceleration is enabled.    
- The version of ACEODBC.dll is 16.0.4378.1000 ([KB3114378](https://support.microsoft.com/help/3114378)) or a later version.    
- In the Microsoft Open Database Connectivity (ODBC) Data Source Administrator (Odbcad32.exe), you add a system Data Source Name (DSN) that uses a Microsoft Access driver (*.mdb or *.accdb).    

In this scenario, Odbcad32.exe crashes.  

## Workaround

To work around this problem, disable hardware acceleration by using the **DisableHardwareAcceleration** registry key, as follows. 

> [!NOTE]
> This issue has been reported and is being investigated. We recommend that you use the registry key only to disable the hardware acceleration during the DSN creation, and that you re-enable hardware acceleration at your earliest convenience.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756)in case problems occur. 

1. Exit all Microsoft Office applications.    
2. Start Registry Editor:  
      - **Windows 10:** Go to **Start**, type **regedit** in the **Search** box, and then select **regedit.exe** in the search results.    
      - **Windows 8 or Windows 8.1:** Move your mouse to the upper-right corner, select **Search**, type **regedit** in the search text box, and then select **regedit.exe** in the search results.    
      - **Windows 7:** Select **Start**, type **regedit** in the **Start Search** box, and then select **regedit.exe** in the search results.
3. Locate and then select the following registry subkey:

   **HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Graphics\DisableHardwareAcceleration**

4. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
5. Enter **DisableHardwareAcceleration**, and then press Enter.    
6. In the **Details** pane, press and hold (or right-click) **DisableHardwareAcceleration**, and then select **Modify**.    
7. In the **Value data** box, enter **1**, and then select **OK**. 
8. Exit Registry Editor.
