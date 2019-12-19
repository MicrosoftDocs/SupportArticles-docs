---
title: Word could not create the work file error message when you save a document
description: Resolves an issue in which you receive an error message when you save a document in Word 2016, Word 2013, Word 2010 or in Office Word 2007. Error message Word could not create the work file. Check the Temp environment variable
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Word for Office 365
- Word 2019
- Word 2016
- Word 2013
- Word 2010
---

# "Word could not create the work file" error message when you save a document in Microsoft Word

## Symptoms

When you save a document in Microsoft Word, you receive the following error message:

**Word could not create the work file. Check the Temp environment variable.**

The Temporary Internet Files folder for Windows Internet Explorer is set to be in a location where you do not have permission to create new temporary files.   

## Resolution

To resolve this issue, create a new folder on your computer.

1. Start Windows Explorer
2. Locatethe folder location C:\Users\\*userprofile*\AppData\Local\Microsoft\Windows   
3. Create the folder labeled INetCacheContent.Word. 

    > [!NOTE]
    > It may be necessary to turn on Hidden Items in the View Ribbon of Windows Explorer.
