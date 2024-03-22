---
title: Remote Desktop server certificates are renewed two times daily
description: Solves an issue where the Remote Desktop server certificates are renewed two times a day despite being valid for one year.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Certificates and Public Key Infrastructure (PKI)\Certificate Enrollment Technologies (Auto Enrollment, NDES, CWE, CEP, CES), csstroubleshoot
---
# Remote Desktop server certificates are renewed two times a day despite being valid for one year

This article provides a solution to an issue where the Remote Desktop server certificates are renewed two times a day despite being valid for one year.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2531138

## Symptoms

Consider the following scenario:

- You want to enable a Remote Desktop server to provide server authentication by using a Secure Sockets Layer (SSL) certificate.
- You configure a certificate template for Remote Desktop servers. To do this, you follow the settings that are described in the following link:

    [Configuring Remote Desktop certificates](https://techcommunity.microsoft.com/t5/microsoft-security-and/configuring-remote-desktop-certificates/ba-p/247007)

In this scenario, you find that the servers are re-requesting and re-enrolling the certificates two times daily. This occurs even though the certificate template is valid for one year. Additionally, when the re-enrollment of the certificate occurs, some events are logged in the System log.

Additionally, if you have these enrolled certificates automatically published to Active Directory, the size of the Active Directory database will increase significantly because of the constant re-enrollment of the certificate. And, the Active Directory replication may pause and report warning events.

## Cause

The underlying cause of this behavior is related to the RDS component and to a mismatch within the certificate template. Specifically, if the template name and template display name are different, the RDS service does not match the existing certificate to the template, and the RDS service periodically enrolls a new certificate.

## Resolution

To resolve this problem, you must set the certificate template's attribute's template display name and template name to the same value, such as RemoteDesktopComputer. This procedure is suggested in [Security](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771869(v=ws.10)).

Then, you must update the GPO setting Computer Configuration\Policies\Administrative Templates\Windows Components\Terminal Services\Terminal Server\Security\Server Authentication Certificate Template based on the new template name, such as RemoteDesktopComputer. After the server receives the new GPO setting during the processing of the background GPO redraw, the certificates are no longer renewed on a twice-daily basis.

> [!IMPORTANT]
> You must set the certificate template's attributes Template Display Name and Template Name to the same value.
