---
title: Nintex workflow on SharePoint Online fails to start
description: Describes an issue in which the Nintex workflow for SharePoint Online fails to start, with the error Oops.
author: prbalusu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: v-matham
ms.custom: 
- CSSTroubleshoot
- CI 146979
appliesto:
- SharePoint Online
---

# Nintex workflow on SharePoint Online fails to start

## Symptoms

When you try to run the Nintex workflow on SharePoint Online, you encounter the error:

>Oops.. Something went wrong. Please visit status.nintex.com for the latest Nintex service status or contact your system administrator to check the health of your Office 365 tenancy.

:::image type="content" source="./media/nintex-workflow-fails-to-start/nintex-error.png" alt-text="Image of error displaying in a browser window":::

## Cause

The SharePoint setting **DisableCustomAppAuthentication** is enabled. This setting is enabled by default for new tenants created after August 25, 2020.

## Resolution

In the SharePoint Online Management Shell, run the following command to verify that DisableCustomAppAuthentication is set to True:

`Get-SPOTenant | select DisableCustomAppAuthentication`

After verifying that it’s set to True, set it to False using the following command:

`Set-SPOTenant -DisableCustomAppAuthentication $false`

If it’s set to False when you check it, or setting it to False doesn’t resolve the issue, contact Nintex support or check their support community post: [Error "Oops... something went wrong. Please visit status.nintex.com for the latest status or contact your sysadmin to check the health of your Office 365 tenancy"](https://community.nintex.com/t5/Technical-Issues/Error-quot-Oops-something-went-wrong-Please-visit-status-nintex/ta-p/89612).

### Third-party information disclaimer

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.