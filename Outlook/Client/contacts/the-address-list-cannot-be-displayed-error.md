---
title: The address list can't be displayed error
description: Fixes an issue in which you can't view the contacts of a public folder in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:People or Contacts\Resolving email addresses and ambiguous name resolution
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# The address list cannot be displayed error when you try to view the contacts of a public folder in Outlook

_Original KB number:_ &nbsp; 4020049

## Symptoms

When you try to select a public folder that contains contacts from the address book list in Microsoft Outlook 2016, Outlook 2019 or Outlook for Microsoft 365, you receive the following error message even if you have permissions to read all objects of the folder:

> The address list cannot be displayed. The Contacts folder associated with this address list could not be opened; it may have been moved or deleted, or you do not have permissions. For information on how to remove this folder from the Outlook Address Book, see Microsoft Outlook Help.

## Resolution

This issue may occur if the `ExcludeHttpsAutoDiscoverDomain` value under the following `Autodiscover` subkey is set to **1**:

`HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\AutoDiscover\`

In this situation, set the value to **0**, and then restart Outlook 2016, Outlook 2019, or Outlook for Microsoft 365 to fix the issue.

Additionally, this issue can occur if any of the `Autodiscover` endpoints is blocked or if Outlook can't find the `Autodiscover` information. You can use one of the following methods to test the `Autodiscover` connectivity:

- **For on-premises users**: [Microsoft remote connectivity analyzer](https://testconnectivity.microsoft.com/tests/o365)
- **For Microsoft 365 users**: [About Microsoft Support and Recovery Assistant](https://support.microsoft.com/office/about-the-microsoft-support-and-recovery-assistant-e90bb691-c2a7-4697-a94f-88836856c72f)

## References

- [Unexpected `Autodiscover` behavior when you have registry settings under the \`Autodiscover` key](/outlook/troubleshoot/profiles-and-accounts/unexpected-autodiscover-behavior)
- [Outlook 2016 Implementation of `Autodiscover`](https://support.microsoft.com/help/3211279/outlook-2016-implementation-of-autodiscover)
