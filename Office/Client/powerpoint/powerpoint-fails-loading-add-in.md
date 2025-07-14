---
title: PowerPoint cannot load an add-in when you lower macro security level
description: Describes an issue in which PowerPoint can't load an add-in when you lower the level of macro security.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Extensibility\AddIns
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Microsoft PowerPoint
ms.date: 06/06/2024
---

# PowerPoint cannot load an add-in when you lower the macro security level

## Symptoms

When you lower the level of macro security in Microsoft PowerPoint, and then open a PowerPoint add-in file (*.ppa), the new level of macro security may not be applied, and the add-in file may not run as expected. The add-in is listed as an available add-in in the Add-Ins dialog box, but the check box is not selected, and you receive an error message similar to the following when you attempt to select the check box:

> PowerPoint couldn't load the add-in *file name*.

## Cause

This behavior can occur if the following conditions are true:

1. You attempt to open a PowerPoint add-in file by using the Open command on the File menu while the macro security level is set to High.
2. You lower the macro security-level setting.
3. You open the same PowerPoint add-in file by using the Open command on the File menu.

When you attempt to open an add-in file, and the add-in is not loaded because of macro security, PowerPoint temporarily stores (caches) the failure-to-load information about this add-in. PowerPoint cannot load the add-in after you lower the macro security level until it clears the cached information.

## Workaround

To work around this issue, clear the cached information, and then load the add-in by following either of the following methods after you change the macro security-level setting.

### Method 1: Quit and Restart PowerPoint

1. Quit PowerPoint.
2. Restart PowerPoint.
3. Open the add-in file.
4. Click "I AGREE" to load the add-in.

### Method 2: Remove and Add the Add-in

To remove and add the add-in in PowerPoint 2002, follow these steps:

1. On the Tools menu, click Add-Ins.
2. In the Available Add-Ins list, click the add-in, and then click Remove.
3. Click Add New, select the add-in, click OK, click "I AGREE" to load the add-in, and then click Close.

To remove the add-in in PowerPoint 2007, follow these steps:

1. Click the **Microsoft Office Button**, click **PowerPoint Options**, and then click **Add-Ins**.
2. In the **Manage** list, select **PowerPoint Add-ins**, and then click **Go**.
3. In the **Available Add-Ins** list, select the add-in that you want to remove, click **Remove**, and then click **Close**.

To add the add-in in PowerPoint 2007, follow these steps:

1. Click the **Microsoft Office Button**, click **PowerPoint Options**, and then click **Add-Ins**.
2. In the **Manage** list, click **PowerPoint Add-ins**, and then click **Go**.
3. In the **Add-Ins** dialog box, click **Add New**.
4. In the **Add New PowerPoint Add-In** dialog box, browse for the add-in that you want to add, and then click **OK**.
5. A security notice appears. If you are sure that the add-in comes from a trusted source, click **Enable Macros**, and then click **Close**.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

### Steps to Reproduce the Problem

#### PowerPoint 2007

1. Start PowerPoint 2007.
1. On the **Developer** tab, click **Macro Security** in the **Code** group.

   > [!NOTE]
   > By default, the **Developer** tab may not appear. To display the **Developer** tab, click the **Microsoft Office Button**, click **PowerPoint Options**, select **Show Developer tab in the Ribbon** under **Top options for working with PowerPoint**, and then click **OK**.

1. On the **Trust Center** page, under **Macro Settings**, select **Disable all macros with notification**, and then click **OK**.
1. On the **Office** menu, click **Open**.
1. In the **Files of type** drop-down box, click the arrow, select **PowerPoint Add-Ins(*.ppam;*.ppa)**, select the add-in, and then click Open.

   > [!NOTE]
   > The add-in does not load as expected.

1. On the **Developer** tab, click **Macro Security** in the **Code** group.
1. On the **Trust Center** page, select **Enable all macros (not recommended; potentially dangerous code can run)** under **Macro Settings**, and then click **OK**.
1. On the **Office** menu, click **Open**.
1. In the **Files of type** drop-down box, click the arrow, select **PowerPoint Add-Ins(*.ppam;*.ppa)**, select the add-in, and then click Open.

   > [!NOTE]
   > You are not prompted to enable or disable the macro. Additionally, the add-in still does not load.

#### PowerPoint 2002

1. Start PowerPoint.
1. On the Tools menu, point to Macro, and then click Security.
1. On the Security Level tab, click High.
1. On the File menu, click Open.
1. In the **Files of type** box, click the arrow, select PowerPoint Add-Ins, select the add-in, and then click Open.

   > [!NOTE]
   > The add-in does not load as expected.

1. On the Tools menu, point to Macro, and then click Security.
1. On the Security Level tab, click Medium.
1. On the File menu, click Open.
1. In the **Files of type** box, click the arrow, select PowerPoint Add-Ins, select the add-in, and then click Open.

   > [!NOTE]
   > You are not prompted to enable or disable the macro, and the add-in still does not load.
