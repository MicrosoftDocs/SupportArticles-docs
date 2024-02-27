---
title: Can't use Group Policy to disable items in Backstage view
description: Describes an issue that blocks you from using Group Policy to disable certain Backstage View items in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Microsoft Outlook 2010
  - Outlook 2013
search.appverid: MET150
ms.date: 01/30/2024
---
# Can't use Group Policy to disable items in Backstage view in Outlook

_Original KB number:_ &nbsp; 3061214

## Symptoms

In Microsoft Outlook 2013 and 2010, when you try to use Group Policy to disable items in the **Info** section in Backstage view (on the **File** tab), the controls are not disabled as expected.

## Cause

This problem occurs when you try to disable the following controls by using Group Policy:

| Control| Policy value |
|---|---|
|Add Account|20100|
|Account Settings|6863|
|Delegate Access|20103|
|Download Address Book|5658|
|Prepare for Offline Use|20300|
|Automatic Replies|5621|
|Empty Deleted Items Folder|1671|

## Resolution

Microsoft is aware of this issue in the versions of Outlook that are mentioned in the [Symptoms](#symptoms) section. There is currently no resolution for most of the controls. However, the following control was made available in recent updates for Outlook.

The Empty Deleted Items folder control:

- In Outlook 2010, apply [March 10, 2015 update for Outlook 2010 (KB2956203)](https://support.microsoft.com/help/2956203)

## More information

Typically, you'd use Group Policy to update the following keys and values in order to disable items in the UI:

Outlook 2010:  
`HKEY_CURRENT_USER\software\Policies\Microsoft\Office\14.0\Outlook\DisabledCmdBarItemsList`

Outlook 2013:  
`HKEY_CURRENT_USER\software\Policies\Microsoft\Office\15.0\Outlook\DisabledCmdBarItemsList`

Outlook 2010 and 2013:  
String: TCID*x* (where *x* is an integer)
Value: Command bar value from the workbook that's available in the following Microsoft Download link:
  
- [Office 2013 Help Files: Office Fluent User Interface Control Identifiers](https://www.microsoft.com/download/details.aspx?id=36798)

However, this method doesn't disable the items that are mentioned in the [Symptoms](#symptoms) and [Cause](#cause) sections, except for those that have been made available, per the [Resolution](#resolution) section.
