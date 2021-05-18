---
title: Use GP to control access to web sites
description: Helps you to use Windows Group Policy to control access to web sites.
ms.date: 10/19/2020
author: Deland-Han 
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Managing Internet Explorer settings through Group Policy
ms.technology: windows-server-group-policy
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
