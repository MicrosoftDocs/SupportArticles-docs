---
title: Policy to control PST use and creation in Microsoft Outlook
description: Describes how to use Outlook policy to prevent users from adding new items to a .pst file and to prevent users from creating new .pst files.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2013
  - Outlook 2010
  - Outlook 2007
ms.date: 05/18/2023
ms.reviewer: v-six
---

# How to implement a policy to control PST use and creation in Microsoft Outlook

## Introduction

In Microsoft Outlook, users can create PST files or add new items to existing PST files. This article describes how to control these behaviors as an administrator.

## Procedure

> [!IMPORTANT]
> Follow the steps in this article carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

### Prevent users from adding new data or content to an existing .pst file

To prevent users from adding new data or content to an existing .pst file, add the `PSTDisableGrow` registry entry, and then set the value to **1**. To do this, follow these steps:

1. Open Registry Editor.
1. Locate and select the following registry subkey. You have to create the key if it does not exist.

   |Type|Registry path|
   |-|-|
   |Group Policy|`HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\xx.0\Outlook\PST`|
   |Office Customization Tool (OCT)|`HKEY_CURRENT_USER\Software\Microsoft\Office\xx.0\Outlook\PST`|
   
   > [!NOTE]
   > The *xx*.0 placeholder represents the Outlook version (16.0 = Outlook 2016 and Outlook for Microsoft 365, 15.0 = Outlook 2013, 14.0 = Outlook 2010, 12.0 = Outlook 2007).

1. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
1. Type `PSTDisableGrow`, and then press Enter.
1. Right-click the `PSTDisableGrow` registry entry that you created, and then select **Modify**.
1. In the **Value data** box, type **1**, and then select **OK**.

The `PSTDisableGrow` registry entry can be set to the following values.

|Value|Description|
|-|-|
|0|User can add new items to an existing .pst file. This is the default value.|
|1|Use cannot add new content or data to an existing .pst file.|

### Prevent users from adding new .pst files

To prevent users from connecting a .pst file to Outlook, add the `DisablePST` registry entry, and then set the value to **1**. To do this, follow these steps:

1. Open Registry Editor.
1. Locate and select the following registry subkey. You have to create the key if it does not exist.

   |Type|Registry path|
   |-|-|
   |Group Policy|`HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\xx.0\Outlook`|
   |Office Customization Tool (OCT)|`HKEY_CURRENT_USER\Software\Microsoft\Office\xx.0\Outlook`|
   
   > [!NOTE]
   > The *xx*.0 placeholder represents the Outlook version (16.0 = Outlook 2016 and Outlook for Microsoft 365, 15.0 = Outlook 2013, 14.0 = Outlook 2010, 12.0 = Outlook 2007).

1. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
1. Type `DisablePST`, and then press Enter.
1. Right-click the **DisablePST** registry entry that you created, and then select **Modify**.
1. In the **Value data** box, type **1**, and then select **OK**.

The `DisablePST` registry entry can be set to the following values.

|Value|Description|
|-|-|
|0|Users can add .pst files. This is the default value.|
|1|Users cannot add .pst files. However, in scenarios in which a .pst file was connected to Outlook before this registry value was added, the existing .pst file will still be connected. No new.pst files can be added.|
|2|Users can add only exclusive sharing .pst files, such as SharePoint .pst files.|

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
