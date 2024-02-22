---
title: Can't add an attachment in Outlook on the web
description: Provides a resolution for the issue where users can't add attachments and receive an error message in Outlook on the web.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: hafizk, jmartin, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Service Pack 1
search.appverid: MET150
ms.date: 01/24/2024
---
# Error when adding a large attachment in Outlook on the web

_Original KB number:_ &nbsp;2957856

## Symptoms

Users who are connected to a mailbox by using Outlook on the web (formally known as Outlook Web App or OWA) can't add an attachment to an email message. Additionally, the users receive one of the following error messages:

> The following files couldn't be attached: Filename. Please try again later.

> The following files weren't attached because adding them would cause the message to exceed the maximum size limit of 10 MB: filename.

## Cause

This issue occurs because the attachment exceeds the message size limit. The default maximum message size for an attachment is 10 megabytes (MB).

## Resolution

To resolve this issue, follow these steps:

1. Increase the maximum message size for the organization by using the `Set-TransportConfig` cmdlet.
2. Increase the maximum message size for the Send connectors by using the `Set-SendConnector` cmdlet.
3. Increase the maximum message size for the Receive connectors by using the `Set-ReceiveConnector` cmdlet.
4. Increase the following settings in the OWA Web.config file:
   - **maxAllowedContentLength** (value in bytes)
   - **maxReceivedMessageSize** (value in bytes)
   - **maxStringContentLength** (value in bytes)
   - **maxRequestLength** (value in kilobytes)
5. Increase the following settings in the EWS web.config file:
   - **maxAllowedContentLength** (value in bytes)
   - **maxReceivedMessageSize** (value in bytes)
6. Stop and then restart the **MSExchangeOWAAppPool** application pool.
7. Stop and then restart the **MSExchangeServicesAppPool** application pool.
8. Restart IIS on the Exchange server by using either of the following methods:

   - Open IIS Manager, select the server, and in the **Actions** pane, click **Restart**.

   - Run the following commands from an elevated command prompt (a Command Prompt window you open by selecting **Run as administrator**):

     ```console
     net stop w3svc /y
     ```

     ```console
     net start w3svc
     ```

> [!NOTE]
> Steps 3-6 must be performed in both of the following locations:
>
> - The Client Access server on which the Web.config files are located under *%ExchangeInstallPath%\FrontEnd\HttpProxy*.
> - The Mailbox server on which the Web.config files are located under *%ExchangeInstallPath%\ClientAccess*.

## More information

For more information about client-specific message size limits, see the following articles:

- [Configure Client-Specific Message Size Limits on Client Access Servers](/exchange/configure-client-specific-message-size-limits-exchange-2013-help)
- [Configure client-specific message size limits](/exchange/architecture/client-access/client-message-size-limits)

