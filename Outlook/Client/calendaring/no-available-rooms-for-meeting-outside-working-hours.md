---
title: No available rooms for meeting outside working hours
description: When you start a meeting outside your working hours, there are no available rooms in the Room Finder pane in Outlook 2010 or Outlook 2013.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: meshel, aruiz
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# No available rooms for a meeting outside working hours in Outlook

_Original KB number:_ &nbsp; 2932395

## Summary

By design, when you try to start a meeting in which either the **Start time** or the **End time** is outside your working hours, and your working hours differ from the meeting rooms' working hours, no available rooms are displayed in the **Room Finder** pane.

For example, assume that your working hours are set as 8:00 A.M. - 5:00 P.M., and that the meeting rooms' working hours are set as 9:00 A.M. - 6:00 P.M. If you try to start a new meeting at 6:00 P.M., no available rooms are displayed.

## Resolution

To resolve this issue, configure the working hours in **Outlook Options** to the same hours as the desired rooms by using one of the following methods:

### Method 1

Use the Group Policy Management Console to change the Group Policy settings in the following location:

- Outlook Options\Preferences\Calendar Options\Working hours

Select **Enable**, and then specify the working hours to be the same hours as the rooms.

### Method 2

Use the Office Customization Tool (OCT), and navigate to the following location in Features\Modify User Settings:

- Outlook Options\Preferences\Calendar Options\Working hours

Select **Enabled**, and then specify the working hours to be the same hours as the rooms.

### Method 3

Use Windows PowerShell to run the following cmdlet:

```powershell
Set-MailboxCalendarConfiguration -identity username -WorkingHoursStartTime hh:mm:ss -WorkingHoursEndTime hh:mm:ss
```

## More information

For information about how to configure Group Policy for Microsoft Office, see [Use Group Policy to enforce Office 2010 settings](/previous-versions/office/office-2010/cc179081(v=office.14)). Although the article is for Office 2010, the Administrative Templates information also applies to Office 2013.

For more information about the OCT, see [Office Customization Tool in Office 2010](/previous-versions/office/office-2010/cc179097(v=office.14)) or [Office Customization Tool (OCT) reference for Office 2013](/previous-versions/office/office-2013-resource-kit/cc179097(v=office.15)).
