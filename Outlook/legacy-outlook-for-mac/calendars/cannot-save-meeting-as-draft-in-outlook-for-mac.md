---
title: Can't save meeting as draft in Outlook for Mac
description: This article provides a workaround for saving a meeting as a draft in the Outlook for Mac using Office JS API.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendar
  - CI 162281
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: elizs
appliesto: 
  - Outlook 2019 for Mac
  - Outlook for Microsoft 365 for Mac
  - Outlook 2016 for Mac
search.appverid: MET150
ms.date: 01/30/2024
---
# Can't save a meeting as a draft in Outlook for Mac by using Office JS API

_Original KB number:_ &nbsp; 4505745

## Symptoms

Microsoft Outlook for Mac doesn't support [saveAsync](/javascript/api/outlook/office.appointmentcompose?view=outlook-js-1.6&preserve-view=true#outlook-office-appointmentcompose-saveasync-member(1)) on a meeting in Compose mode. Outlook add-ins can't get the item identifier. It means that the add-ins can't uniquely identify and communicate with Microsoft Exchange to update or listen for changes on the item.

## Workaround

To work around this issue, you can set an extended property ([customProperty](/javascript/api/outlook/office.appointmentcompose?view=outlook-js-1.6&preserve-view=true#outlook-office-appointmentcompose-loadcustompropertiesasync-member(1)): Office JS API) on the item. An extended property is part of the item and is available on Exchange as soon as the item is sent. Therefore, the add-in can query or listen to items that have this extended property set.

To set the property, follow these steps:

1. Select one of the following APIs to use:
    1. EWS
    2. REST
    3. Graph

2. Get a valid token for each API set:
    1. EWS: Use [getCallbackTokenAsync](/javascript/api/outlook/office.mailbox?view=outlook-js-preview&preserve-view=true#outlook-office-mailbox-getcallbacktokenasync-member(1))
    2. REST: Use [getCallbackTokenAsync](/en-us/javascript/api/outlook/office.mailbox?view=outlook-js-preview&preserve-view=true#outlook-office-mailbox-getcallbacktokenasync-member(1)) with **options.isRest** = **true**
    3. Graph: Use onBehalfOf token

3. Query or listen for calendar events:
    1. EWS: [Subscribe](/exchange/client-developer/exchange-web-services/how-to-synchronize-items-by-using-ews-in-exchange) to the created event
    2. REST: [Subscribe](/previous-versions/office/office-365-api/api/version-2.0/notify-rest-operations#SubscribeOperation) to the created notification, and filter based on the extended property
    3. Graph: [Subscribe](/graph/api/subscription-post-subscriptions?view=graph-rest-1.0&tabs=http&preserve-view=true) to the created notification, and filter based on the extended property

4. Find the corresponding extended property on Exchange:
    1. EWS:

       ExtendedFieldURI {PropertySet = PS_PUBLIC_STRINGS, PropertyName = cecp-\<add-in id from manifest>}
    2. REST/Graph:

       SingleValueExtendedProperties { PropertyId = String {00020329-0000-0000-c000-000000000046} Name cecp-\<add-in id from manifest>}

5. Use the notification that's sent to the webhook to update the backend with **itemId** when the subscription is successful.
