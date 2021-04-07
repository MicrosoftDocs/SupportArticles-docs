---
title: Unable to open entity records using an iPad
description: This article provides a resolution for the problem that occurs when you attempt to open an entity record by using an iPad.
ms.reviewer: debrau
ms.topic: troubleshooting
ms.date: 
---
# Unable to open entity records using an iPad in Microsoft Dynamics CRM Online

This article helps you resolve the problem that occurs when you attempt to open an entity record by using an iPad.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2813276

## Symptoms

When attempting to open an entity record using an iPad, the following error:

> You cannot view this item on this device

## Cause

This error can be caused by several factors:

1. The entity form cannot be opened in the iPad browser experience.
2. A form event is enabled on a default form, and mobile express is also disabled.
3. Mobile Express is disabled on an entity that only opens in Mobile Express mode.

## Resolution

The first bulleted cause of the issue is considered by design. The following entities cannot be viewed in the iPad browser experience:

- Goal
- Rollup Query
- Rollup Field
- Marketing List
- Quote
- Product

The second and third bulleted cause of the issue can be resolved by enabling Mobile Express on the affected entity. To enable Mobile Express, please use the following steps:

1. Click **Settings**, select **Customizations**, and then click **Customize The System**.
2. Under **Components**, expand **Entities**, and select the entity where the issue occurs.
3. In the **General** tab, under **Outlook & Mobile**, place a checkmark in Mobile Express.
4. Click **Save** and then click **Publish**.

## More information

The following entities will always open in Mobile Express:

- Appointment
- Recurring Appointment
- Service
- Case
- Campaign
- User
- Currency
- Facilities/Equipment
