---
title: Fix NDR error 5.4.6 or 5.4.14 in Exchange Online
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: v-six
audience: Admin
ms.topic: troubleshooting
ms.localizationpriority: medium
f1.keywords:
- CSH
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 167832
search.appverid:
- BCS160
- MOE150
- MET150
ms.assetid: 81212ae4-4c36-4e8f-9546-e58b70cfd74b
description: Learn how to fix email issues for error code 5.4.6, 5.4.14, or other error codes related to mail routing loops in Exchange Online.
---

# Fix NDR error 5.4.6 or 5.4.14 in Exchange Online

It's frustrating when you get an error after sending an email message. This topic describes what you can do if see the error codes 5.4.6, 5.4.14 or other error codes related to mail routing loops in a non-delivery report (also known as an NDR, bounce message, delivery status notification, or DSN).

## Why did I get this bounce message?

The most likely cause is the message hop count being exceeded or the route through which the  message is delivered being broken. Some causes and solutions are provided in this topic.

5.4.6 indicates a mail loop or routing problem in on-premises Exchange Server, which you would likely encounter in a hybrid environment.

5.4.14 indicates a mail loop or routing problem in Exchange Online.

 The information here applies to a range of error codes 5.4.6 through 5.4.20. Use the information in the NDR to help you decide how to fix the problem.

|&nbsp;|&nbsp;|&nbsp;|&nbsp;|
|---|---|---|---|
|:::image type="icon" source="media/email-user-icon.png":::|[I got this bounce message. How do I fix it?](#i-got-this-bounce-message-how-do-i-fix-it)|:::image type="icon" source="media/email-admin-icon.png":::|[I'm an email admin. How do I fix this issue?](#im-an-email-admin-how-do-i-fix-this-issue)|

## I got this bounce message. How do I fix it?

Typically, these issues can only be fixed by an Exchange Online admin and not the average email sender. Contact your email admin and refer them to this information so they can try to resolve the issue for you.

## I'm an email admin. How do I fix this issue?

The most common issues and fixes are described in the following sections.

### Accepted domain issues

Verify that the recipient's domain is configured as an authoritative accepted domain in Exchange Online. For more information, see [Manage accepted domains in Exchange Online](/exchange/mail-flow-best-practices/manage-accepted-domains/manage-accepted-domains).

### Hybrid configuration issues

If your domain is part of a hybrid deployment between Exchange and Exchange Online, check the following items based on your configuration.

#### You route all incoming mail for your hybrid domain through Exchange Online

This error can happen when the MX record for your hybrid domain points to Exchange Online, and the connector that's used to route email from Exchange Online to your on-premises Exchange organization is configured to use DNS routing instead of smart host routing.

To fix the problem, configure a dedicated connector to be used for hybrid. This connector will use smart host routing and will have your on-premises hybrid server configured as a smart host. The easiest way to fix the problem is to rerun the Hybrid Configuration Wizard in your on-premises Exchange organization. Or, you can verify the configuration of the connector that's used for hybrid by following these steps:

##### New EAC

1. Open the [Microsoft 365 admin center](https://admin.microsoft.com), and then click **Admin centers** \> **Exchange** (you might need to click **...show all** first). The New EAC screen appears.

2. In the Exchange admin center (EAC), click **Mail Flow** \> **Connectors**. 

3. Select the connector that's used for hybrid, and then click it.

    The connector properties screen appears.

4. Under **Routing**, click **Edit routing**. The **Routing** screen appears.

   :::image type="content" source="media/fix-error-code-5-4-6-through-5-4-20-in-exchange-online/connector-for-hybrid-new-eac.png" alt-text="Routing emails using hybrid connectors in New EAC.":::

5. Ensure that the correct IP address or FQDN is specified for the smart host in your on-premises Exchange organization.

##### Classic EAC

1. Open the [Microsoft 365 admin center](https://admin.microsoft.com), and then click **Admin centers** \> **Exchange** (you might need to click **...show all** first).

2. Click **Classic Exchange admin center** on the left pane of the New EAC screen.

    > [!NOTE]
    > You can go to the Classic EAC screen only from the New EAC screen.

3. Click **mail flow** on the left pane. The **mail flow** home screen appears.

4. Click the **connectors** tab. 

5. Select the connector that's used for hybrid, and click **Edit** :::image type="icon" source="media/edit-icon.png":::.

6. Go to **How do you want to route email messages** screen.

   :::image type="content" source="media/fix-error-code-5-4-6-through-5-4-20-in-exchange-online/routing-through-smart-hosts-old-eac.png" alt-text="Routing emails using hybrid connectors in Old EAC.":::

7. Ensure that the correct IP address or FQDN is specified for the smart host in your on-premises Exchange organization.

#### You route all outgoing mail from Exchange Online through your on-premises hybrid server

This configuration is controlled by the value of the _RouteAllMessagesViaOnPremises_ parameter on the connector that's used for hybrid. When the value of this parameter is `$true`, you're routing all outgoing mail from Exchange Online through your on-premises hybrid server. You can verify this value by replacing \<Connector Name\> with your value and running the following command in [Exchange Online PowerShell](/powershell/exchange/exchange-online-powershell):

```powershell
Get-OutboundConnector -Identity "<Connector Name>" | Format-List Name,RouteAllMessagesViaOnPremises
```

In this configuration, the error is caused by either of the following issues on the connector from your on-premises Exchange organization to Exchange Online:

- You don't have a connector (from Office 365 to your organization's email server) that has the **Connector Type** value **On-premises**.
- The connector from Office 365 to your organization's email server is scoped to one or more accepted domains.

To fix the problem, configure a dedicated connector (from Office 365 to your organization's email server) that has the **Connector Type** value *On-premises** and that's not scoped to any accepted domains. The easiest way to fix the problem is to rerun the Hybrid Configuration Wizard in the on-premises Exchange organization. Or, you can verify the configuration of the connector (from Office 365 to your organization's email server) that is used for hybrid by following these steps:

1. Open the [Microsoft 365 admin center](https://admin.microsoft.com), and then click **Admin centers** \> **Exchange** (you might need to click **...show all** first).

2. In the EAC, click **Mail Flow** \> **Connectors**.

3. Select the connector that's used for hybrid, and then click **Edit** :::image type="icon" source="media/edit-icon.png":::. Verify the following information:
   - **General**: Verify that the **On-premises** option is selected.
   - **Scope**: Verify that the  **Accepted domains** option is empty with no data.

For more information about mail routing in hybrid deployments, see [Transport routing in Exchange hybrid deployments](/exchange/transport-routing).

## Causes for NDR 5.4.14 and what does this error mean?

There are two likely possibilities:

- Based on the domain in the recipient's email address, your Exchange Online organization accepted the message, but then couldn't correctly route the message to the recipient. This failure is likely caused by accepted domain configuration issues.
- In hybrid environments, there are misconfigured connectors in your Exchange Online organization.

### Details about NDRs related to hop count exceeded

Here are some of the error codes that are related to mail routing loops or a bad mail routing configuration:

- `554 5.4.6 Hop count exceeded - possible mail loop` (always generated by on-premises Exchange Servers)
- `5.4.14 Hop count exceeded - possible mail loop ATTR34` (always generated by Exchange Online)

## Still need help?

[:::image type="icon" source="media/community-forum-icon.png":::](https://answers.microsoft.com/)

[:::image type="icon" source="media/create-service-request-icon.png":::](https://admin.microsoft.com/AdminPortal/Home#/support)

[:::image type="icon" source="media/call-support-icon.png":::](/microsoft-365/Admin/contact-support-for-business-products)

## See also

[Email non-delivery reports in Exchange Online](non-delivery-reports-in-exchange-online.md)
