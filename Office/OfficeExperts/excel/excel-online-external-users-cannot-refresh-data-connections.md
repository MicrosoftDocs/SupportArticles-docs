---
title: External users cannot refresh data connections from Excel Online
description: One or more data connections in this workbook can not be refreshed or Failed to update the data connections when external users refresh a workbook from Excel Online
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.custom: CSSTroubleshoot
ms.service: o365-solutions
ms.topic: article
ms.author: warrenr
appliesto:
- Excel Online
---

# External users cannot refresh data connections from Excel Online

This article was written by [Ricardo Rocha](https://social.technet.microsoft.com/profile/Ricardo+R.+-+MSFT), Escalation Engineer.

## Symptoms

You're using a Microsoft Excel workbook that contains an Excel Power Pivot Model with external data connections. Currently, the data refresh in Excel Online is working without any issues for the internal users of the organization tenant.

However, when you share this Excel workbook with external users of the tenant, the users cannot refresh the file from Excel Online. Additionally, they may receive an error message that resembles the following:

**An error occurred while working on the data model in the workbook. Try again.**
**One or more data connections in this workbook can not be refreshed.**

Or

**An error occurred while working with the data model in the book. Try again.
Failed to update the data connections in this book.
The failure occurred when the following connections were updated.**

## Cause

Currently, the data refresh operation in Excel Online doesn't support external users of a tenant.

## Workaround

To work around this issue, the users can open the file from the Excel client application, and then refresh the data source from there.