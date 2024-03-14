---
title: Information about the Calendar Checking Tool for Outlook (CalCheck)
description: Describes the Calendar Checking Tool for Outlook (CalCheck), including individual checks, command switches, and additional checked items.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto: 
- Outlook 2016
- Outlook 2013 
- Microsoft Outlook 2010 
- Microsoft Office Outlook 2007 
- Microsoft Office Outlook 2003 
- Exchange Server 2010 Enterprise 
- Exchange Server 2010 Standard 
- Microsoft Exchange Server 2003 Enterprise Edition 
- Microsoft Exchange Server 2003 Standard Edition 
- Outlook for Microsoft 365 Outlook 2019
search.appverid: MET150
ms.reviewer: aruiz, randyto, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# Information about the Calendar Checking Tool for Outlook (CalCheck)

The Calendar Checking Tool for Outlook (CalCheck) is a command-line program that checks the Microsoft Outlook calendar for problems. The tool opens an Outlook messaging profile to access the Outlook calendar. It performs various checks on general settings, such as permissions, free/busy publishing, delegate configuration, and automatic booking. Then, each item in the Outlook calendar folder is checked for known problems that can cause unexpected behavior, such as meetings that seem to be missing.

The CalCheck tool then generates a report that can be used to help diagnose problem items or identify trends.

> [!IMPORTANT]
> CalCheck reports include the following fields for meetings or appointments that are determined to be problematic:
>
> - Subject
> - Location
> - Start Time
> - End Time
> - Organize

Because these calendar item fields may contain personal information or details, we recommend that you first review all items in the CalCheck report before you share your report. See the [More information](#more-information) section for additional fields that are found in CalCheck reports.

## Perform calendar checking

To use CalCheck, the Outlook calendar must reside on a computer that is running Microsoft Exchange Server. The tool doesn't work with IMAP, POP3, or other non-Exchange email accounts.

### Method 1: Use the Microsoft Support and Recovery Assistant

The Assistant fully automates all the steps required to perform Outlook calendar checking and is available in two versions. Use the version that suits your requirements.

- The Enterprise (command-line) version

  The [Enterprise version of the Assistant](https://aka.ms/SaRA_EnterpriseVersion) is a command line version that can be scripted, and is recommended to perform Outlook calender checking on multiple devices and devices that you can't access immediately.
  
  > [!div class="nextstepaction"]
  > [Download the Enterprise version](https://aka.ms/SaRA_EnterpriseVersionFiles)
  
- The UI version

  The [UI version of the Assistant](https://aka.ms/SaRA_Home) is recommended if you need to perform Outlook calender checking on a single device, or on a small number of individual devices.
  
  > [!div class="nextstepaction"]
  > [Download the UI version](https://aka.ms/sara-calcheck)

### Method 2: Manual installation

Go to the [latest release](https://www.microsoft.com/download/details.aspx?id=28786), download and install the Calendar Checking Tool for Outlook.

> [!NOTE]
> The 64-bit version of this tool is for use together with only the 64-bit version of Microsoft Outlook.

## Checks that are performed

The Calendar Checking Tool performs two basic kinds of checks: Calendar-specific checks and item-level checks.

### Calendar-specific checks

The following calendar-specific checks are run and then logged in the report:

- Permissions on the calendar.
- The total number of items in the calendar folder.  

    For more information about high item counts in the Calendar folder, see [Outlook performance issues when there are too many items or folders in a cached mode .ost or .pst file](/outlook/troubleshoot/performance/performance-issues-if-too-many-items-or-folders).

- Delegates on the calendar.
- Free/busy publishing information.
- Direct Booking settings for the mailbox or calendar.
    > [!NOTE]
    > The information for these three checks is read from the Local free/busy message. In rare cases, Outlook may be unable to open that message. In that case, these checks fail. You should force the regeneration of the hidden free/busy information in the Exchange mailbox only if this occurs.  

    For more information about how to regenerate the hidden free/busy information, see [You experience issues in Outlook when you try to configure free/busy information or when you try to delegate information](https://support.microsoft.com/topic/you-experience-issues-in-outlook-when-you-try-to-configure-free-busy-information-or-when-you-try-to-delegate-information-7167b76e-5a56-1a94-08b7-41186c873d9b).

### Item-level checks

The following item-level checks are run and then logged in the report.

|Error number |Issue |Solution |
|----------|-----------|------------|
|0001|The Items Recurrence Start Date or Time is set to 0 (year 1601).|If you're the organizer, you should change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see it in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0002|The Items Recurrence Start Date or Time is earlier than January 1 1995.|This isn't necessarily an error condition. You should delete or cancel the item only if it seems to be corrupted. By default, these items aren't moved when you use the -f argument. These are moved with `calcheck -f` only if you configure calcheck to treat warnings as errors per the `.cfg` file (`WarningIsError=true`).|
|0003|The Items Recurrence Start Date or Time is later than January 1 2025.|This isn't necessarily an error condition. You should delete or cancel the item only if it seems to be corrupted. By default, these items aren't moved when you use the -f argument. These are moved with `calcheck -f` only if you configure calcheck to treat warnings as errors per the `.cfg` file (`WarningIsError=true`).|
|0004|The Items Recurrence Start Date or Time is past the upper limit.|If you're the organizer, you should change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see it in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0005|The Items Recurrence End Date or Time is set to 0 (year 1601).|If you're the organizer, you should change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see it in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0006|Items Recurrence End Date or Time is earlier than January 1 1995.|If you're the organizer, you should change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see it in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0007|The Items Recurrence End Date or Time is later than January 1 2025.|This isn't necessarily an error condition. You should delete or cancel the item only if it seems to be corrupted. By default, these items aren't moved when you use the -f argument. These are moved with `calcheck -f` only if you configure calcheck to treat warnings as errors per the `.cfg` file (`WarningIsError=true`).|
|0008|The Items Recurrence End Date or Time is past the upper limit.|If you're the organizer, you should change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see it in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0009|The Items Recurrence properties aren't created correctly.|If you're the organizer, you should change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see it in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0010|Appointments Recurrence data is empty.|If you're the organizer, you should change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see it in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0011|The `dispidRecurring` property is set to _False_  or doesn't exist, but the `dispidRecurType` property isn't set to None. This indicates that the appointment is recurring. Therefore, the two properties are conflicting.|If you're the organizer, you should change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see it in the list, run `c alcheck  -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0012|There's no Appointment Recurrence but `dispidRecurring` is set to True|If you're the organizer, you should change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see it in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0013|The Recurrence Exception data mismatch.|If you're the organizer, you should change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see it in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0014|The Recurrence Original Start Date or Time is set before the start of the series.|If you're the organizer, you should change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see it in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0015|The Recurrence Original Start Date or Time occurs after the end of the series.|If you're the organizer, you should change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see it in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0016|The Start Date or Time is to Zero.|If you're the organizer, you should change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see it in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0017|The Start Date or Time is earlier than January 1 1995.|If you're the organizer, you should change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see it in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0018|The Start Date or Time is later than Jan 1 2025.|This isn't necessarily an error condition. You should delete or cancel the item only if it seems to be corrupted. By default, these items aren't moved when you use the -f argument. These are moved with `calcheck -f` only if you configure calcheck to treat warnings as errors per the `.cfg` file (`WarningIsError=true`).|
|0019|The Start Date or Time is past the upper limit.|If you're the organizer, you should change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see it in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0020|The Appointment is missing the Start Time.|If you're the organizer, you should change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see it in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0021|The End Date or Time is to Zero.|If you're the organizer, you should change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see it in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0022|The End Date or Time is earlier than January 1 1995.|If you're the organizer, you should change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see it in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0023|The End Date or Time is later than Jan 1 2025. This might be intentional but may also indicate a problem.|This isn't necessarily an error condition. You should delete or cancel the item only if it seems to be corrupted. By default, these items aren't moved when you use the -f argument. These are moved with `calcheck -f` only if you configure calcheck to treat warnings as errors per the `.cfg` file (`WarningIsError=true`).|
|0024|The End Date or Time is past the upper limit.|If you're the organizer, you should change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see it in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0025|This item is missing the Appointment End Time.|If you're the organizer, you should change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see it in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0026|This item is missing the required property `dispidRecurring`.|-|
|0027|This item is missing the required property `dispidApptTZDefStartDisplay`.|If you're the organizer, you should change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see it in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0028|This item is missing the `PR_SENT_REPRESENTING_NAME` property.|For more information about missing Organizer email addresses or display names, see [Description of the Outlook 2013 hotfix package (Outlook-x-none.msp; Outlookintl-\<Language-Code>.msp): October 16, 2013](https://support.microsoft.com/topic/description-of-the-outlook-2013-hotfix-package-outlook-x-none-msp-outlookintl-language-code-msp-october-16-2013-4d99af2b-d006-e1ec-fa60-17f9213d35da).|
|0029|This item is missing the `PR_SENDER_NAME` property.|For more information about missing Organizer email addresses or display names, see [Description of the Outlook 2013 hotfix package (Outlook-x-none.msp; Outlookintl-\<Language-Code>.msp): October 16, 2013](https://support.microsoft.com/topic/description-of-the-outlook-2013-hotfix-package-outlook-x-none-msp-outlookintl-language-code-msp-october-16-2013-4d99af2b-d006-e1ec-fa60-17f9213d35da).|
|0030|There's no Organizer Address on this item. Check the `PR_SENT_REPRESENTING` properties on this item.|-|
|0031|There's no Sender Address on this item. Check the `PR_SENDER` properties on this item.|-|
|0032|There's no Subject on this item. You should add a Subject to this item.|If you're the organizer, update the meeting to include a subject. If you're the attendee, ask the organizer to update the meeting to include a subject. Although this isn't an error condition, it makes it easier to troubleshoot any future issues that are related to the meeting.|
|0033|There's no Message Class for this item.|If you have an issue with a meeting that doesn't have the default message class of IPM.Appointment, and if removing or canceling the meeting resolves the issue, you should determine which program is creating meetings by using that custom message class. You have to determine whether the program or add-in is a Microsoft or third-party application. If it's a third-party application, contact the third-party for support.|
|0034|The Message Class of this item isn't standard for a Calendar item and may indicate a problem.|If you have an issue with a meeting that doesn't have the default message class of IPM.Appointment, and if removing or canceling the meeting resolves the issue, you should determine which program is creating meetings by using that custom message class. You have to determine whether the program or add-in is a Microsoft or third-party application. If it's a third-party application, contact the third-party for support.|
|0035|Missing required property `PR_MESSAGE_CLASS`.|If you have an issue with a meeting that doesn't have the default message class of IPM.Appointment, and if removing or canceling the meeting resolves the issue, you should determine which program is creating meetings by using that custom message class. You have to determine whether the program or add-in is a Microsoft or third-party application. If it's a third-party application, contact the third-party for support.|
|0036|Unable to access the attachment table for this item. Error: \<error code returned\>|If you're the organizer, change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0037|There are more than 25 attachments on this item. This may indicate a problem with exceptions on this recurring meeting.|This isn't an error condition. However, for more information, see the 'Working with recurring meetings' section in this article: [Best practices when using the Outlook Calendar](https://support.office.com/article/best-practices-when-using-the-outlook-calendar-d93f72d3-2361-4e0d-8d6a-5c4939c17f39?correlationid=61c5e139-6e07-487b-9520-78f1055d0bd0&ui=en-us&rs=en-us&ad=us).|
|0038|The Message Size Exceeds 50 MB. This may indicate a problem with attachments/exceptions/properties on this item.|This isn't an error condition. However, for more information, see the 'Working with recurring meetings' section in this article: [Best practices when using the Outlook Calendar](https://office.microsoft.com/outlook-help/best-practices-when-using-the-outlook-calendar-ha104004449.aspx).|
|0039|The Message Size Exceeds 25 MB. This may indicate a problem with attachments/exceptions/properties on this item.|This isn't an error condition. However, for more information, see the 'Working with recurring meetings' section in this article: [Best practices when using the Outlook Calendar](https://office.microsoft.com/outlook-help/best-practices-when-using-the-outlook-calendar-ha104004449.aspx).|
|0040|The Message Size Exceeds 10 MB. This may indicate a problem with attachments/exceptions/properties on this item.|This isn't an error condition. However, for more information, see the 'Working with recurring meetings' section in this article: [Best practices when using the Outlook Calendar](https://office.microsoft.com/outlook-help/best-practices-when-using-the-outlook-calendar-ha104004449.aspx).|
|0041|The SENT_REPRESENTING address doesn't match the Organizer Address from the Recipient Table.  /RecipTable:  /SentRepresenting:|For more information, see [Current issues with Microsoft Exchange ActiveSync and third-party devices](https://support.microsoft.com/topic/current-issues-with-microsoft-exchange-activesync-and-third-party-devices-53a1ffbe-504c-a424-012a-cb4456e94ba9).|
|0042|The organizer of this meeting is potentially incorrect.|For more information, see  [Current issues with Microsoft Exchange ActiveSync and third-party devices](https://support.microsoft.com/topic/current-issues-with-microsoft-exchange-activesync-and-third-party-devices-53a1ffbe-504c-a424-012a-cb4456e94ba9).|
|0043|The `dispidCleanGlobalObjectID` property isn't populated on this item.|-|
|0044|The dispidGlobalObjectID and the `dispidCleanGlobalObjectID` properties aren't populated on this item.|-|
|0045|The `dispidGlobalObjectID` property isn't populated on this item.|-|
|0046|`The PidLidGlobalObjectId` property values match on two items.|For more information, see [Instance of calendar appointment is missing or duplicated on ActiveSync client](https://support.microsoft.com/topic/instance-of-calendar-appointment-is-missing-or-duplicated-on-activesync-client-ad111b06-19f3-0612-69ff-23df898fd86d).|
|0047|The `PidLidCleanGlobalObjectId` property values match on two items.|For more information, see: [Instance of calendar appointment is missing or duplicated on ActiveSync client](https://support.microsoft.com/topic/instance-of-calendar-appointment-is-missing-or-duplicated-on-activesync-client-ad111b06-19f3-0612-69ff-23df898fd86d).|
|0048|The PidLidGlobalObjectId and `PidLidCleanGlobalObjectId` property values match on two items.|For more information, see: [Instance of calendar appointment is missing or duplicated on ActiveSync client](https://support.microsoft.com/topic/instance-of-calendar-appointment-is-missing-or-duplicated-on-activesync-client-ad111b06-19f3-0612-69ff-23df898fd86d).|
|0049|This item is duplicated in the Calendar. Check this item.|If you're the organizer, change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.</br></br>If the subject, organizer, location, recurring/single instance, and start/end times properties all match for two or more items, calc heck -f moves all duplicates except one.|
|0050|The Recipient Table has a bad or missing address type.|If you're the organizer, change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0051|The Recipient Table has a bad or missing email address.|If you're the organizer, change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0052|The Recipient Table has a bad or missing display name entry.|If you're the organizer, change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0053|The Recipient Table Organizer has a bad or missing email address property.|If you're the organizer, change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0054|The Recipient Table contains duplicated entries. Free Busy lookups could be affected.|If you're the organizer, change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0055|Item is missing required data in the `dispidApptTZDefRecur` property.|If you're the organizer, you should change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see it in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0056|The `dispidPropDefStream` property is corrupted. This is a known problem that can cause Outlook to crash.|For more information, see [Outlook crashes when you open a meeting that contains Lync meeting details](https://support.microsoft.com/topic/outlook-crashes-when-you-open-a-meeting-that-contains-lync-meeting-details-82398022-b582-99af-46e9-aa912dc9c3fd).|
|0057|The PropDefStream wasn't created correctly when calling MrMapi.|Run CalCheck again to see whether the PropDefStream can be created correctly. If this error occurs again, then if you're the organizer, change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0058|The Email address type isn't Exchange or SMTP. This could potentially cause performance problems on address lookups.|If you're the organizer, change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0059|Item is missing the required prop PR_MESSAGE_DELIVERY_TIME.|If you're the organizer, change the Calendar folder view to a table view, find the appointment or meeting, and then cancel and re-create it. If you don't see in the list, run `calcheck -f`. If you're the attendee, you should contact the organizer and ask the organizer to cancel and then re-create the meeting.|
|0060|WARNING: Number of Recurring Appointments is greater than 1250. The maximum is 1300.|To prevent hitting the limit, delete some older recurring appointments.|
|0061|ERROR: Number of Recurring Appointments reached the limit of 1300.|To correct this, delete some older recurring appointments.|
|0062|Conflicting items in the Calendar.|If you run `calCheck -f` , these conflicting items are moved.|

> [!NOTE]
> If you prefer not to have holiday items flagged, change the _CalCheck.cfg_ file. CalCheck identifies an all-day event as a holiday if the **Keywords** named property includes the "holiday" string.

## Current help and command-line switches

This section describes the command-line switches that are available to customize CalCheck behavior.

### Usages

You can edit the _CalCheck.cfg_ file to turn specific tests on or off.

*CalCheck [-P \<profilename>] [-O \<path>] [-C \<Version>] [-A] [-F] [-R] [-V]*

_CalCheck -?_
  
- **P** \<Profile name> (if absent, prompts for profile)
- **O** \<Output Path> (path to put output files; the default path is the current directory)
- **C** \<Version> (load a specific MAPI version for the Click-to-Run version of Office 2016 or 2013)
- **A** All calendar items output to CALITEMS.CSV
- **F** Create CalCheck folder and move flagged error items there
- **R** Put a **Report** message into the **Inbox** together with the CalCheck.csv file
- **V** Verbose output to the command window
- **?** Print this message

Running the command creates CalCheck.log and CalCheckErr.csv files that show potential problems and items to fix or remove, plus processing information.  

### Examples

- Default - Prompt for a profile, and process the mailbox in that profile:  
    _CalCheck_

- Process just the mailbox in "MyProfile":  
    _CalCheck -P MyProfile_
- Process a mailbox and move error items to the **CalCheck** folder in the mailbox, and place a report message in the **Inbox**:  
    _CalCheck -F -R_
- Process a mailbox based on a specific profile and version of MAPI for Click-to-Run versions of Office:  
    *CalCheck -C \<Outlook version - like 2010, 2013, etc.> -P MyProfile*
- Print this message:  
    _CalCheck -?_

### Configuration file in CalCheck version 2

CalCheck version 2 (v2) now includes a _CalCheck.cfg_ file. This file is located in the same folder in which CalCheck.exe is located. If the `.cfg` file is missing, CalCheck v2 displays an error message and doesn't run. The `.cfg` file is in plain text format. You can manually edit the file to enable or disable individual tests. By default, all tests are set to **true**. By default, all tests are run.

## More information

CalCheck reports also contain the following fields from calendar meetings and appointments that are determined to be problematic.

|Field |Description|
|----------|-----------|
|Is Past Item (true/false)|Determines if the end time of the meeting or appointment occurred before or after the time CalCheck was ran.|
|Recurring (true/false)|Specifies if the meeting or appointment is recurring or if it's a single instance.|
|Other Item Subject|When duplicate items are found, the Other Item Subject describes the other item that is duplicated with the one in question so that you can find it in your calendar.|
|Other Item Start|When duplicate items are found, the Other Item Start describes the other item's start time that is duplicated with the one in question so that you can find it in your calendar.|
|Other Item End|When duplicate items are found, the Other Item End describes the other item's end time that is duplicated with the one in question so that you can find it in your calendar.|
|EntryID|This is PR_ENTRYID of the calendar item.|
