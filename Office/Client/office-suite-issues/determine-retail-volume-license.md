---
title: How to determine whether you have a retail edition or a volume license edition of a 2007 or a 2010 Microsoft Office suite
description: Describes how to determine which type of license was used to purchase a 2007 or a 2010 Office suite.
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
appliesto: 
  - Office Home and Business 2010
  - Office Home and Student 2010
  - Office Professional 2010
  - Office Professional Plus 2010
  - Office Standard 2010
ms.reviewer: 
ms.date: 03/31/2022
---
# How to determine the license type for Microsoft Office 2010 and 2007 products

> [!IMPORTANT]
> This article contains information about how to modify the registry. 
> 
> **Make sure that you back up the registry before you modify it.**
> 
> **Make sure that you know how to restore the registry if a problem occurs.**
> 
> For more information about how to back up, restore, and modify the registry, see the following article:
> 
> [256986](https://support.microsoft.com/help/256986) Description of the Microsoft Windows registry

## Introduction

This article describes how to determine whether you have a retail edition or volume license edition of the Microsoft Office 2010 or 2007 suite.

## Methods

To determine whether you have a retail edition or a volume license edition, use one of the following methods.

### Method 1: Examine the contents of the installation disc

1.	Insert the 2010 or 2007 Office suite installation disc into the computer's CD or DVD drive.

    > [!NOTE]
    > If you have multiple discs, use disc 1. In the case of a DVD, the disc must be inserted into a DVD drive.

2.	When the Setup window is displayed, close the window.
3.	Select **Start** > **My Computer**.
4.	Right-click the CD or DVD drive that contains the disc, and then select **Explore**.
5.	Look for a folder that is named Admin.
    - If the Admin folder exists, this disc is a volume license (VL) edition.
    - If the Admin folder does not exist, this disc is a retail edition.

    > [!NOTE]
    > Retail media includes a lowercase "r" before the ".WW" in the folder name and before the "WW.msi" in the msi file name. For example, Enterprise retail would be Enterprise**r**WW.msi in the Enterprise**r**.WW folder. Enterprise non-retail would be EnterpriseWW.msi in the Enterprise.WW. 

### Method 2: Examine the registry on the computer

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

1.	On a computer that has Office 2010 or 2007 installed, select **Start**, select **Run**, type **regedit**, and then select **OK**. 

    > [!note]
    > If you are running Windows 7, we recommend that you run Registry Editor in Administrator mode. To do that in Windows 7, follow these steps:
    > 1. Select Start and type **cmd**.
    > 2. Right-click **Command Prompt** in the results list, and then select **Run as Administrator**.
    > 3. Type **Regedit**, and press Enter.

2.	Locate and then select the following registry subkey:
    **`HKEY_LOCAL_MACHINE\Software\Classes\Installer\Products`**
3.	In the navigation area on the left side, expand the **Products** entry node, and then select each 32-character {GUID} until you locate the one whose **ProductName** value in the topic area matches your version of the 2010 or 2007 Office suite. For example, the 32-character {GUID} for Microsoft Office Professional Plus 2010 appears as follows: 

    `{BRMMmmmm-PPPP-LLLL-p000-D000000FF1CE}`

    The 32-character {GUID} for Microsoft Office Professional Plus 2007 appears as follows:

    `00002103110000000000000000F01FEC`

4.	Expand the selected 32-character GUID entry.
5.	Select the **SourceList** entry.
6.	In the topic area, examine the data for the **PackageName** string value.
    - If the data here contains the letter "r" before "WW," this is a retail edition of Office. For example, you may see **ProrWW.msi** or **StandardrWW.msi**.
    - If the string value does not contain the letter "r" before "WW," this is a volume license edition of Office. For example, you may see **ProWW.msi** or **StandardWW.msi**, depending on which version of Office (Professional or Standard) you have installed. 
7.	Exit Registry Editor.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).