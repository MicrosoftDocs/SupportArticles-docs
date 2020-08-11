---
title: Issues when you schedule a meeting in Skype for Business Online
description: Describes how to resolve issues that may occur when you create meetings in Skype for Business Online in Office 365.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-six
ms.reviewer: dahans
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business Online
---

# How to resolve issues that may occur when you schedule a meeting in Skype for Business Online

## Problem

When you schedule a meeting in Skype for Business Online (formerly Lync Online) in Office 365, you may experience one of the following symptoms. 

|Symptom|Cause|Resolution|
|---|----|---|
|Lync 2010 or Lync 2013 is installed on the computer. However, you can't find the options in Outlook to schedule or to configure the meeting.|Either the Lync conferencing add-in is disabled or isn't working correctly.|See [resolution for Outlook 2010 and 2013](#to-resolve-symptom-1-for-outlook-2010-or-outlook-2013)
|When you try to edit the options for the meeting, you receive the error message: Changes to this occurrence won't apply to the online meeting associated with this series. To change the online meeting, open the series and then make changes.|This is expected behavior if you're only trying to edit a single meeting in a recurring series.|See [resolution for symptom 2](#to-resolve-symptom-2)|
|Dial-in conferencing information isn't populated in the meeting invitation. Or, the information that's populated in the invitation doesn't work.|The user isn't enabled for dial-in conferencing, or provisioned with the incorrect settings.|See [resolution for symptom 3](#to-resolve-symptom-2)|

## Solution

### To resolve symptom 1 for Outlook 2010 or Outlook 2013 

Verify that the Online Meeting Add-in for Lync 2010 or the Lync Meeting Add-in for Microsoft Office is installed and enabled in Outlook. To do this, follow these steps:
1. In Outlook, click the Filetab, click Options, and then click Add-Ins.   
2. Take one of the following actions:
   - If the add-in is in the Inactive Application Add-inslist, follow these steps:
        1. In the Manage drop-down list at the bottom of the dialog box, click COM Add-ins, and then click Go.   
        2. Click to select the check box next to the add-in, and then click OK.

           The New Online Meetingbutton should now be available in Calendar View, and the Online Meetingbutton should be available when you create a new calendar item.      
    - If the add-in is in the Disabled Application add-inslist, follow these steps:
        1. In the Managedrop-down list at the bottom of the dialog box, click Disabled Items, and then click Go.   
        2. Select the add-in, and then click Enable.   
        3. Restart Outlook, and then verify that the add-in is displayed in the Add-insdialog box.

            The New Online Meetingbutton should now be available in Calendar View, and the Online Meetingbutton should now be available when you create a new calendar item.      
   
3. In Event Viewer, view the Application log to see whether an error was logged for Outlook, for Lync 2010 or Lync 2013, the Online Meeting Add-in for Lync 2010 or the Lync Meeting Add-in for Office 2013.   

### To resolve symptom 2

- Don't edit a specific occurrence of the Skype for Business Online meeting. Instead, edit the whole series.   
- If you have to change just one occurrence of the meeting, you must create a new meeting to replace the one occurrence or change the whole series.   
- If the error occurs for a meeting that isn't part of a larger series, delete the meeting, and then re-create it.   

### To resolve symptom 3

Verify that the user is provisioned correctly for the Audio Conferencing Provider (ACP). Verify that the information for that user in the Dial-In Conferencing Control Panel exactly matches the information that the ACP provided.

For more information about how to troubleshoot ACP provisioning issues, go to the following Microsoft websites:

[Set up Audio Conferencing for Skype for Business](https://office.microsoft.com/redir/ha102817350.aspx)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).