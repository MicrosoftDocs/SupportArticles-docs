---
title: Cannot insert certain scriptable ActiveX controls
description: Describes and provides a workaround for an issue in which you cannot insert certain scriptable ActiveX controls into Office 2013 documents.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: anitao, jenl, tomol, dkuy
search.appverid: 
  - MET150
appliesto: 
  - Office 2013
ms.date: 03/31/2022
---

# Cannot insert certain scriptable ActiveX controls into Office 2013 documents

> [!NOTE]
> Information the user should notice even if skimmingImportant This article contains information that shows how to reduce security settings or turn off security features on a computer. You can perform these changes to work around a specific problem. Before you make these changes, we recommend that you evaluate the risks that are associated with implementing this workaround in your environment. If you implement this workaround, take appropriate additional steps to help protect the computer.

## Symptoms

When you try to insert a Web Browser control into a Microsoft Word document, a Microsoft Excel workbook, or a Microsoft PowerPoint Presentation, you receive one of the following error messages:

- In Excel 2013: "Cannot insert object"   
- In Word 2013: "This object cannot be inserted due to your policy settings. This error might occur if ActiveX controls or embedded objects in this file are blocked by policy settings. More information about this error message online"   
- In PowerPoint 2013: "This ActiveX control cannot be inserted"   


## Cause

This issue occurs because some scriptable controls are made obsolete in Office 2013 for security reasons. This is by design, and these errors are expected. These scriptable controls are disabled by using a version-specific kill-bit that only applies to these controls, and this only happens when they are used in a document. We recommend that you do not try to embed scriptable controls directly into documents, because this behavior may reduce system security. 

## Workaround

WarningThis workaround may make a computer or a network more vulnerable to attack by malicious users or by malicious software such as viruses. We do not recommend this workaround but are providing this information so that you can implement this workaround at your own discretion. Use this workaround at your own risk. If you do implement this workaround, it is strongly suggested that you do this only for the controls that you must use.

To work around this issue, disable the 32-bit kill-bits by browsing to the locations in the following registry, and then change the value of the DWORD for the applicable ClassID from from 1024 to 0. 

For the Click-to-Run installation of Office 2013, locate the following registry subkey:

**HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\15.0\ClickToRun\REGISTRY\MACHINE\Software\Wow6432Node\Microsoft\Office\15.0\Common\COM Compatibility\\\<ClassID>**

For the MSI installation of Office 2013, locate the following registry subkey:

**HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\15.0\Common\COM Compatibility\\\<ClassID>**

**Note** To identify the installation version of Office 2013, follow these steps: 

1. Start an Office 2013 application, such as Word 2013.    
2. On the **File** menu, click **Account**.    
3. If Office 2013 was installed by using Click-to-Run, an "Update Options" item is displayed. For an MSI installation, the "Update Options" item is not displayed.

The following ClassIDs are affected by this issue:

|Description|ClassID|
|---|---|
|Web Browser Control|{8856F961-340A-11D0-A96B-00C04FD705A2}|
|Microsoft Scriptlet Component|{AE24FDAE-03C6-11D1-8B76-0080C744F389}|
|HTML Editing Control|{25336920-03F9-11CF-8FD0-00AA00686F13}|
{25336921-03F9-11CF-8FD0-00AA00686F13}|
|MHTML Editing Control|{3050F3D9-98B5-11CF-BB82-00AA00BDCE0B {3050F5C8-98B5-11CF-BB82-00AA00BDCE0B}{3050F67D-98B5-11CF-BB82-00AA00BDCE0B}|
|DHTML Editing Control|{2D360200-FFF5-11d1-8d03-00a0c959bc0a}|
|DHTML Editing Control (Safe for Scripting)|{2D360201-FFF5-11d1-8D03-00A0C959BC0A}|

> [!NOTE]
> Wow6432Node should be omitted from the registry keys for Office for cases in which a 32-bit version of Office is running on a 32-bit version of Windows, or a 64-bit version of Office is running on a 64-bit version of Windows. However, Wow6432Node should be included when a 32-bit version of Office is running on a 64-bit version of Windows.
