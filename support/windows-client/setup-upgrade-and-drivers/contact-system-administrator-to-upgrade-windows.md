---
title: Fail to upgrade Windows 10 Enterprise edition
description: Describes an error that's returned when you run the Windows 10 update tool and provides a solution to this issue.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, scottmca
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# Error during Windows 10 upgrade: Contact your system administrator to upgrade Windows Server or Enterprise Editions

This article provides help to fix an error that occurs during Windows 10 upgrade: Contact your system administrator to upgrade Windows Server or Enterprise Editions.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 3188105

## Symptoms

When you run the updater tool from the [Get the anniversary Update Now](https://go.microsoft.com/fwlink/p/?linkid=821403) link at [Windows 10 update history](https://support.microsoft.com/help/4018124/windows-10-update-history), you receive the following error message:

> Windows 10 will not run on this PC  
Operating system: "Contact your system administrator to upgrade Windows Server or Enterprise Editions"

## Cause

The tool works only with the Windows 10 Home, Pro, and Education editions. If you're running the Windows 10 Enterprise edition, you receive the error message.

## Resolution

To resolve this issue, use a different method to upgrade to Windows 10 version 1607. For example, download the ISO, and then run Setup from it.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
