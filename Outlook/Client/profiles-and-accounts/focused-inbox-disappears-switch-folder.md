---
title: Focused Inbox disappears when you switch folders in Outlook
description: When you switch from the inbox to other folders, the Focused Inbox option disappears. Follow this article to fix this issue.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CI 114555
  - CSSTroubleshoot
ms.reviewer: geob
appliesto: 
  - Outlook for Microsoft 365
search.appverid: 
  - MET150
ms.date: 10/30/2023
---

# Focused Inbox disappears when you switch folders in Outlook

## Symptoms

You set up a Microsoft 365 account in Microsoft Outlook. When you switch from the **Inbox** to other folders, such as the **Sent Items** folder, and then you return to **Inbox**, the **Focused Inbox** option disappears. Additionally, the option on the **View** tab to turn on or off the **Focused Inbox** also disappears.

## Cause

This issue occurs because the Autodiscover process that's used by Outlook did not retrieve the XML from Microsoft 365, and received an unexpected result from a third-party web server that uses IMAP settings from either `https://<Rootdomain>/autodiscover/autodiscover.xml` or `https://autodiscover.<Rootdomain>/autodiscover/autodiscover.xml`.

Typically in this situation, the lookup fails and Outlook eventually performs an Autodiscover lookup against `https://outlook.office365/AutoDiscover/AutoDiscover.xml`. However, because Outlook receives a successful Autodiscover response that has IMAP settings, it marks the account as a non-Microsoft 365 account, and then stores the Autodiscover URL as the Last Known Good URL in the profile.

To verify you're experiencing this issue, use [Microsoft Remote Connectivity Analyzer](https://testconnectivity.microsoft.com/) to test the Outlook Autodiscover process, and then search the text in the test results for the "IMAP" text string. Typically, "IMAP" doesn't appear in the test results unless a third-party web server is responding to Autodiscover requests.

For more information about the Autodiscover service, see [How the Autodiscover service works](/Exchange/architecture/client-access/autodiscover?redirectedfrom=MSDN&view=exchserver-2019#works&preserve-view=true).

## Resolution

Contact your web service provider or the web hosting provider of your domain website to make sure that the web server isn't responding to the following Autodiscover requests:

- `https://<Rootdomain>/autodiscover/autodiscover.xml`
- `https://autodiscover.<Rootdomain>/autodiscover/autodiscover.xml`.

## Workaround

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To work around this issue, exclude the Last Known Good URL by setting the **ExcludeLastKnownGoodURL** registry key as follows.

|Type|Value|
|---------|---------|
|Registry subkey    |`HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\Outlook\AutoDiscover`         |
|Value Name      |`ExcludeLastKnownGoodURL`         |
|Value Type      |REG_DWORD         |
|Value Data     |1         |

For more information about how to set this registry key, see [Unexpected Autodiscover behavior](unexpected-autodiscover-behavior.md).

> [!IMPORTANT]
> Because excluding the Last Known Good URL isn't a long-term solution for this issue, Microsoft don't recommend it. This workaround is provided as immediate relief for the issue. As soon as the web service provider or web hosting provider fixes the issue, this Outlook registry key must be removed.
