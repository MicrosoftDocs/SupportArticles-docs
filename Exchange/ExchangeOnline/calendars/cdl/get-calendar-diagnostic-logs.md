---
title: Get Calendar diagnostic logs for Exchange Online mailboxes
description: Discusses how to collect CDL logs to investigate calendar issues for Exchange Online mailboxes.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
  - CI 187189
  - CI 1020
ms.reviewer: mburuiana, shanefe, meshel, erichart, ninob, meerak, v-trisshores
appliesto:
  - Exchange Online
search.appverid: MET150
ms.date: 04/10/2025
---

# Get Calendar diagnostic logs for Exchange Online mailboxes

Calendar diagnostic logs (CDLs) contain important calendar-related event data for Microsoft Exchange Online mailboxes. You can use CDLs to get detailed information about calendar items, such as meetings, to help diagnose issues. For example, a meeting organizer might ask you to find out who canceled their meeting.

For information about how to analyze the data, see [Analyze Calendar Diagnostic logs for Exchange Online mailboxes](./analyze-calendar-diagnostic-logs.md).

The following sections present different methods to get the CDLs for a meeting.

> [!TIP]
> We recommend that you use the [Get-CalendarDiagnosticObjectsSummary.ps1 script](https://microsoft.github.io/CSS-Exchange/Calendar/Get-CalendarDiagnosticObjectsSummary/) to get CDLs because the script processes and enhances the raw CDLs to provide additional diagnostic information.

## Use the Get-CalendarDiagnosticObjectsSummary.ps1 script

Select either of the following methods to get raw CDLs, enhanced CDLs that contain additional diagnostic information, and a concise timeline of meeting actions:

- [Get CDLs by using the meeting ID](#get-cdls-by-using-the-meeting-id)
- [Get CDLs by using the subject of the meeting](#get-cdls-by-using-the-subject-of-the-meeting)

> [!IMPORTANT]
> For the following reasons, we recommend that you get CDLs by using the meeting ID instead of the subject of the meeting:
> - You get CDLs for the specified meeting instead of for all meetings that match the subject.
> - The CDLs have more detailed information.
> - You must use the meeting ID if you specify multiple meeting participants when you run the script.
> - If you contact Microsoft support, you might be asked to get CDLs by using the meeting ID.
> 
> **Note**: CDLs are removed after 31 days. If you don't have sufficient time to determine the meeting ID, get the CDLs right away by using the subject. Then, get CDLs by using the meeting ID if the CDLs are still available.

### Get CDLs by using the meeting ID

Follow these steps:

1. Download the [Get-CalendarDiagnosticObjectsSummary.ps1](https://aka.ms/CalLogSummary) script to a local folder.

2. If the [ImportExcel module](https://www.powershellgallery.com/packages/ImportExcel) isn't already installed, run the following PowerShell cmdlet to install it:

   ```PowerShell
   Install-Module -Name ImportExcel
   ```

3. Find the meeting ID by using any of the following methods:

   - Ask the user who has the meeting issue to [find the meeting ID](./get-meeting-id.md#non-admin-methods).
   - [Find the meeting ID yourself as an admin](./get-meeting-id.md#admin-methods).
   - [Get CDLs by using the subject of the meeting](#get-cdls-by-using-the-subject-of-the-meeting), and then extract the meeting ID from the timeline worksheet for the relevant meeting.

4. In the folder that contains the script, run the following PowerShell command in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

   ```PowerShell
   .\Get-CalendarDiagnosticObjectsSummary.ps1 -Identity "<organizer SMTP address>","<delegate SMTP address>","<attendee SMTP address>" -MeetingId "<meeting ID>" -TrackingLogs -Exceptions -ExportToExcel
   ```

   > [!NOTE]
   > Use the **Identity** parameter to specify all key participants of the meeting, such as the meeting organizer, delegates, and attendees.

   The script creates the following Microsoft Excel file in the current folder:

   *CalLogSummary_\<short meeting ID\>.xlsx*

   The file contains the following worksheets for each meeting participant:

   - `<participant SMTP address>_TimeLine`: Contains the timeline
   - `<participant SMTP address>`: Contains the enhanced CDLs
   - `<participant SMTP address>_Raw`: Contains the raw CDLs

   The file also contains a `Script Info` worksheet that provides runtime information, such as the script command, script version, script runtime, PowerShell version, and OS version.

### Get CDLs by using the subject of the meeting

Follow these steps:

1. Download the [Get-CalendarDiagnosticObjectsSummary.ps1](https://aka.ms/CalLogSummary) script to a local folder.

2. If the [ImportExcel module](https://www.powershellgallery.com/packages/ImportExcel) isn't already installed, run the following PowerShell cmdlet to install it:

   ```PowerShell
   Install-Module -Name ImportExcel
   ```

3. Ask the user who has the meeting issue to provide the subject of the meeting.

4. In the folder that contains the script, run the following PowerShell command in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

   ```PowerShell
   .\Get-CalendarDiagnosticObjectsSummary.ps1 -Identity "<user SMTP address>" -Subject "<subject of the meeting>" -ExportToExcel
   ```

   The script creates the following Excel file in the current folder:

   *CalLogSummary_\<short meeting ID\>.xlsx*

   The file contains the following set of worksheets:

   - `<SMTP address>_TimeLine`: Contains the timeline
   - `<SMTP address>`: Contains the enhanced CDLs
   - `<SMTP address>_Raw`: Contains the raw CDLs

> [!NOTE]
> - If more than one meeting matches the subject of the meeting, the script generates an Excel file for each meeting.
> - Each meeting is uniquely identified by a meeting ID (GUID) in the timeline worksheet for the meeting. You can rerun the script for a specific meeting by using the meeting ID from the timeline worksheet.
> - You can't specify multiple meeting participants if you run the script by using the subject of the meeting. To get the CDLs for another participant, rerun the script and pass in the identity of that user, or [get CDLs by using the meeting ID](#get-cdls-by-using-the-meeting-id).
> - The **Subject** parameter doesn't support wildcards. Therefore, search terms like `*lunch*` or `project-202?` won't return the expected results. However, the script automatically performs a partial match search on your search term. Therefore, the search term `lunch` matches a meeting that has the subject `Sales lunch meeting`. Subject searches aren't case sensitive.

## Use the Get-CalendarDiagnosticObjects cmdlet

Run the [Get-CalendarDiagnosticObjects](/powershell/module/exchange/get-calendardiagnosticobjects) PowerShell cmdlet to download raw CDLs.

> [!NOTE]
> - The Get-CalendarDiagnosticObjects cmdlet doesn't generate enhanced CDLs or a meeting timeline.
> - If multiple meetings have the same subject, use the meeting ID to uniquely identify a meeting.
> - The **Subject** parameter doesn't support wildcards. Therefore, search terms like `*lunch*` or `project-202?` won't return the expected results. However, by default, the cmdlet performs a partial match search on your search term. Therefore, the search term `lunch` matches a meeting that has the subject `Sales lunch meeting`. To perform an exact match search, set the value of the [ExactMatch](/powershell/module/exchange/get-calendardiagnosticobjects#-exactmatch) parameter to `$true`. Subject searches aren't case sensitive.

### Example 1

The following example gets the CDLs from Amal Skye's mailbox for all items for which the Subject property is an exact or partial match for "IT Meeting":

```PowerShell
Get-CalendarDiagnosticObjects -Identity "Amal Skye" -Subject "IT Meeting" | Export-Csv "<file path>" -NoTypeInformation
```

> [!IMPORTANT]
> The meeting ID for each matching meeting is in the `CleanGlobalObjectID` column of the output file. 

### Example 2

The following example uses the [CustomPropertyNames](/powershell/module/exchange/get-calendardiagnosticobjects#-custompropertynames) parameter to return specific properties for a meeting. For a list of all property values, see [Values for the CustomPropertyNames parameter](/powershell/exchange/values-for-custompropertynames-parameter).

```PowerShell
$customPropertyNames = "ClientIntent", "FreeBusyStatus", "From", "SendMeetingMessagesDiagnostics", "Sensitivity"
Get-CalendarDiagnosticObjects -Identity "Amal Skye" -MeetingID <meeting ID> -CustomPropertyNames $customPropertyNames | Export-Csv "<file path>" -NoTypeInformation
```

> [!IMPORTANT]
> You can get the meeting ID from Example 1, or by using any of the methods in [Get the ID of a meeting](./get-meeting-id.md).

## Use the EAC

Follow these steps to download raw CDLs:

1. In the Exchange admin center (EAC), navigate to **Troubleshoot** > **Collect Logs** > **Calendar**.

2. Select **Calendar Logs** to open the **Calendar Diagnostic Logs** pane.

3. Enter the following information:

   - SMTP address of the calendar owner
   - Subject of the meeting

4. Select **Start**. Exchange Online downloads the raw CDLs to your browser's download folder.

> [!NOTE]
> - The EAC **Troubleshoot** menu is being rolled out gradually and might not be available in your organization yet.
> - The EAC doesn't generate enhanced CDLs or a meeting timeline.
> - The **Meeting Subject** field doesn't support wildcards. Therefore, search terms like `*lunch*` or `project-202?` won't return the expected results. However, the EAC automatically performs a partial match search on your search term. Therefore, the search term `lunch` matches a meeting that has the subject `Sales lunch meeting`. Subject searches aren't case sensitive.
