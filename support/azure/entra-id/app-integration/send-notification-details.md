---
title: How to send Notification Details to Microsoft support
description: Learn how to send Notification Details to Microsoft support.
ms.date: 02/18/2024
author: bernawy
ms.author: bernaw
editor: v-jsitser
ms.reviewer: v-leedennis, jarrettr
ms.service: entra-id
ms.subservice: enterprise-apps
content_well_notification: AI-contribution
ai-usage: ai-assisted
---
# How to send Notification Details to Microsoft support

## How to see the details of a portal notification

You can see the details of any portal notification by following the steps below:

1. Select the **Notifications** icon (the bell) in the upper right of the Azure portal.

2. Select any notification in an **Error** state (those with a red (!) icon next to them).

   > [!NOTE]  
   > You cannot click notifications in a **Successful** or **In Progress** state.

3. Use the information under **Notification Details** to understand more details about the problem.

If you still need help, you can also share this information with a support engineer or the product group to get help with your problem.

## How to get help by sending notification details to a support engineer

1. **Take a screenshot** or select the **Copy error icon**, found to the right of the **Copy error** textbox to copy all the notification details to share with a support or product group engineer.

It is important that you share **all the details listed below** with a support engineer if you need help, so that they can help you quickly.

## Notification Details Explained

See the following descriptions for more details about the notifications.

### Essential Notification Items

- **Title** – the descriptive title of the notification
  - Example – **Application proxy settings**
- **Description** – the description of what occurred as a result of the operation
  - Example – **Internal url entered is already being used by another application**
- **Notification ID** – the unique ID of the notification
  - Example – **clientNotification-2adbfc06-2073-4678-a69f-7eb78d96b068**
- **Client Request ID** – the specific request ID made by your browser
  - Example – **302fd775-3329-4670-a9f3-bea37004f0bc**
- **Time Stamp UTC** – the timestamp during which the notification occurred, in UTC
  - Example – **2017-03-23T19:50:43.7583681Z**
- **Internal Transaction ID** – the internal ID we can use to look up the error in our systems
  - Example – **71a2f329-ca29-402f-aa72-bc00a7aca603**
- **UPN** – the user who performed the operation
  - Example – **tperkins\@f128.info**
- **Tenant ID** – the unique ID of the tenant that the user who performed the operation was a member of
  - Example – **7918d4b5-0442-4a97-be2d-36f9f9962ece**
- **User object ID** – the unique ID of the user who performed the operation
  - Example – **17f84be4-51f8-483a-b533-383791227a99**

### Detailed Notification Items

- **Display Name** – **(can be empty)** a more detailed display name for the error
  - Example – **Application proxy settings**
- **Status** – the specific status of the notification
  - Example – **Failed**
- **Object ID** – **(can be empty)** the object ID against which the operation was performed
  - Example – **8e08161d-f2fd-40ad-a34a-a9632d6bb599**
- **Details** – the detailed description of what occurred as a result of the operation
  - Example – **Internal url `https://bing.com/` is invalid since it is already in use**
- **Copy error** – Select the **copy icon** to the right of the **Copy error** textbox to copy all the notification details to share with a support or product group engineer
  - Example
    ```{"errorCode":"InternalUrl\_Duplicate","localizedErrorDetails":{"errorDetail":"Internal url 'https://google.com/' is invalid since it is already in use"},"operationResults":\[{"objectId":null,"displayName":null,"status":0,"details":"Internal url 'https://bing.com/' is invalid since it is already in use"}\],"timeStampUtc":"2017-03-23T19:50:26.465743Z","clientRequestId":"302fd775-3329-4670-a9f3-bea37004f0bb","internalTransactionId":"ea5b5475-03b9-4f08-8e95-bbb11289ab65","upn":"tperkins@f128.info","tenantId":"7918d4b5-0442-4a97-be2d-36f9f9962ece","userObjectId":"17f84be4-51f8-483a-b533-383791227a99"}```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
