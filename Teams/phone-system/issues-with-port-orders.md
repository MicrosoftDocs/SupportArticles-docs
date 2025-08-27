---
title: Resolve Issues That Affect Port Orders
description: Provides resolutions to common issues that occur when you submit a port order.
ms.date: 08/14/2025
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
# Resolve issues that affect port orders

When you submit a port order request to [port phone numbers to Microsoft Teams Calling Plans](/microsoftteams/phone-number-calling-plans/transfer-phone-numbers-to-teams), Microsoft sends the request to the carrier that currently owns the phone numbers. The carrier either approves or rejects the port order.

If your order is rejected, the carrier sends Microsoft a reason for the rejection. This reason is reflected in the [status of the order](/microsoftteams/phone-number-calling-plans/transfer-phone-numbers-to-teams?tabs=new-porting-wizard#whats-the-status-of-your-port-orders).

- If the status of the order is **Customer action required**, you can fix the issue by following the steps in this article.
- If the status of the order is **Microsoft support engaged**, Microsoft takes over handling the order. This status occurs for various reasons other than a rejection. For example, complex issues might require additional support, or you might choose to have Microsoft manage the order.

## Status: Customer action required

If the status of your port order request is **Customer action required**, this status appears in a banner at the top of the port order details page together with the following message:

> Your order was rejected by your current carrier. Please click update to fix and resubmit your order.

Select the **Update** button next to this message. In the wizard that appears, you’ll see the description of the error that caused the carrier to reject your order. Fix the error as appropriate and resubmit the port order.

### Errors related to fields in the Letter of Authorization (LOA)

If the error description indicates that a specific field in the LOA is missing[MK1.1] or has incorrect information, verify the corresponding field in your Customer Service Record (CSR) at your current carrier. If necessary, contact the carrier to request a copy of your CSR. 

|Error description|Recommended action|
|-|-|
|The account number provided doesn't match the record of your current service provider. Please contact your current provider and check your current documentation, update your account number, and then resubmit your order. |Update the **Account number** field in the port order to match the corresponding value in the CSR.|
|The provided authorized user doesn't match the current carrier's authorized user on file. Please contact your current provider and check your current documentation, update the authorized user, and then resubmit your order. |Update the **First name** and **Last name** fields in the **Authorized user details** section in the port order to match the corresponding values in the CSR. Additionally, the LOA must be signed by the authorized user.|
|The provided organization name doesn't match the organization name that the current carrier has on file. Please contact your current provider and check your current documentation, update the organization name, and then resubmit your order. |Update the **Organization's name** field in the port order to match the corresponding value in the CSR.|
|The provided PIN is missing or incorrect. Please contact your current provider and check your current documentation, update the PIN, and then resubmit your order. |Update the **Account PIN** field in the port order to match the corresponding value in the CSR.|
|The provided zip code or service address doesn't match what your current carrier has on file. Please contact your current provider and check your current documentation, update the service address, and then resubmit your order. |Update the **Service address** section in the port order to match the corresponding value in the CSR.|
|Your Letter of Authorization (LOA) is missing. Please upload the correct LOA associated with this order and resubmit your order. |Update the **Letter of Authorization** section in the port order as appropriate.|

### Errors related to you account

If the error is related to your account with the carrier, contact the carrier to resolve the issue. 

|Error description|Recommended action|
|-|-|
|There's a freeze on your porting phone numbers. A freeze is a feature offered by your current carrier to ensure telephone numbers aren't inadvertently ported. Please contact your current provider to unblock the freeze and then resubmit your order.|Contact your current provider to unblock the freeze, and then resubmit your order.|

## Status: Microsoft support engaged

If the status of your port order request is listed as Microsoft support[MK6.1][MK6.2] engaged, there is no action for you to take. Microsoft Support[MK7.1][LA7.2] will resolve the issue on your behalf and will contact you, as appropriate. The scenarios that Microsoft Support handles are: 

- You requested additional support for your order.
- Your order requires additional review with Microsoft Support before submission.
- Your order was rejected by the carrier and must be resubmitted by Microsoft Support on your behalf.
- A submission error occurred. Microsoft Support must resubmit the order on your behalf.

## Request assistance for your port order

If you need help to update your port order, create a support ticket in the [Phone number Service Center](https://pstnsd.powerappsportals.com/). If you've already created a ticket, use that ticket to contact a Support agent.

If your order status is **Microsoft support engaged**, a support ticket is already created for you. Check that ticket to avoid creating a duplicate ticket.

To search for an active ticket for a specific port order, follow these steps:

1. In the Microsoft Teams admin center, in the left pane, navigate to **Voice** > **Phone numbers**.
2. Select the **Order history** tab.
3. Select a port order entry to see its details.
4. On the details page for the port order, look for a link to a ticket.
