---
title: Prevent Office 2010 from disabling printers
description: Provides a method to prevent Office 2010 from disabling printers when Office 2010 detects the problems with printers.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
ms.reviewer: jgordner, sfrancis, sloanc, andyfel, djess, arykhus, mosesma, ryanwei, tomol
appliesto: 
  - Office 2010
ms.date: 03/31/2022
---

# How to prevent Office 2010 from disabling printers

## Introduction

This article introduces a method to prevent Microsoft Office 2010 from disabling printers when Office 2010 detects the problems with printers.

## More Information

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

If Office 2010 detects there is a problem with a printer, some printing features or the printer may be disabled. In this case, you cannot use the disabled printers to print documents anymore.

To prevent Office 2010 from disabling printers, set the DisablePrintFeaturesOnCrash registry entry. To do this, follow these steps: 

1. Start Registry Editor.   
2. Click **Start**, type **regedit** in the **Start Search** box, and then press **ENTER**.

    **Note** If you are prompted for an administrator password or for confirmation, type the password or provide confirmationI.    
3. Locate and then click the following registry subkey: 
 
    HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\General    
4. On the **Edit** menu, point to **New**, and then click **DWORD Value**.   
5. Type **DisablePrintFeaturesOnCrash**, and then press **ENTER**.   
6. Right-click **DisablePrintFeaturesOnCrash**, and then click **Modify**.   
7. In the **Value data** box, type 0, and then click **OK**.   
8. Exit Registry Editor.   

Administrator can deploy the Print ticket safe mode Group Policy setting to prevent Office 2010 from disabling printers. The Print ticket safe mode Group Policy setting is included in Office 2010 Administrative Template file. To obtain Office 2010 Administrative Template file, visit the following Microsoft website:

[Download the Office 2010 Administrative Template file](https://www.microsoft.com/download/details.aspx?familyid=64b837b6-0aa0-4c07-bc34-bec3990a7956)

For more information about new printing functionalities in Microsoft Office, visit the following Microsoft website:

[Improved End-User Experience](https://msdn.microsoft.com/library/ff551567%28vs.85%29.aspx)
