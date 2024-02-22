---
title: Federated users can't connect to Exchange Online mailbox
description: Describes an issue in which you can't use your Microsoft 365 federated credentials to authenticate Outlook or Exchange ActiveSync to Exchange Online services.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- Exchange Online
- Exchange
- Outlook
- Azure Active Directory
search.appverid: MET150
ms.reviewer: willfid, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/24/2024
---
# Federated users can't connect to an Exchange Online mailbox

## Symptoms

A federated user can't authenticate to Microsoft Outlook or to Microsoft Exchange ActiveSync by using a smartphone in Exchange Online.

## Cause

This issue can occur if one of the following conditions is true:

- The on-premises Active Directory Federation Services (AD FS) 2.0 federation service isn't available from the public Internet.
- The Secure Sockets Layer (SSL) certificate that's used by the AD FS 2.0 endpoint is issued by a certification authority that isn't trusted by the Exchange Online data center.

The current Exchange Online endpoint for Outlook uses Basic Authentication or Proxy Authentication. This means that Outlook clients authenticate to the Outlook.com service by using Basic Authentication. If Outlook.com determines that the user is a federated user, it proxies the Basic Authentication over SSL to the user's AD FS 2.0 server on behalf of the client. This action authenticates the user locally and requests a Security Assertion Markup Language (SAML) claim or access token for the user. If a publicly available AD FS 2.0 endpoint isn't available, the authentication process isn't successful, and the user is denied access to the service endpoint.

Use Microsoft Remote Connectivity Analyzer to test whether the on-premises AD FS 2.0 federation service is causing Outlook logon problems for federated users. To do this, follow these steps:

1. In Internet Explorer, go to [Microsoft Remote Connectivity Analyzer](https://www.testconnectivity.microsoft.com/tests/o365).
2. Type the email address and credentials, select the **acknowledgment** check box near the bottom of the page, type the verification code, and then select **Perform Test**. This test should be run two times. Run the test by using each of the following credentials:

   - A federated account that has a mailbox in Exchange Online
   - A standard user account that has a mailbox in Exchange Online

   :::image type="content" source="media/federated-users-cannot-connect-to-exchange-online-mailbox/user-account.png" alt-text="Screenshot of the Microsoft Remote Connectivity Analyzer page." border="false":::

3. Check the results of both tests to determine whether AD FS 2.0 is causing the Outlook sign-in issue.

   1. Drill down to the following node of the **Test Details** tree:

      Testing RPC/HTTP connectivity

      - ExRCA is attempting to test Autodiscover for `john@contoso.com`
      - Attempting each method of contacting the Autodiscover service
      - Attempting to contact the Autodiscover service using the HTTP redirect method
      - Attempting to send an Autodiscover POST request to potential Autodiscover URLs
      - ExRCA is attempting to retrieve and XML Autodiscover response from URL `https://autodiscover-s.outlook.com/Autodiscover/Autodiscover.xml` for user

        :::image type="content" source="media/federated-users-cannot-connect-to-exchange-online-mailbox/test-details-tree.png" alt-text="Screenshot of the SSO-enabled mailbox and the standard mailbox test results." border="false":::

   2. Check whether both the following conditions are true:

      - The federated account can't access Autodiscover and receives an "HTTP 401 authorized response" error message.
      - The standard user account can access Autodiscover.

   If both conditions are true, you have confirmed that SSO failures are causing Outlook authentication to fail.

## Resolution 1 - Expose the on-premises AD FS 2.0 federation service to the Internet

Set up an AD FS 2.0 federation server proxy for the on-premises AD FS 2.0 environment (or set up a firewall reverse proxy of the AD FS 2.0 Federation Service) that supports SSO, and then publish the proxy to the Internet.

## Resolution 2 - Troubleshoot problems with the AD FS 2.0 proxy server

For more information about how to troubleshoot AD FS 2.0 proxy server issues, see [How to troubleshoot AD FS endpoint connection issues when users sign in to Microsoft 365, Intune, or Azure](/microsoft-365/troubleshoot/active-directory/ad-fs-endpoint-connection-issue).

Still need help? Go to the [Microsoft Community](https://go.microsoft.com/fwlink/?linkid=2003907) website.
