---
title: Outlook connectivity issues when SPI is enabled
description: Provides a workaround for an issue in which Microsoft 365 users experience connectivity issues in Outlook if stateful packet inspection (SPI) is enabled on the router.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: chwillia, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Outlook connectivity issues when stateful packet inspection (SPI) is enabled on the router

> [!IMPORTANT]
> This article contains information that shows how to help lower security settings or how to turn off security features on a computer. You can make these changes to work around a specific problem. Before you make these changes, we recommend that you evaluate the risks that are associated with implementing this workaround in your particular environment. If you implement this workaround, take any appropriate additional steps to help protect the computer

_Original KB number:_ &nbsp; 2862523

## Symptoms

When Microsoft 365 users use Microsoft Outlook, they experience the following symptoms:

- Outlook disconnects
- Messages stay in the Outbox and aren't sent. However, if the user restarts Outlook, Outlook reconnects to the server, and messages are sent.

These symptoms typically occur after the user uses Outlook for 15 or 20 minutes without experiencing any other issues. Additionally, if the user takes one or more of the following actions, the issue is not resolved:

- The user re-creates the Outlook profile.
- The user reinstalls or repairs Outlook.
- The user uses Outlook on a different computer.

## Cause

This issue can occur if the user is using a router that has stateful packet inspection (SPI) enabled.

## Workaround

> [!WARNING]
> This workaround may make a computer or a network more vulnerable to attack by malicious users or by malicious software such as viruses. We do not recommend this workaround but are providing this information so that you can implement this workaround at your own discretion. Use this workaround at your own risk.

To work around this issue, disable SPI on the Internet connection router. For information about how to do this, contact the router manufacturer. Be aware that this is only a temporary workaround and is not a permanent solution for this issue.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
