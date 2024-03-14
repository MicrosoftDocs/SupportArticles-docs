---
title: Issue when you access a OneNote notebook from Teams
description: Provides a workaround for when you're unable to access a OneNote notebook from Teams.
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
  - Microsoft Teams
ms.date: 01/02/2024
---

# Issue when you access a OneNote notebook from Teams

## Symptoms

You can't access a Microsoft OneNote notebook from Microsoft Teams. Additionally, you receive the following error message:

> One or more of the document libraries on the user or group's OneDrive contains more than 5,000 OneNote items (notebooks, sections, section groups) and cannot be queried using the API. Please make sure that none of the user or group's document libraries contains more than 5,000 OneNote items. Please follow the link below for instructions on how to remedy this situation.  

## Cause

This issue occurs if the document libraries contain more than 5,000 OneNote items. This is a known limitation with OneNote items when accessing them from Teams.

## Workaround

To work around this issue, reduce the number of OneNote items in the document libraries.

## More Information

We recommend that you access OneNote through OneNote Online or the OneNote application and remove items that aren't needed.

To determine the item count, use one of the following methods:

- Use the OneNote API diagnostic to count the number of items in a certain document library:

    [https://github.com/OneNoteDev/OneNoteAPIDiagnostics/blob/master/Tool/OneNoteAPIDiagnostics_1.0.0.0.zip](https://github.com/OneNoteDev/OneNoteAPIDiagnostics/blob/master/Tool/OneNoteAPIDiagnostics_1.0.0.0.zip)
- Run Microsoft.Office.OneNote.OneNoteAPIDiagnostics.exe, and then enter the URL, user and password:

    **https://\<domain>.sharepoint.com/sites/\<site>/**

    Here is an output example:

    ```AsciiDoc
    Items Count:14744
    Notebooks Count:0
    Folders Count:4607
    Sections Count:0
    Content Type ID:True
    File Type:True
    HTML File Type:True 
    ```

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
