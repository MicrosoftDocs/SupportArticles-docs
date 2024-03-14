---
title: Cannot edit video or audio if Desktop Experience is not installed
description: Describes an issue where media editing options such as Insert Video or Insert Audio are unavailable within PowerPoint on a server if Desktop Experience is not installed.
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
appliesto: 
  - PowerPoint 2013
  - PowerPoint 2010
  - Microsoft Office PowerPoint 2007
ms.date: 03/31/2022
---

# You cannot edit video or audio in PowerPoint if Desktop Experience is not installed

## Symptoms

When PowerPoint is installed on a Windows Server 2012 or Windows Server 2008 machine, certain media editing options may be unavailable. For example, the Insert Video and Insert Audio options are greyed out.

## Cause

The necessary Windows components to enable these features are not installed by default in a server operating system.

## Resolution

To enable these features, you must install the Desktop Experience feature for the server. To install Desktop Experience, follow these steps: 

1. Start Server Manager.   
2. In the details pane, locate the Features Summary area, and then click Add Features.    
3. In the Add Features Wizard, click to select the Desktop Experience check box, and then click Next.    
4. Click Install.   
5. After the Desktop Experience feature is installed, click Close to exit the Add Features Wizard, and then click Yes to restart the computer.   

## More Information

For more information on the Desktop Experience feature, please see:

- [Desktop Experience Overview](https://technet.microsoft.com/library/cc772567.aspx)
- [How to enable Windows Vista user experience features on a computer that is running Windows Server 2008](https://support.microsoft.com/help/947036)