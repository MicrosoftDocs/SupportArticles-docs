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
ms.technology: GroupPolicy
---
# How to use Group Policy to control access to web sites

This article helps you to use Windows Group Policy to control access to web sites.

_Original product version:_ &nbsp; Windows Server 2003  
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

## Community Solutions Content Disclaimer

Microsoft corporation and/or its respective suppliers make no representations about the suitability, reliability, or accuracy of the information and related graphics contained herein. All such information and related graphics are provided "as is" without warranty of any kind. Microsoft and/or its respective suppliers hereby disclaim all warranties and conditions with regard to this information and related graphics, including all implied warranties and conditions of merchantability, fitness for a particular purpose, workmanlike effort, title, and non-infringement. You specifically agree that in no event should microsoft and/or its suppliers be liable for any direct, indirect, punitive, incidental, special, consequential damages or any damages whatsoever including, without limitation, damages for loss of use, data or profits, arising out of or in any way connected with the use of or inability to use the information and related graphics contained herein, whether based on contract, tort, negligence, strict liability or otherwise, even if microsoft or any of its suppliers has been advised of the possibility of damages.