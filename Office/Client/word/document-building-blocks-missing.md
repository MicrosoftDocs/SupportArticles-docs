---
title: Document building blocks may be missing
description: This article provides two workarounds to the problem that occurs because the workgroup path for building block templates differs from the path for regular templates.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto: 
- Word 2010
search.appverid: MET150
ms.reviewer: 
author: simonxjx
ms.author: v-six
ms.date: 03/31/2022
---
# Document building blocks may be missing in a template that is part of a workgroup template in Word 2010

## Symptoms

In Microsoft Office Word 2010, document building blocks may be missing in a template that is part of a workgroup template.

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure to back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [Windows registry information for advanced users](/troubleshoot/windows-server/performance/windows-registry-advanced-users).

## Cause

This issue occurs because the workgroup path for building block templates differs from the path for regular templates.

## Workaround

To work around this issue, use one of the following methods:

### Method 1

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall your operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

Use Registry Editor to set the **SharedDocumentParts** key in the following registry subkey to the path of the shared template:

- Office 2010: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\14.0\Common`

To do so, follow these steps:

1. select **Start**, select **Run**, type *regedit*, and then select **OK**.
2. Locate and then select the following key in the registry:

   - Office 2010:`HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\14.0`

3. On the **Edit** menu, point to **New**, and then select **Key**.
4. Type *Common*, and then select **ENTER**.
5. Locate and then select the following key in the registry:

   - Office 2010: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\14.0`

6. On the **Edit** menu, point to **New**, and then select **Key**.
7. Type General, and then select **ENTER**.
8. On the **Edit** menu, point to **New**, and then select **String Value**.
9. On the **Edit** menu, select **Modify**.

10. Type *SharedDocumentParts*, and then select **OK**.

   > [!NOTE]
   > Set the key string value to `\\server\share`.

### Method 2

Turn on the Group Policy to set the shared location for templates. To do this, follow these steps:

> [!NOTE]
> The steps in Method 2 result in the same registry setting as in Method 1.

1. Download and then install the Administrative Templates from the 2010 Office Resource Kit.

2. Copy the *office14.adm* file to the folder: *c:\windows\inf*.

3. Select **Start**, select **Run**, type *gpedit.msc*, and then select **OK**.

4. In the Group Policy Object Editor, right-click **Administrative Templates** under **User Configuration**, and then select **Add/Remove Templates**.

5. In the **Add/Remove Templates** dialog box, select **Add**, for Office 2010 type *c:\windows\inf\office14.adm* in the **File name** box, and then select **Open**.

6. Select **Close** to close the **Add/Remove Templates** dialog box.

7. In the Group Policy Object Editor, expand **Administrative Templates** under **User Configuration**, expand **Microsoft Office 2010 system**, and then select **Shared paths**.

8. In the **Shared Paths** pane, double-click **Workgroup build blocks path**.

9. In the **Workgroup build blocks path** dialog box, on the **Setting** tab, select **Enable** radio-button, and then type location of the building blocks in this format `\\server\share`.

## More information

### Steps to reproduce this issue

To reproduce this issue, follow these steps:

1. Create a template that contains one or more building blocks. To do this, follow these steps:

   1. Start Word 2010.
   2. Select the Microsoft Office Button, and then select **New**.
   3. In the **New Document** dialog box, select **Installed Templates**.
   4. In the Installed Templates pane, double-select a template name.
   5. Select an area of the template in which you will create a building block.
   6. Select the **Insert** tab, select **Quick Parts**, and then select **Save Selection To Quick Part Gallery**.
   7. In the **Create New Building Block** dialog box, type **BuildingBlockName** in the **Name** box.
   8. Select **GalleryName** from the drop-down box for **Gallery**, and then select **CategoryName** from the drop-down box for **Category**.
   9. Select the template name from step d under the **Save** in drop-down box, and then select **OK**.

      > [!NOTE]
      > Repeat steps a to i to store all the building blocks that you want to share.

2. Create a folder structure, such as *\\\server\share*, and then share the folder that you will use for your workgroup location.

3. Copy the template that you created in step 1d to the shared folder that you created in step 2.

4. Set the workgroup templates to the `\\server\share` location. To do this, follow these steps:

   1. Select the Microsoft Office Button or File Tab, and then select **Word Options**.
   2. In the **Word Options** window, select **Advanced**, and then select **File Locations**.
   3. In the **File Locations** dialog box, select **Workgroup templates**, and then select **Modify**.
   4. In the **Modify Location** dialog box, type *\\\server\share* in the **Folder Name** box, and then select **OK**.
   5. Select **OK** to close **File Locations** dialog box.

5. Set Word to trust the location in which templates that contain building blocks are stored. To do this, follow these steps:

   1. Select **Microsoft Office** or **File**, and then select **Word Options**.
   2. In the **Word Options** window, select **Trust Center**, and then select **Trust Center Settings**.
   3. In the **Trust Center** dialog box, select **Trusted Locations**, click to enable **Allow trusted locations on my network (not recommended)**, and then select **Add new location**.
   4. In the **Microsoft Office 2010 Trusted Location** dialog box, type *\\\server\share* in **Path** text box, select to enable **Subfolders of this location are also trusted**, and then select **OK**.
   5. Select **OK** to close the **Trust Center** dialog box.
   6. Select **OK** to close **Word Options**.
