---
title: Configure a certificate-based connector to relay email messages through Microsoft 365
description: Describes scenarios that requires you to take action before February 1, 2017 to prevent interruptions to mail flow.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Configure a certificate-based connector to relay email messages through Microsoft 365

## Introduction

If your organization has a hybrid deployment (on-premises plus Microsoft 365), you frequently have to relay email messages to the Internet through Microsoft 365. That is, messages that you send from your on-premises environment (mailboxes, applications, scanners, fax machines, and so on) to Internet recipients are first routed to Microsoft 365, and then sent out.

:::image type="content" source="./media/office-365-notice/email-routing.png" alt-text="Figure shows email relayed from your on-premises email servers to the Internet through Microsoft 365." border="false":::

Figure: Email relayed from your on-premises email servers to the Internet through Microsoft 365

For this relay to work correctly, your organization must follow these steps:

1. Create one or more connectors in Microsoft 365 to authenticate email messages from your on-premises mail servers by using either the sending IP address or a certificate.
2. Configure your on-premises servers to relay through Microsoft 365.
3. Configure your setup so that either of the following conditions is true:

    - **Sender domain**

        The sender domain belongs to your organization (that is, you have registered your domain in Microsoft 365).

        **Note** For more information, see [Add User and Domain in Microsoft 365](/microsoft-365/admin/setup/add-domain).
    - **Certificate-based connector configuration**

       Your on-premises email server is configured to use a certificate to send email to Microsoft 365, and the Common-Name (CN) or Subject Alternate Name (SAN) in the certificate contains a domain name that you have registered in Microsoft 365, and you have created a certificate-based connector in Microsoft 365 that has that domain.

If neither of the conditions in step 3 is true, Microsoft 365 can't determine whether the message that was sent from your on-premises environment belongs to your organization. Therefore, if you use hybrid deployments, you should make sure that you meet either of the step 3 conditions.

## Summary

Beginning July 5, 2017, Microsoft 365 no longer supports relaying email messages if a hybrid environment customer has not configured their environment for either of the step 3 conditions. Such messages are rejected and trigger the following error message:  

> 550 5.7.64 Relay Access Denied ATTR36. For more information, see [KB 3169958](https://support.microsoft.com/kb/3169958).

Additionally, you must meet the second condition ("certificate-based connector configuration") in step 3 in the [Introduction](#introduction) section if your organization requires that any of the following scenarios continue to work after July 5, 2017.

> [!NOTE]
> The original deadline for this new process was moved from February 1, 2017, to July 5, 2017, to provide sufficient time for customers to implement the changes.

### Scenarios in which Microsoft 365 doesn't support relaying email messages by default

- Your organization has to send non-delivery reports (NDRs) from the on-premises environment to a recipient on the Internet, and it has to relay the messages through Microsoft 365. For example, somebody sends an email message to john@contoso.com, a user who used to exist in your organization's on-premises environment. This causes an NDR to be sent to the original sender.
- Your organization has to send messages from the email server in your on-premises environment from domains that your organization hasn't added to Microsoft 365. For example, your organization (contoso.com) sends email as the fabrikam.com domain, and fabrikam.com doesn't belong to your organization.
- A forwarding rule is configured on your on-premises server, and messages are relayed through Microsoft 365.

    For example, contoso.com is your organization's domain. A user on your organization's on-premises server, kate@contoso.com, enables forwarding for all messages to kate@tailspintoys.com. When john@fabrikam.com sends a message to kate@contoso.com, the message is automatically forwarded to kate@tailspintoys.com.

    From the point of view of Microsoft 365, the message is sent from john@fabrikam.com to kate@tailspintoys.com. Because Kate's mail is forwarded, neither the sender domain nor the recipient domain belongs to your organization.
  
:::image type="content" source="./media/office-365-notice/forwarded-message.png" alt-text="Figure shows a forwarded message from contoso.com that's allowed to be relayed through Microsoft 365." border="false":::

Figure: A forwarded message from contoso.com that's allowed to be relayed through Microsoft 365 because the step 3 "certificate-based connector configuration" condition is met

## More information

You can set up a certificate-based connector for Microsoft 365 to relay messages to the Internet. To do this, use the following method.

### Step 1: Create or change a certificate-based connector in Microsoft 365

To create or change a certificate-based connector, follow these steps:

1. Sign in to the Microsoft 365 portal ([https://portal.office.com](https://portal.office.com)), click **Admin**, and then open the Exchange admin center. For more information, see [Exchange admin center in Exchange Online](/exchange/exchange-admin-center).

    :::image type="content" source="./media/office-365-notice/exchange-admin-center.png" alt-text="Screenshot shows steps to open the Exchange admin center.":::
2. Click **mail flow**, click **connectors**, and then do one of the following:

    - If there are no connectors, click :::image type="icon" source="./media/office-365-notice/plus-shape.png"::: (**Add**) to create a connector.

        :::image type="content" source="./media/office-365-notice/add-connector.png" alt-text="Screenshot shows there are no connectors in the Exchange admin center, click Add icon likes plus shape to create a connector.":::
    - If a connector already exists, select it, and then click :::image type="icon" source="./media/office-365-notice/pen-shape.png"::: (**Edit**).

        :::image type="content" source="./media/office-365-notice/edit-connector.png" alt-text="Screenshot shows selecting the connector in the Exchange admin center, and then clicking Edit icon likes pen shape.":::

3. On the **Select your mail flow scenario** page, select **Your organization's email server** in the **From** box, and then select **Microsoft 365** in the **To** box.

    > [!NOTE]
    > This creates a connector that indicates that your on-premises server is the sending source for your messages.

    :::image type="content" source="./media/office-365-notice/mail-flow-scenario.png" alt-text="Screenshot of the Select your mail flow scenario page, which selects your organization's email server in the From box, and then selects Microsoft 365 in the To box." border="false":::
4. Enter the connector name and other information, and then click **Next**.
5. On the **New connector** or **Edit connector** page, select the first option to use a Transport Layer Security (TLS) certificate to identify the sender source of your organization's messages. The domain name in the option should match the CN name or SAN in the certificate that you're using.

    > [!NOTE]
    > This domain must be a domain that belongs to your organization, and you have to have added it to Microsoft 365. For more information, see [Add Domains in Microsoft 365](/microsoft-365/admin/setup/add-domain).

    For example, Contoso.com belongs to your organization, and it's part of the CN name or SAN name in the certificate that your organization uses to communicate with Microsoft 365. If the domain in the certificate contains multiple domains (such as mail1.contoso.com, mail2.contoso.com), we recommend that the domain in the connector UI be *.contoso.com.

    > [!NOTE]
    > Existing hybrid customers who used the Hybrid Configuration Wizard to configure their connectors should check their existing connector to make sure that it uses, for example, ***.contoso.com** instead of **mail.contoso.com** or **\<hostname>.contoso.com**. This is because **mail.contoso.com** and **\<hostname>.contoso.com** may not be registered domains in Microsoft 365.

    :::image type="content" source="./media/office-365-notice/new-connector.png" alt-text="Figure shows an example of setting up the connector to use the contoso.com format." border="false":::

    Figure: Setting up the connector to use the "contoso.com" format (for example)
  
### Step 2: Register your domain in Microsoft 365

To register your domain, follow the steps in the following Office article:

[Add users and domain to Microsoft 365](/microsoft-365/admin/setup/add-domain)

In the Microsoft 365 Admin Center, click **Setup**, and then click **Domains** to see the list of domains that are registered.

:::image type="content" source="./media/office-365-notice/register-domain.png" alt-text="Screenshot shows steps to see the registered domains.":::

### Step 3: Configure your on-premises environment

To configure your on-premises environment, follow these steps:

1. If your organization uses Exchange Server for its on-premises server, configure the server to send messages over TLS. To do this, see [Set up your email server to relay mail to the Internet via Microsoft 365](/exchange/mail-flow-best-practices/use-connectors-to-configure-mail-flow/set-up-connectors-to-route-mail#2-set-up-your-email-server-to-relay-mail-to-the-internet-via-microsoft-365-or-office-365).

    > [!NOTE]
    > If you've already used Hybrid Configuration Wizard, you can continue to use it. However, make sure that you use a certificate that matches the criteria that's outlined in Step 1, sub-step 5 of this section.
2. Install a certificate in your on-premises environment. To do this, see [Step 6: Configure an SSL certificate](/Exchange/plan-and-deploy/post-installation-tasks/configure-mail-flow-and-client-access#step-6-configure-an-ssl-certificate).

## References

For more information about how to address the connector setting requirement, see [Important connector notice](https://blogs.technet.microsoft.com/exchange/2016/03/29/important-notice-for-office-365-email-customers-who-have-configured-connectors/).

For more information about how to relay messages through Microsoft 365, see the "[Setting up mail flow where some mailboxes are in Microsoft 365 and some mailboxes are on your organization's mail servers](/exchange/mail-flow-best-practices/mail-flow-best-practices#bkmk_hybridmailflowbestpractices)" section of [Mail flow best practices for Exchange Online and Microsoft 365](/exchange/mail-flow-best-practices/mail-flow-best-practices).

Still need help? Go to[Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
