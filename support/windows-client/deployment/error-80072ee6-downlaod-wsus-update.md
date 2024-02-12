---
title: 80072EE6 error code when you download an update
description: Resolve the 80072EE6 error code that occurs when you download an update from Windows Server Update Services.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:servicing, csstroubleshoot
---
# You receive a 80072EE6 error code when you download an update from Windows Server Update Services

This article helps resolve the 80072EE6 error code that occurs when you download an update from Windows Server Update Services.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2724184

## Symptoms

Consider the following scenario:

- You have a computer that is running Windows
- You configure Windows Server Update Services (WSUS) over the Group Policy 'Specify intranet Microsoft update service location'.
- While trying to perform Windows Update, the update operation may fail. Additionally, you receive the following error code:

    > 80072EE6

## Cause

This issue occurs if the URL under the Group Policy setting 'Specify intranet Microsoft update service location' is invalid.

For Example, `corp.contoso.com` or an IPaddress is invalid.

## Resolution

To resolve this issue, follow steps below:

1. Click on Start and then type gpedit.msc.
2. Go to `Computer Configuration\Administrative Templates\Windows Components\Windows Update\`.
3. From the right-side pane, double-click on Specify intranet Microsoft update service location to open it.
4. Verify that the URL includes `http://` or `https://`. For Example, `http://corp.contoso.com` or `https://corp.contoso.comNote`.

## More information

The above group policy setting lets you specify a server on your network to function as an internal update service. Automatic Updates will search this service for updates that apply to the computers on your network.

To use this setting, you must set two server name values: the server from which Automatic Updates detects and downloads updates, and the server to which updated workstations upload statistics. You can set both values to be the same server.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
