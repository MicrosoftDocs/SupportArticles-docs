---
title: Use GP to control access to web sites
description: Helps you to use Windows Group Policy to control access to web sites.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:managing-internet-explorer-settings-through-group-policy, csstroubleshoot
---
# How to use Group Policy to control access to web sites

This article helps you to use Windows Group Policy to control access to web sites.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 556044

## Tips

> [!NOTE]
> Using the instructions bellow don't provide a full management solutions.  
For large company/company with special security requirements, consider to use central management solution, like Microsoft ISA Server.

1. Create new GPO (Group Policy Object).

2. Under the new GPO, navigate to: **User Configuration\Windows Settings\Internet Explorer Maintenance\Connection\Connection**.

3. Double-click on **Proxy Settings**.

4. Mark the checkbox **Enable proxy settings**.

5. Under **Address of proxy**, write the host name of the local proxy (In case that you don't have a proxy server, write a 0.0.0.0 as the Server IP).

6. Under **Exceptions**, write the web site that you allow access to (To use multiple web site names, add **;** between each web site name.

7. Press on **Ok** button, and close the MMC.

8. Apply the new GPO to the required OU/Domain.

[!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Group Policy issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-group-policy.md).
