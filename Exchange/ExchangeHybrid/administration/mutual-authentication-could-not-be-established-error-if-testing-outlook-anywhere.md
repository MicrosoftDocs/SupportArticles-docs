---
title: Mutual Authentication could not be established error when testing Outlook Anywhere
description: Describes an issue in which the Remote Connectivity Analyzer tool displays an error message when you use it to test the Outlook Anywhere feature in a Microsoft 365 environment. Provides a resolution.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- Exchange Online
search.appverid: MET150
ms.reviewer: v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/24/2024
---
# "Mutual Authentication could not be established" error when using Remote Connectivity Analyzer to test Outlook Anywhere in Microsoft 365

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard. For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Symptoms

> [!NOTE]
> The following scenario only applies to Microsoft 365 customers who have a hybrid deployment of on-premises Exchange Server and Exchange Online.

When you use the Microsoft Remote Connectivity Analyzer tool to test the Outlook Anywhere feature in a Microsoft 365 environment, the tool displays the following error message:

> Mutual Authentication could not be established.

Additionally, a user may experience the following symptoms:

- The user is repeatedly prompted for credentials and can't connect to Exchange Online by using Outlook Anywhere.
- The user receives the following error message when using Outlook 2010 or Outlook 2007 to create the Outlook profile automatically:

  > An encrypted connection to your mail server is not available. Click Next to attempt using an unencrypted connection.

## Cause

This issue occurs if one or more of the following conditions are true:

- The common name does not match the mutual authentication (msstd:) string that's entered in the Remote Connectivity Analyzer tool.
- The mutual authentication string is valid. However, the `CertPrincipalName` attribute for the EXPR OutlookProvider object that's stored in Active Directory is invalid.

> [!NOTE]
> The mutual authentication string equates to the **Only connect to proxy servers that have this principal name in their certificate** setting in the Exchange proxy settings in Outlook.

## Resolution

To resolve this issue, follow these steps:

1. View the web server certificate that's installed on the hybrid server, and confirm the common name to which the certificate was issued (for example, `mail.contoso.com`).
2. Open the Exchange proxy settings in Outlook, and check that the fully qualified domain name (FQDN) in the **Mutual Authentication Principal Name** field is entered correctly (for example, msstd: `mail.contoso.com`).

3. If it's necessary, run the following cmdlet by using Exchange Management Shell to change the `CertPrincipalName` attribute:

    ```ps
    Set-OutlookProvider EXPR -CertPrincipalName:"msstd:mail.contoso.com"
    ```

## More information

The Remote Connectivity Analyzer tool negotiates a Secure Sockets Layer (SSL) connection to the remote host to retrieve various properties on X509 certificates. The tool evaluates the `Subject` attribute to identify the FQDN or common name that was assigned to the certificate (for example, `mail.contoso.com`).

For more information about the principal names, see [Principal Names](/windows/win32/rpc/principal-names).

For more information about Outlook providers, see:

- [The Autodiscover Service and Outlook Providers - how does this stuff work?](https://techcommunity.microsoft.com/t5/exchange-team-blog/the-autodiscover-service-and-outlook-providers-how-does-this/ba-p/584403)
- [Set-OutlookProvider](/powershell/module/exchange/set-outlookprovider)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).
