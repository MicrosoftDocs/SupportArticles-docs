---
title: Use custom certificate for TLS over RDS
description: Describes how to for RDS to use a custom server authentication certificate for TLS.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, mjacquet
ms.custom: sap:certificate-management, csstroubleshoot
---
# Force Remote Desktop Services in Windows 7 to use a custom server authentication certificate for TLS

This article provides a solution to an issue where a self-signed server authentication certificate is automatically generated to support Transport Layer Security (TLS) when you make a Remote Desktop Services (RDS) connection to a Windows 7 computer.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2001849

## Symptoms

When making a RDS connection to a Windows 7 computer, a self-signed server authentication certificate is automatically generated to support TLS. This allows the data to be encrypted between computers. Data is only encrypted when the following Group Policy setting is enabled on the target computer and set to **SSL (TLS 1.0)**:

`Computer Configuration\Administrative Templates\Windows Components\Remote Desktop Services\Remote Desktop Session Host\Security:Require use of specific security layer for remote (RDP) connections`

## Cause

The generation of self-signed certificates for TLS over a RDS connection is enabled by design in Windows Vista and Windows 7.

## Resolution

Server authentication certificates are supported in Windows Vista and Windows 7. To use a custom certificate for RDS, follow the steps below:

1. Install a server authentication certificate from a certification authority.

2. Create the following registry value containing the certificate's SHA1 hash to configure this custom certificate to support TLS instead of using the default self-signed certificate.

    - Location: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp`
    - Value name:  SSLCertificateSHA1Hash
    - Value type:  REG_BINARY
    - Value data: \<certificate thumbprint>

    The value should be the thumbprint of the certificate separated by comma (,) and no empty spaces. For example, if you were to export that registry key the **SSLCertificateSHA1Hash** value would look like this:

    SSLCertificateSHA1Hash=hex:42,49,e1,6e,0a,f0,a0,2e,63,c4,5c,93,fd,52,ad,09,27,82,1b,01

    It is necessary to edit the registry directly because there is no user interface on Windows client SKUs to configure a server certificate.

3. The Remote Desktop Host Services service runs under the NETWORK SERVICE account. Therefore, it is necessary to set the ACL of the key file used by RDS (referenced by the certificate named in the SSLCertificateSHA1Hash registry value) to include NETWORK SERVICE with Read permissions. To modify the permissions, follow these steps:  

    Open the **Certificates** snap-in for the local computer:  

    1. Click **Start**, click **Run**, type **mmc**, and click **OK**.
    2. On the **File** menu, click **Add/Remove Snap-in**.
    3. In the **Add or Remove Snap-ins** dialog box, in the **Available snap-ins** list, click **Certificates**, and click **Add**.
    4. In the **Certificates** snap-in dialog box, click **Computer account**, and click **Next**.
    5. In the **Select Computer** dialog box, click **Local computer: (the computer this console is running on)**, and click **Finish**.
    6. In the **Add or Remove Snap-ins** dialog box, click **OK**.
    7. In the **Certificates** snap-in, in the console tree, expand **Certificates (Local Computer)**, expand **Personal**, and navigate to the SSL certificate that you would like to use.
    8. Right-click the certificate, select **All Tasks**, and select **Manage Private Keys**.
    9. In the **Permissions** dialog box, click **Add,** type **NETWORK SERVICE**, click **OK,**  select **Read** under the **Allow** checkbox, then click **OK**.

## More information

For more information about how to programmatically configure the RDP encryption settings, see [Win32_TSGeneralSetting class](/windows/win32/termserv/win32-tsgeneralsetting).
