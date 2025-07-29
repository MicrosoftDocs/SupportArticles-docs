---
title: Issues With Port Orders
description: Troubleshoots common issues that occur when you use port orders in Microsoft Teams.
ms.date: 07/29/2025
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Teams Calling (PSTN)
  - CI 6618
ms.reviewer: revaldiv, leiaglezer, julienp
---
# Resolve issues with port orders

When you submit a port order request to [port phone numbers to Microsoft Teams Calling Plans](/microsoftteams/phone-number-calling-plans/transfer-phone-numbers-to-teams), Microsoft sends the request to the carrier that currently owns the phone numbers. The carrier will either approve or reject the port order.

If your order is rejected, the carrier sends Microsoft a reason for the rejection. This reason is reflected in the [status of the order](/microsoftteams/phone-number-calling-plans/transfer-phone-numbers-to-teams?tabs=new-porting-wizard#whats-the-status-of-your-port-orders).

- If the status of the order is **Customer action required**, you can fix the issue by following the steps in this article.
- If the order status is **Microsoft support engaged**, Microsoft takes over handling the order. This can happen for various reasons, such as complex issues that need additional support or cases where you've chosen to have Microsoft manage the order.

## Status: Customer Action Required

When the status of your port order request is **Customer Action Required**, it's displayed in a banner at the top of the port order details page along with the following message:

> Your order was rejected by your current carrier. Please click update to fix and resubmit your order.

Select the **Update** button next to this message. In the porting wizard that opens, you'll see the description of the error that caused the carrier to reject your order. Fix the error as appropriate and resubmit the port order.

### Letter of Authorization field errors

If the error description indicates that a specific field in your port order doesn't have the required information, check the corresponding field in your Customer Service Record (CSR) with your current carrier. If required, contact the carrier to request a copy of your CSR.

|Error Description|Recommended Action|
|-|-|
|The account number provided doesn't match the record of your current service provider. Please contact your current provider and check your current documentation, update your account number, and then resubmit your order. |Update the **Account number** field in the port order to match the corresponding value in the CSR.|
|The provided authorized user doesn't match the current carrier's authorized user on file. Please contact your current provider and check your current documentation, update the authorized user, and then resubmit your order. |Update the **First name** and **Last name** fields in the **Authorized user details** section in the port order to match the corresponding values in the CSR.|
|The provided organization name doesn't match the organization name that the current carrier has on file. Please contact your current provider and check your current documentation, update the organization name, and then resubmit your order. |Update the **Organization's name** field in the port order to match the corresponding value in the CSR.|
|The provided PIN is missing or incorrect. Please contact your current provider and check your current documentation, update the PIN, and then resubmit your order. |Update the **Account PIN** field in the port order to match the corresponding value in the CSR.|
|The provided zip code or service address doesn't match what your current carrier has on file. Please contact your current provider and check your current documentation, update the service address, and then resubmit your order. |Update the **Service address** section in the port order to match the corresponding value in the CSR.|
|Your Letter of Authorization (LOA) is missing. Please upload the correct LOA associated with this order and resubmit your order. |Update the **Letter of Authorization** section in the port order as appropriate.|

### Account related errors

If there's an error that's related to your account with the carrier, contact the carrier to resolve the issue and then resubmit your port order through the port wizard.

|Error Description|Recommended Action|
|-|-|
|There's a freeze on your porting phone numbers. A freeze is a feature offered by your current carrier to ensure telephone numbers aren't inadvertently ported. Please contact your current provider to unblock the freeze and then resubmit your order.|Contact the carrier to unblock the freeze and then resubmit your order.|

## Status: Microsoft Support Engaged

When the status of your port order request is listed as **Microsoft Support Engaged**, there's no action that you need to take, and Microsoft Support will resolve the issue on your behalf. If required, a Microsoft Support professional will contact you. The scenarios that Microsoft Support handles are:

- You requested additional support on your order.
- Your order requires additional review with Microsoft Support before submission.
- Your order faced a rejection from the carrier that requires Microsoft Support to resubmit the order on your behalf.
- There's a submission error that requires Microsoft Support to resubmit your order on your behalf.

## Request assistance with your port order

If you need help with updating your port order, you can create a ticket in the [Phone number Service Center](https://pstnsd.powerappsportals.com/). If you've already created a ticket, use that ticket to contact a Support professional.

To check for an active ticket for a specific port order, use the following steps:

1. In the Microsoft Teams admin center, navigate to **Voice** > **Phone numbers** on the left navigation menu.
2. Select the **Order history** tab.
3. Select a port order entry to see its details.
4. On the page about the details of the port order, look for a link to a ticket.
