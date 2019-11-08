---
title: Important notice for Office 365 email customers who have configured connectors
description: Describes scenarios that requires you to take action before February 1, 2017 to prevent interruptions to mail flow.
author: simonxjx
audience: ITPro
ms.service: exchange-online
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Online
---

# Important notice for Office 365 email customers who have configured connectors

## Notice

If you are an Exchange Online or Exchange Online Protection (EOP) customer, and you have configured connectors, this article contains important information that might affect your organization. To make sure that your mail flow isn’t interrupted, we strongly recommend that you read this article and take any necessary action before the July 5, 2017, deadline.

## Introduction 

If your organization has a hybrid deployment (on-premises plus Microsoft Office 365), you frequently have to relay email messages to the Internet through Office 365. That is, messages that you send from your on-premises environment (mailboxes, applications, scanners, fax machines, and so on) to Internet recipients are first routed to Office 365, and then sent out. 

![email routing](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4011992_en_3)
 
Figure: Email relayed from your on-premises email servers to the Internet through Office 365

For this relay to work correctly, your organization must follow these steps: 
 
1. Create one or more connectors in Office 365 to authenticate email messages from your on-premises mail servers by using either the sending IP address or a certificate.    
2. Configure your on-premises servers to relay through Office 365.    
3. Configure your setup so that either of the following conditions is true: 

    - **Sender domain**

        The sender domain belongs to your organization (that is, you have registered your domain in Office365).

        **Note** For more information, see [Add User and Domain in Office 365](https://docs.microsoft.com/office365/admin/setup/add-domain?redirectSourcePath=%252fen-us%252farticle%252fAdd-your-users-and-domain-to-Office-365-6383f56d-3d09-4dcb-9b41-b5f5a5efd611&view=o365-worldwide).    
    - **Certificate-based connector configuration**

       Your on-premises email server is configured to use a certificate to send email to Office 365, and the Common-Name (CN) or Subject Alternate Name (SAN ) in the certificate contains a domain name that you have registered in Office 365, and you have created a certificate-based connector in Office 365 that has that domain.    
     
If neither of the conditions in step 3 is true, Office 365 can't determine whether the message that was sent from your on-premises environment belongs to your organization. Therefore, if you use hybrid deployments, you should make sure that you meet either of the step 3 conditions. 

## Summary

Beginning July 5, 2017, Office 365 no longer supports relaying email messages if a hybrid environment customer has not configured their environment for either of the step 3 conditions. Such messages are rejected and trigger the following error message:  

**550 5.7.64 Relay Access Denied ATTR36. For more details please refer to [KB 3169958](https://support.microsoft.com/kb/3169958).**   

Additionally, you must meet the second condition ("certificate-based connector configuration") in step 3 in the "Introduction" section if your organization requires that any of the following scenarios continue to work after July 5, 2017. 

> [!NOTE]
> The original deadline for this new process was moved from February 1, 2017, to July 5, 2017, to provide sufficient time for customers to implement the changes. 

### Scenarios in which Office 365 does not support relaying email messages by default

- Your organization has to send non-delivery reports (NDRs) from the on-premises environment to a recipient on the Internet, and it has to relay the messages through Office 365. For example, somebody sends an email message to john@contoso.com, a user who used to exist in your organization's on-premises environment. This causes an NDR to be sent to the original sender.    
- Your organization has to send messages from the email server in your on-premises environment from domains that your organization hasn't added to Office 365. For example, your organization (contoso.com) sends email as the fabrikam.com domain, and fabrikam.com doesn’t belong to your organization.    
- A forwarding rule is configured on your on-premises server, and messages are relayed through Office 365.

    For example, contoso.com is your organization’s domain. A user on your organization’s on-premises server, kate@contoso.com, enables forwarding for all messages to kate@tailspintoys.com. When john@fabrikam.com sends a message to kate@contoso.com, the message is automatically forwarded to kate@tailspintoys.com.

    From the point of view of Office 365, the message is sent from  john@fabrikam.com to  kate@tailspintoys.com. Because Kate’s mail is forwarded, neither the sender domain nor the recipient domain belongs to your organization.    
  
![email forwarding](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4011993_en_2) 
 
Figure: A forwarded message from contoso.com that's allowed to be relayed through Office 365 because the step 3 "certificate-basedconnector configuration" condition is met 

## More information

You can set up a certificate-based connector for Office 365 to relay messages to the Internet. To do this, use the following method.

### Step 1: Create or change a certificate-based connector in Office 365
 
To create or change a certificate-based connector, follow these steps:

1. Sign in to the Office 365 portal ([https://portal.office.com](https://portal.office.com)), click **Admin**, and then open the Exchange admin center. For more information, see [Exchange admin center in Exchange Online](https://docs.microsoft.com/exchange/exchange-admin-center).

    ![admin sign-in](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4011996_en_1)    
2. Click **mail flow**, click **connectors**, and then do one of the following:

    - If there are no connectors, click ![Add icon like plus shape](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4492612_en_1) (**Add**) to create a connector.

        ![add a connector](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4011997_en_1)    
     - If a connector already exists, select it, and then click ![Edit icon like pen shape](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4492614_en_1) (**Edit**).

        ![edit a connector](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4011998_en_1)

3. On the **Select your mail flow scenario** page, select **Your organization’s email server **in the **From** box, and then select **Office 365** in the **To** box.

    > [!NOTE]
    > This creates a connector that indicates that your on-premises server is the sending source for your messages.

    ![select mail flow scenario](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4011999_en_1)    
4. Enter the connector name and other information, and then click **Next**.    
5. On the **New connector** or **Edit connector** page, select the first option to use a Transport Layer Security (TLS) certificate to identify the sender source of your organization’s messages. The domain name in the option should match the CN name or SAN in the certificate that you're using.

    > [!NOTE]
    > This domain must be a domain that belongs to your organization, and you have to have added it to Office 365. For more information, see [Add Domains in Office 365](https://docs.microsoft.com/office365/admin/setup/add-domain?redirectSourcePath=%252fen-us%252farticle%252fAdd-your-users-and-domain-to-Office-365-6383f56d-3d09-4dcb-9b41-b5f5a5efd611&view=o365-worldwide).

    For example, Contoso.com belongs to your organization, and it’s part of the CN name or SAN name in the certificate that your organization uses to communicate with Office 365. If the domain in the certificate contains multiple domains (such as mail1.contoso.com, mail2.contoso.com), we recommend that the domain in the connector UI be *.contoso.com.

    > [!NOTE]
    > Existing hybrid customers who used the Hybrid Configuration Wizard to configure their connectors should check their existing connector to make sure that it uses, for example, ***.contoso.com** instead of **mail.contoso.com** or **\<hostname>.contoso.com**. This is because **mail.contoso.com** and **\<hostname>.contoso.com** may not be registered domains in Office 365.

    ![new connector](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4012000_en_1) 
 
    Figure: Setting up the connector to use the "contoso.com" format (for example)    
  
### Step 2: Register your domain in Office 365

To register your domain, follow the steps in the following Office article: 

[Add users and domain to Office 365](https://docs.microsoft.com/office365/admin/setup/add-domain?redirectSourcePath=%252fen-us%252farticle%252fAdd-your-users-and-domain-to-Office-365-6383f56d-3d09-4dcb-9b41-b5f5a5efd611&view=o365-worldwide)

In the Microsoft 365 Admin Center, click **Setup**, and then click **Domains** to see the list of domains that are registered.

![register domain](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4012001_en_1)

### Step 3: Configure your on-premises environment

To configure your on-premises environment, follow these steps: 
 
1. If your organization uses Exchange Server for its on-premises server, configure the server to send messages over TLS. To do this, see [Set up your email server to relay mail to the Internet via Office 365](https://docs.microsoft.com/exchange/mail-flow-best-practices/use-connectors-to-configure-mail-flow/set-up-connectors-to-route-mail#part2configmail). (This is Part 2.2 of [Set up connectors to route mail between Office 365 and your own email servers](https://docs.microsoft.com/exchange/mail-flow-best-practices/use-connectors-to-configure-mail-flow/set-up-connectors-to-route-mail).)

    > [!NOTE]
    > If you've already used Hybrid Configuration Wizard, you can continue to use it. However, make sure that you use a certificate that matches the criteria that's outlined in Step 1, sub-step 5 of this section.    
2. Install a certificate in your on-premises environment. To do this, see “Step 6: Configure an SSL certificate” in [Configure mail flow and client access](https://docs.microsoft.com/Exchange/plan-and-deploy/post-installation-tasks/configure-mail-flow-and-client-access?view=exchserver-2019).    
 
## References

For more information about how to address the connector setting requirement, see [Important connector notice](https://blogs.technet.microsoft.com/exchange/2016/03/29/important-notice-for-office-365-email-customers-who-have-configured-connectors/). 

For more information about how to relay messages through Office 365, see the "[Setting up mail flow where some mailboxes are in Office 365 and some mailboxes are on your organization’s mail servers](https://docs.microsoft.com/exchange/mail-flow-best-practices/mail-flow-best-practices#bkmk_hybridmailflowbestpractices)" section of [Mail flow best practices for Exchange Online and Office 365](https://docs.microsoft.com/exchange/mail-flow-best-practices/mail-flow-best-practices). 

Still need help? Go to[Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).