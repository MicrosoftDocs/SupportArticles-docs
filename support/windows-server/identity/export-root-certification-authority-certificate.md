---
title: Export Root Certification Authority Certificate
description: describes how to export Root Certification Authority Certificate.
ms.date: 09/27/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Active Directory Certificate Services
ms.technology: ActiveDirectory
---
# How to export Root Certification Authority Certificate

This article describes how to export Root Certification Authority Certificate.

_Original product version:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 555252

## Tips

1. Requesting the Root Certification Authority Certificate by using command line:

    1. Log into the Root Certification Authority server with Administrator Account.
    2. Go to **Start** > **Run** >, and type **Cmd** and press on **Enter** button.
    3. To export the Root Certification Authority server to a new file name **ca_name.cer**, type:

        ```console
        certutil -ca.cert ca_name.cer
        ```

2. Requesting the Root Certification Authority Certificate from the Web Enrollment Site:

    1. Log on to Root Certification Authority Web Enrollment Site.

        Usually the Web Enrollment Site resides in following links:

        or

        ip_address = Root Certification Authority Server IP.

        fqdn = Fully qualified domain name of the Root Certification Authority Server.

    2. Click the "**Download a CA certificate,** **certificate chain, or CRL**" link.
    3. Press on "**Download CA certificate**" link.
    4. Save the file "**certnew.cer**" in local disk store.

### Community solutions content disclaimer

Microsoft corporation and/or its respective suppliers make no representations about the suitability, reliability, or accuracy of the information and related graphics contained here. All such information and related graphics are provided "as is" without warranty of any kind. Microsoft and/or its respective suppliers hereby disclaim all warranties and conditions with regard to this information and related graphics, including all implied warranties and conditions of merchantability, fitness for a particular purpose, workmanlike effort, title, and non-infringement. You specifically agree that in no event shall Microsoft and/or its suppliers be liable for any direct, indirect, punitive, incidental, special, consequential damages or any damages whatsoever including, without limitation, damages for loss of use, data or profits, arising out of or in any way connected with the use of or inability to use the information and related graphics contained herein, whether based on contract, tort, negligence, strict liability or otherwise, even if Microsoft or any of its suppliers has been advised of the possibility of damages.
