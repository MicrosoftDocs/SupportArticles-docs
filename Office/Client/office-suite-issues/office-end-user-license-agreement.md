---
title: Office End User License Agreement always appears
description: Discusses the behavior where you must accept the Office End User License Agreement every time that you start an Office  program.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Open
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: V-ChaseC
appliesto: 
  - Office 2010
ms.date: 06/06/2024
---

# You must accept the Office End User License Agreement every time that you start an Office program

## Symptoms

Every time that you start a Microsoft Office program, such as Microsoft Office Word, the **End User License Agreement** dialog box appears. If you click **I Accept**, the **End User License Agreement** dialog box disappears and then reappears. If you click **I Accept** again, the **End User License Agreement** dialog box disappears, and the Office program functions as expected.

This behavior occurs for every Office program that you start.

## Cause

This behavior occurs if your user account does not have permissions to modify the Microsoft Windows Registry.

## Resolution

To resolve this behavior, follow these steps:

1. Log on to the computer by using a user account that has administrative credentials.    
2. Start an Office program, such as Word. The **End User License Agreement** dialog box appears.

   **Note** For Windows Vista, click **Start**, click **All Programs**, click **Microsoft Office**, right-click an Office program, click **Run as administrator**, and then click **Continue**.    
3. Click **I Accept**.   
4. Exit the Office program that you just started.   
5. Repeat step 2 to step 4 for the other Office programs that still prompt you with the EULA.    

## Workaround

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To work around this behavior, follow these steps: 

1. Log on to the computer by using an Administrator user account.    
2. If you are using Microsoft Windows XP, click **Start**, click **Run**, type regedit, and then click **OK**. 

   **Note** In Windows Vista and Windows 7, you may receive a **User Account Control** (UAC) dialog box. You must click **Continue** to open Registry Editor.   
3. Locate and then right-click the following registry subkey as appropriate.

   On 32-bit versions of Windows:
   
   **HKEY_LOCAL_MACHINE\Software\Microsoft\Office\14.0**   
    
   On 64-bit versions of Windows:
 
   **HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Office\14.0**   
  
4. Click **Permissions**. 

   :::image type="content" source="media/office-end-user-license-agreement/select-permission.png" alt-text="Screenshot to select Permissions in Registry Editor.":::
5. Click **Users (Computer_name\Users)**, and then click to select the **Allow** check box for the **Full Control** permission. 

    :::image type="content" source="media/office-end-user-license-agreement/allow-full-control.png" alt-text="Screenshot shows steps to give the Users Full Control permission.":::

6. Click **OK**, and then quit Registry Editor.

7. Start an Office program, and then accept the End User License Agreement.   

8. Repeat steps 2 through 4, and then remove the **Full Control** permission that you gave to **Users (Computer_name\Users)** in step 5. To do this, locate **Users (Computer_name\Users)**, and then click to clear the **Allow** check box for the **Full Control** permission.    
9. Click OK, and then exit Registry Editor.
