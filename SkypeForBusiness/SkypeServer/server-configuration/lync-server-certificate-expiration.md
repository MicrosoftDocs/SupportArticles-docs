---
title: Prevent Lync Server certificate expiration
description: Describes how to prevent Lync Server certificate expiration.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: skype-for-business-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: miadkins
ms.custom: CSSTroubleshoot
appliesto:
- Lync Server 2010 Standard Edition
- Lync Server 2010 Enterprise Edition
- Lync Server 2010
- Group ChatLync Server 2013
---

# Preventing Lync Server certificate expiration

## Summary

A Lync Server Certificate is about to expire in a few days:
- An expired certificate will cause the Lync Server services to not start   
- An expired certificate may communication between Lync Server Server roles to fail

## More Information

There are two way to locate information about the certificate that is associated with the Lync Server server

**Method 1: Using Lync Server Deployment Wizard**

**Note** You can also request a certificate from an internal CA, or assign an existing certificate from this wizard.

1. Launch the Lync Server Deployment Wizard from the Windows Start menu on the Lync Server server   
2. Click on “Install or Update Lync Server System”   
3. Click run on Step 3: Request, Install or Assign Certificates   
4. Use the Certificate Wizard to view all the certificates that are installed for the Lync Server server    

**Method 2: Using Lync Management Shell**

Use the PowerShell cmdlet Get-CsCertificate to locate information about the certificate associated with the Lync Server server

> [!NOTE]
> To view all properties on the certificate objects returned to see the SAN's. Use with a "Get-CsCertificate | fl –property * cmdlet

For more information on Get-CsCertificate cmdlet please refer the following document:

[Get-CsCertificate](https://technet.microsoft.com/library/gg398227.aspx )

To request a certificate using the Lync Management Shell use the Request-CsCertificate cmdlet.

For more information on Request-CsCertificate cmdlet please refer the following document:

[Request-CsCertificate](https://technet.microsoft.com/library/gg425723.aspx)

To import a certificate using Lync Management Shell use the Import-CsCertificate cmdlet.

For more information on Import-CsCertificate cmdlet please refer the following document:

[Import-CsCertificate](https://technet.microsoft.com/library/gg398688.aspx)

To assign a certificate using Lync Management Shell use the Set-CsCertificate cmdlet.

For more information on Set-CsCertificate cmdlet please refer the following document:

[Set-CsCertificate](https://technet.microsoft.com/library/gg398518.aspx )
