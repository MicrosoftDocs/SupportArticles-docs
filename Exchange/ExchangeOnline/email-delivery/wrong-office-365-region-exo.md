---
title: ATTR35 response code when mail is sent to EOP/EXO
description: Mail sent to EOP or EXO is deferred with the ATTR35 temporary response code.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Online
  - CSSTroubleshoot
manager: dcscontentpm
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
  - Exchange Online Protection
ms.date: 01/24/2024
ms.reviewer: v-six
---
# ATTR35 response code when mail is sent to EOP/EXO

## Symptoms

Mail that you sent to an Exchange Online Protection (EOP) or Exchange Online (EXO) recipient is deferred, and you receive the following error message:

> 451 4.4.62 Mail sent to the wrong Office 365 region. ATTR35.

## Cause

The attempted mail delivery to Microsoft 365 used an MX record or smart host that contained an incorrect destination value for Microsoft 365.

## Resolution

1. If you route mail from your on-premises environment to Microsoft 365 through an SMTP relay (for example, on-premises mailboxes, multifunction devices, or email sending applications), verify the following settings:

   - If you use Exchange in your on-premises environment, verify that the smart host value in the Send connector that routes mail to Microsoft 365 does **not** use *mail.messaging.microsoft.com*, *mail.global.frontbridge.com*, or a Microsoft 365 IP address.
   - If you use servers or devices to route mail directly to or through Microsoft 365, verify that the smart host values do **not** use mail.messaging.microsoft.com, mail.global.frontbridge.com, or Microsoft 365 IP addresses. For more information, refer to options 2 and 3 in [How to set up a multifunction device or application to send email using Microsoft 365](https://support.office.com/article/how-to-set-up-a-multifunction-device-or-application-to-send-email-using-office-365-69f58e99-c550-4274-ad18-c805d654b4c4).
   - If you have to fix your smart host settings (because it was using one of the incorrect values that are specified in the first bullet item), we recommend that you use your initial domain as the smart host. The initial domain is in the format **\<GUID\>.onmicrosoft.com**, where *\<GUID\>* is a unique value that's provided to every organization as part of their enrollment in the service. Your initial domain is listed in the Microsoft 365 admin center at **Setup** -> **Domains** or in the Exchange admin center (EAC) at **Mail flow** -> **Accepted domains**.

        > [!NOTE]
        > If your server or device cannot do an MX lookup, you should use \<GUID\>.mail.protection.outlook.com, where \<GUID\> is uniquely assigned to your Microsoft 365 initial domain.
   - If you are still seeing the ATTR35 error after you verify smart host and DNS settings, your servers or devices are probably sending mail outside of your organization without a properly configured Microsoft 365 Inbound Connector. In this case, you must configure the additional settings as described in Option 3 of [How to set up a multifunction device or application to send email using Microsoft 365](https://support.office.com/article/how-to-set-up-a-multifunction-device-or-application-to-send-email-using-office-365-69f58e99-c550-4274-ad18-c805d654b4c4). This is because you cannot use Option 2 to send external to your organization. To use Option 3 to relay mail from your servers or devices through Microsoft 365, make sure that your Inbound connectors in Microsoft 365 contain the correct sending certificate name or SAN that is in use by that server or device, or the correct sending IP address of the sending server or device.

2. Check any other services that route mail directly to your Microsoft 365 organization (for example, if you're using another provider for spam filtering). Verify that the smart host values do **not** use *mail.messaging.microsoft.com*, *mail.global.frontbridge.com*, or Microsoft 365 IP addresses. If you need to fix the smart host settings, use your initial domain as described earlier.
3. If the MX record for your domain points to Microsoft 365, verify that the record has the correct value, and remove any legacy values that are no longer supported.

   1. In the Microsoft 365 admin portal for your organization, select **Setup** -> **Domains**.
   2. For every domain in your Microsoft 365 organization, verify that your published MX records do **not** contain the value *mail.messaging.microsoft.com* or *mail.global.frontbridge.com*.
   3. If you have to fix your MX record (because it was using one of the legacy values that is mentioned in step 2), use the format **\<GUID\>.mail.protection.outlook.com**, where *\<GUID\>* is uniquely assigned to each of your Microsoft 365 domains. For example, if your domain is contoso.com, use the value **contoso-com.mail.protection.outlook.com** in the MX record. If your domain is contoso.net, use the value **contoso-net.mail.protection.outlook.com** in the MX record.

        > [!NOTE]
        > We recommend that you have only one MX record for each Microsoft 365 domain. Multiple MX records for a domain can help in some delivery scenarios. However, Microsoft 365 already has extreme redundancy at every level. Therefore, multiple MX records can actually make mail delivery less reliable.
