---
title: Time stamp of the reminder appears incorrect
description: Due In time displayed in the Reminder of Outlook shows incorrectly a few hours ahead. Provides a resolution.
ms.reviewer: v-anlang
ms.topic: troubleshooting
ms.date: 
---
# Time stamp of reminder is wrong when creating a phone call or task activity in Microsoft Dynamics CRM

This article provides a resolution for the issue that you may find the Due In time shown in the Reminder of Microsoft Office Outlook shows incorrectly a few hours ahead.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2518873

## Symptoms

When creating a phone call or task activity in Microsoft Dynamics CRM, the Reminder appears at the Due time set in Microsoft Dynamics CRM, but the Due In time displayed in the Reminder of Outlook shows incorrectly a few hours ahead.

Scenario:

1. A user creates a phone call or task activity in Microsoft Dynamics CRM and set the Due time to be 1:00 PM.
2. This is synchronized with the Microsoft Dynamics CRM for Microsoft Office Outlook client.
3. The Reminder appears at the correct time, 1:00 PM; however, the Due In time on the Reminder says Due In 4 hours.

## Cause

As this is an activity, not an Appointment, the time that it's Due in Outlook will be the time that your Work Hours ends in Outlook. The Due time set in Microsoft Dynamics CRM actually correlates to and sets the Reminder time on the task in Outlook, which is why the reminder appears to display at the due time.

## Resolution

This can be recreated within Outlook alone, as this is standard Outlook functionality. The Due In time on a reminder within Outlook will display the time that is configured for the last Work Hour of the day.

1. In Outlook, select **File**, select **Options** and scroll to **Work Hours**.
2. It uses the Work Hours configured here to display the Due In time. In the example above, it would display 5:00 PM.
