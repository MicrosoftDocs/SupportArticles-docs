---
title: Export Root Certification Authority Certificate
description: describes how to export Root Certification Authority Certificate.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-certificate-services, csstroubleshoot
---
# How to export Root Certification Authority Certificate

This article describes how to export Root Certification Authority Certificate.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 555252

## Tips

1. Requesting the Root Certification Authority Certificate by using command line:

    1. Log into the Root Certification Authority server with Administrator Account.
    2. Go to **Start** > **Run**. Enter the text **Cmd** and then select **Enter**.
    3. To export the Root Certification Authority server to a new file name **ca_name.cer**, type:

        ```console
        certutil -ca.cert ca_name.cer
        ```

2. Requesting the Root Certification Authority Certificate from the Web Enrollment Site:

    1. Log on to Root Certification Authority Web Enrollment Site.

        Usually the Web Enrollment Site resides in the following links:

        http://\<ip_address>/certsrv

        or

        http://\<fqdn>/certsrv

        `ip_address` = Root Certification Authority Server IP.

        `fqdn` = Fully qualified domain name of the Root Certification Authority Server.

    2. Select **Download a CA certificate, certificate chain, or CRL**.
    3. Select **Download CA certificate**.
    4. Save the file "**certnew.cer**" in local disk store.

[!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]
