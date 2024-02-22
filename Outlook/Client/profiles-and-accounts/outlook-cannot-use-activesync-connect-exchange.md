---
title: Outlook can't use ActiveSync to connect Exchange
description: Discusses that Outlook doesn't support a connection to Exchange by using the Exchange ActiveSync protocol. Log onto Exchange ActiveSync mail server (EAS) The server cannot be found error occurs. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
search.appverid: MET150
ms.date: 10/30/2023
---
# Outlook doesn't support connections to Exchange by using ActiveSync and error: Log onto Exchange ActiveSync mail server (EAS)

_Original KB number:_ &nbsp;2859522

## Symptoms

When you configure Microsoft Outlook to connect to Microsoft Exchange by using the Exchange ActiveSync (EAS) protocol, you receive the following error message:

> Log onto Exchange ActiveSync mail server (EAS): The server cannot be found.

## Cause

This problem occurs because Outlook doesn't support connections to a server that's running Exchange Server by using the EAS protocol.

## Resolution

To resolve this problem, connect to Exchange by using the standard Exchange connection settings. For more information about how to configure Outlook to connect to Exchange, see [Add an email account to Outlook](https://support.office.com/article/add-an-email-account-to-outlook-6e27792a-9267-4aa4-8bb6-c84ef146101b?ocmsassetID=HA102823161&CorrelationId=778d1d8d-9ac2-449b-9624-1268559fa794).

## More information

The EAS protocol provides access to data in Exchange mailboxes to various devices and other clients. Outlook supports the use of EAS to connect to other services that support the EAS protocol. Because an EAS connection doesn't provide all the features of a standard connection to Exchange, Outlook doesn't support this method to connect to Exchange.
