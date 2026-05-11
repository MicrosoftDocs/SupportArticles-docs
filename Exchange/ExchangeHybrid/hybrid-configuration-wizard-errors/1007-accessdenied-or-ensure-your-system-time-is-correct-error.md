---
title: 1007 AccessDenied or Unable to federate your domain error
description: Describes an issue in which you receive an Access Denied or Ensure your system time is correct error message when you run the Hybrid Configuration wizard and provides a solution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
- sap:Hybrid
- Exchange Hybrid
- CSSTroubleshoot
- CI 162000
ms.reviewer: timothyh, v-six
appliesto:
- Exchange Online
- Exchange Server SE
search.appverid: MET150
ms.date: 05/11/2026
---
# "1007 AccessDenied" or "Ensure your system time is correct" error when you run Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3107293

## Symptoms

When you run the Hybrid Configuration wizard, you receive one of the following error messages:

> Set-FederatedOrganizationIdentifier': An error occurred while attempting to provision Exchange to the Partner STS. Detailed Information "An unexpected result was received from Windows Live. Detailed information: "1007 AccessDenied: Access Denied.".".

> Unable to federate your domain, your system time appears to be more than five minutes out of sync with the time on our federation servers. Ensure your system time is correct and retry the Hybrid Configuration Wizard.

## Cause

This problem occurs because the local system time is out of sync with a valid time server. The system time of your local system and the system time of the server from which you're running the Hybrid Configuration wizard differ by five minutes or more.

## Resolution

Make sure that your local system time and the server time are in sync. See [How to configure an authoritative time server in Windows Server](https://support.microsoft.com/help/816042) for more information.
