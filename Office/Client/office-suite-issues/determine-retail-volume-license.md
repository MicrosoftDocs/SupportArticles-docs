---
title: How to determine whether you have a retail edition or a volume license edition of a 2007 or a 2010 Microsoft Office suite
description: Describes how to determine which type of license was used to purchase a 2007 or a 2010 Office suite.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: troubleshoot
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Office Home and Business 2010
- Office Home and Student 2010
- Office Professional 2010
- Office Professional Plus 2010
- Office Standard 2010
ms.reviewer: 
---
# How to determine whether you have a retail edition or a volume license edition of a 2007 or a 2010 Microsoft Office suite

This article describes how to determine whether you have a retail edition or a volume license edition of a 2007 or a 2010 Microsoft Office suite.

_Original KB number:_ &nbsp; 931401

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, select the following article number to view the article in the Microsoft Knowledge Base:  
[256986](https://support.microsoft.com/help/256986) Description of the Microsoft Windows registry  

To determine whether you have a retail edition or a volume license edition, use one of the following methods.

## Method 1: Examine the contents of the installation disc

1. Insert the 2007 or 2010 Office suite installation disc into the computer's CD/DVD drive.

    > [!NOTE]
    > If you have multiple discs, use disc 1. In case of a DVD , the disc must be inserted into a DVD drive.

1. When the Setup window is displayed, close the Setup window.
1. Select Start, and then select My Computer.
1. Right-click the CD /DVD drive that contains the disc, and then select Explore.
1. Look for a folder that is named Admin.

    - If the Admin folder exists, this disc is a volume license edition (VL).
    - If the Admin folder does not exist, this disc is a retail edition.

    > [!NOTE]
    > Retail media includes a lowercase "r" before the ".WW" in the folder name and before the "WW.msi" in the msi file name. For example, Enterprise retail would be EnterpriserWW.msi in the Enterpriser.WW folder. Enterprise non-retail would be EnterpriseWW.msi in the Enterprise.WW.

## Method 2: Examine the registry on the computer

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

1. On a computer that has Office 2007 or 2010 installed, select **Start**, select **Run**, type
**regedit**, and then select **OK**.

   > [!NOTE]
   > If you are running Windows 7, it is recommended that you use regedit in Administrator mode.

   To do that in Windows 7:

   1. Select on start and type **cmd**.
   1. Right-click on Command Prompt and select on **Run as Administrator**.
   1. Now type **Regedit** and press Enter.

1. Locate and then select the following registry subkey:

    `HKEY_LOCAL_MACHINE\Software\Classes\Installer\Products`

1. In the navigation area on the left-hand side, expand the Products entry node, and then select each 32-character {GUID} until you locate the one whose ProductName value in the topic area matches your version of the 2007 or 2010 Office suite. For example, the 32-character {GUID} for Microsoft Office Professional Plus 2007 appears as follows:

    `00002103110000000000000000F01FEC`

    And appears based on the format that follows for Microsoft Office 2010:

    `{BRMMmmmm-PPPP-LLLL-p000-D000000FF1CE}`

1. In the topic area, examine the data for the PackageName string value.

    - If the data here contains the letter "r" before "WW," this is a retail edition of Office.
    For example, you may see "ProrWW.msi" or as "StandardrWW.msi".
    - If the data does not contain the letter "r" before "WW," this is a volume license edition of Office. For example, you may see "ProWW.msi" or as "StandardWW.msi". based on which version of Office you have. For example, Professional or Standard.

1. Exit Registry Editor.
