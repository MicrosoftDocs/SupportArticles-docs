---
title: Nintex workflow on SharePoint Online does not start
description: Describes an issue in which the Nintex workflow for SharePoint Online does not start and you receive an error message.
author: helenclu
ms.author: luche
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: prbalusu
ms.custom: 
  - CSSTroubleshoot
  - CI 146979
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Nintex workflow on SharePoint Online does not start

## Symptoms

When you try to run the Nintex workflow on SharePoint Online, you receive the following error message:

>Oops.. Something went wrong. Please visit status.nintex.com for the latest Nintex service status or contact your system administrator to check the health of your Microsoft 365 tenancy.

:::image type="content" source="./media/nintex-workflow-fails-to-start/nintex-error.png" alt-text="Screenshot that shows the error displaying in a browser window.":::

## Cause

This error occurs because the **DisableCustomAppAuthentication** SharePoint setting is enabled. By default, this setting is enabled for new tenants that were created after August 25, 2020.

## Resolution

In the SharePoint Online Management Shell, run the following command to verify that **DisableCustomAppAuthentication** is set to **True**:

`Get-SPOTenant | select DisableCustomAppAuthentication`

If this setting is set to **True**, set it to **False** by running the following command:

`Set-SPOTenant -DisableCustomAppAuthentication $false`

If the setting is set to **False** when you check it, or if setting the value to **False** doesn't resolve the issue, contact Nintex support or check [the Nintex support community post about this error](https://community.nintex.com/t5/Technical-Issues/Error-quot-Oops-something-went-wrong-Please-visit-status-nintex/ta-p/89612).

### Third-party information disclaimer

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

### Third-party contact disclaimer

Microsoft provides third-party contact information to help you find additional information about this topic. This contact information may change without notice. Microsoft does not guarantee the accuracy of third-party contact information.
