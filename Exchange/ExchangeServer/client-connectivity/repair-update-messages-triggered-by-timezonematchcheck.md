---
title: Repair update messages due to TimeZoneMatchCheck failures
description: Describes an issue that triggers multiple repair update messages in Exchange Server 2016, 2013 or 2010 on an iOS device. These messages indicate that the Calendar Repair Assistant (CRA) has updated scheduled meetings.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jmartin, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Exchange Online
search.appverid: MET150
---
# Repair update messages are triggered by TimeZoneMatchCheck failures in Exchange Server

_Original KB number:_ &nbsp; 3019798

## Symptoms

In Exchange Server 2016, Exchange Server 2013, or Exchange Server 2010, you receive one or more repair update messages on an iOS 8.*x* or iOS 7.*x* device. These messages indicate that the Calendar Repair Assistant (CRA) has updated a meeting.

The body of the message contains the following:

```console
Your meeting was found to be out of date and has been automatically updated.

Updated meeting details:
Meeting Recurrence
```

Analysis of the CRA logs shows that the TimeZoneMatchCheck process failed:

```console
<CleanGlobalObjectId>040000008200E00074C5B7101A82E00800000000F076BAF92303D001000000000000000010000000F75B1C45DB47C344BF73214BACD3ED66</CleanGlobalObjectId>
<OwnerAppointmentId>-281888802</OwnerAppointmentId>
<Attendees>
<Attendee EmailAddress="jim@tailspintoys.com">
<ConsistencyChecks>
<ConsistencyCheck Type="CanValidateOwnerCheck" Result="Passed">
<Description>Checks whether the counterpart user can be validated or not.</Description>
</ConsistencyCheck>
<ConsistencyCheck Type="ValidateStoreObjectCheck" Result="Passed">
<Description>Calls Validate() on the base calendar item.</Description>
</ConsistencyCheck>
<ConsistencyCheck Type="MeetingExistenceCheck" Result="Passed">
<Description>Checkes whether the item can be found in the owner's calendar or not.</Description>
</ConsistencyCheck>
<ConsistencyCheck Type="MeetingCancellationCheck" Result="Passed">
<Description>Checkes to make sure that the meeting cancellations statuses match.</Description>
</ConsistencyCheck>
<ConsistencyCheck Type="TimeZoneMatchCheck" Result="Failed">
<Description>Checks to make sure that the attendee has correct recurring time zone information with the organizer.</Description>
<Inconsistencies>
<Inconsistency Owner="Attendee" ShouldFix="True" Flag="RecurringTimeZone" />
</Inconsistencies>
</ConsistencyCheck>
<ConsistencyCheck Type="MeetingPropertiesMatchCheck" Result="Passed">
<Description>Checks to make sure that the attendee has the correct critical properties for the meeting.</Description>
</ConsistencyCheck>
</ConsistencyChecks>
<RUMs>
<RUM IsOccurrence="False" Type="Update" Sent="True" Time="DateTime">
<Flags>
<Flag>RecurringTimeZone</Flag>
</Flags>
</RUM>
</RUMs>
</Attendee>
</Attendees>
</Meeting>
<Meeting Subject="Test Recurring TimeZone Meeting" MeetingType="RecurringMaster" StartTime="DateTime" EndTime="DateTime" Organizer="sarah@tailspintoys.com">
<InternetMessageId>&lt;fc699217a05d40dc867c497754df16e5@CLT-EX13-MBX1.tailspintoys.com&gt;</InternetMessageId>
```

> [!NOTE]
> The default location for the CRA logs is %ExchangeInstallPath%\Logging\Calendar Repair Assistant.

## Cause

Meeting repair update messages may appear in the attendee's Inbox 12-48 hours after the attendee updated the meeting on an iOS 8.*x* or iOS 7.*x* device. CRA is trying to correct a discrepancy that was introduced by the iOS device to the time zone property of the attendee's copy of the meeting.

## Resolution

This issue has been addressed in the iOS 8.3 update.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-information-disclaimer.md)]
