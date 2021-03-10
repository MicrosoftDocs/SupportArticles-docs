---
title: An unknown error occurred while synchronizing data to Outlook error when synchronizing records
description: An unknown error occurred while synchronizing data to Outlook error occurs when synchronizing records after the data in the organizer field is removed. Provides a resolution.
ms.reviewer: clintwa, debrau
ms.topic: troubleshooting
ms.date: 
---
# An unknown error occurred while synchronizing data to Outlook error when synchronizing records

This article provides a resolution for the **An unknown error occurred while synchronizing data to Outlook** error that occurs after the data in the organizer field is removed in the Microsoft Dynamics CRM web client.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2700417

## Symptoms

By default, appointment records created in the Microsoft Dynamics CRM web client automatically populate the organizer field as the creating user. However, the data in this field can be removed and is not considered required.

In the Microsoft Dynamics CRM 2011 Outlook client, this may produce the following error during synchronization:

> An unknown error occurred while synchronizing data to Outlook

:::image type="content" source="media/an-unknown-error-occurred-while-synchronizing-data-to-outlook/error.jpg" alt-text="CRM 2011 sample synchronization error for appointments with blank organizer" border="false":::

## Cause

The organizer field on the synchronized appointment record is blank.

## Resolution

Ensure that the organizer field is appropriately populated on the appointment records that are producing this behavior.

In addition, the following actions can be taken to help mitigate this issue for future occurrences:

1. Make the organizer field a required field on the appointment form.
2. Create a workflow that fires on create and update of an appointment record to check if the organizer field is blank. If the field is blank, add the owner of the record as the appointment organizer.
3. Open the appointment in Outlook and populate the organizer field, then synchronize.
4. Create a plugin that ensures that the organizer field is populated when an appointment is created or updated.
