---
title: Appointments don't sync to Exchange
description: Provides a solution to an issue where appointments aren't syncing to Exchange or Outlook after being created in the CRM for Phones Express app.
ms.reviewer: taskar, tybosse
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Appointments are not syncing to Exchange or Outlook after being created in the CRM for Phones Express app

This article provides a solution to an issue where appointments aren't syncing to Exchange or Outlook after being created in the CRM for Phones Express app.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2015, Microsoft Dynamics CRM 2013  
_Original KB number:_ &nbsp; 3118392

## Symptoms

After creating an Appointment in the CRM for Phones Express app, the Appointment is created in CRM, but it isn't synchronized using either of the following methods:

- CRM for Outlook
- Server-Side Synchronization

In the Asynchronous logs on the CRM server, an error similar to the following message will occur:

> The item {GUID of the Appointment} failed to sync on the Exchange side and is being added to the sync error table for the mailbox : {GUID of the Mailbox record in CRM}. Exception details : Unhandled Exception: System.ArgumentOutOfRangeException: Index was out of range. Must be non-negative and less than the size of the collection.
>
> Parameter name: index

## Cause

The Organizer field isn't populated automatically when creating an Appointment using the CRM for Phones Express app.

## Resolution

Add the Organizer Field to the Mobile Form, and make it a required Field.

1. Make the Organizer Field a required Field on the Appointment entity.
    1. Select **Settings**, **Customizations**, and **Customize the System**.
    1. Expand **Entities**, expand **Appointment**, and select **Fields**.
    1. Select the Field with the Name Organizer, and select **Edit**.
    1. In the **Field Requirement** value, select **Business Required**.
    1. Select **Save** and Close.

2. Add the Organizer Field to the Mobile Form for the Appointment entity.
    1. Select **Settings**, **Customizations**, and **Customize the System**.
    1. Expand **Entities**, expand **Appointment**, and select **Forms**.
    1. Select the Form with the Name of Information, and the Form-Type of Mobile-Express.
    1. Select **More Actions**, and **Edit**.
    1. Select **Organizer**, and select **Add**.
    1. Select **Save** and Close.

3. Publish the Appointment entity.
    1. Select **Settings**, **Customizations**, and **Customize the System**.
    1. Expand **Entities**, and select **Appointment**.
    1. Select **Publish**.
