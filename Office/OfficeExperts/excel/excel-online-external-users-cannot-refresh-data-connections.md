---
title: External users can't refresh data connections from Excel Online
description: One or more data connections in this workbook can't be refreshed or Failed to update the data connections when external users refresh a workbook from Excel Online
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - Open\DataRefresh
  - sap:office-experts
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: warrenr
appliesto: 
  - Excel Online
ms.date: 06/06/2024
---

# External users can't refresh data connections from Excel Online

This article was written by [Ricardo Rocha](https://social.technet.microsoft.com/profile/Ricardo+R.+-+MSFT), Escalation Engineer.

## Symptoms

You're using a Microsoft Excel workbook that contains an Excel Power Pivot Model with external data connections. Currently, the data refresh in Excel Online is working without any issues for the internal users of the organization tenant.

However, when you share this Excel workbook with external users of the tenant, the users can't refresh the file from Excel Online. Additionally, they may receive an error message that resembles as follows:

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
