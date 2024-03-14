---
title: You can't access SharePoint Online sites by using a domain that's configured for full redelegation
description: Describes an issue in which you can't access SharePoint Online sites by using a domain that's configured for full redelegation.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Cannot access SharePoint Online sites by using a domain that's configured for full redelegation

## Problem

When you try to access a SharePoint Online site by using a domain that's configured for full redelegation, the SharePoint Online site can't be accessed.

## Solution

Full domain redelegation involves a domain where the name server (NS) resource records point to Microsoft 365. To resolve this issue, follow these steps:

1. Verify that the NS resource records point to Microsoft 365. To do this, use the NSlookup tool. For more information about NSlookup, see [Using NSlookup.exe](https://support.microsoft.com/help/200525).

   The NS resource records should point to two of the following:

   ns1.bdm.microsoftonline.com
   ns2.bdm.microsoftonline.com
   ns3.bdm.microsoftonline.com
   ns4.bdm.microsoftonline.com

2. If the domain was recently configured for full domain redelegation, wait 72 hours. Make sure that the SharePoint Online domain is configured from the Microsoft 365 portal Domain management page. The SharePoint Online site should be accessed by using the address that is specified in **Your SharePoint website address is**. Click **Change Address** if the SharePoint website address is not set to your domain. If you do change this value, wait 24 hours. Then, you can access by using "www" preappended to the address. For example, if your domain is *contoso.com*, then you can access your SharePoint Online site as http://www.*contoso*.com.

3. Perform DNS lookup on the www CNAME record for your domain. The record should resemble the following:

   www CNAME <*domain*>.sharepoint.com

   - Host/alias: www
   - Target/Destination: *domain*.sharepoint.com

   In this example, *domain* is the verified domain (for example, *contoso.com*).

4. If the NS records and the www CNAME records are correct, perform the usual SharePoint Online access troubleshooting.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
