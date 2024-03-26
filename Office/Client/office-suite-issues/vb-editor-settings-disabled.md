---
title: Some settings for VB Editor disabled in Office 2010
description: Describes a problem in which some settings for the Visual Basic Editor that you enabled in an earlier version of an Office application are not enabled in Office 2010. Provides a workaround.
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
ms.reviewer: tputt, gregli, brreich, sloanc, djess, andyfel
appliesto: 
  - Office 2010
ms.date: 03/31/2022
---

# Some settings for the Visual Basic Editor that you enabled in an earlier version of an Office application are disabled in Office 2010

## Symptoms

Consider the following scenario. You create a file in a 2007 Microsoft Office application or in an earlier version of the application. You notice that some settings for the Microsoft Visual Basic Editor are enabled in the application, such as the Require Variable Declaration option and the Compile on Demand option. When you open the file in a Microsoft Office 2010 application, these settings are disabled.

## Cause

This problem occurs because Visual Basic for Applications (VBA) is upgraded to version 7.0 in Microsoft Office 2010. Therefore, the registry entries that correspond to the settings for the Visual Basic editor are located under a different subkey. In Office 2010, the registry entries are located under the following subkey: 

**HKEY_CURRENT_USER\Software\Microsoft\VBA\7.0\Common** 

In earlier versions of Office, the registry entries are located at the following subkey:

**HKEY_CURRENT_USER\Software\Microsoft\VBA\6.0\Common**

## Workaround

To work around this problem, enable the settings manually. To do this, use one of the following methods:

### Method 1

1. Start an Office 2010 application.   
2. On the **Developer** tab, click **Visual Basic**.

    If you start Microsoft Access 2010, click **Visual Basic** on the **Database Tools** tab.   
3. On the **Tools** menu, click **Options**.   
4. In the **Options** dialog box, select any option that you want to enable, and then click **OK**.   

### Method 2

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756). 

1. Click **Start**, click **Run**, type regedit, and then click **OK**.   
2. Locate the following registry subkey:

   **HKEY_CURRENT_USER\Software\Microsoft\VBA\6.0\Common**   
3. On the **File** menu, click **Export**.   
4. In the **Export Registry File** dialog box, select a path and a name for the exported file.   
5. Make sure that the **Selected branch** option is enabled, and then click **Save**.   
6. Open the exported file in Notepad.   
7. Locate the following string: 
   
   [HKEY_CURRENT_USER\Software\Microsoft\VBA\6.0\Common]
   
   Then, change this string to the following:

   [HKEY_CURRENT_USER\Software\Microsoft\VBA\7.0\Common]   
8. Save and then close the file in Notepad.   
9. In Registry Editor, click **Import** on the **File** menu.   
10. In the **Export Registry File** dialog box, select the file that you just saved, and then click **Open**.   
11. Click **OK**.   

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## More Information

To make the **Developer** tab appear in the ribbon of certain Microsoft Office 2010 applications, follow these steps:

1. On the **File** tab, click **Options**.   
2. On the **Customize Ribbon** tab, click to select the **Developer** check box under the **Customize the Ribbon** section, and then click **OK**.   
