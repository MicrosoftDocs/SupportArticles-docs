---
title: LT2P/IPsec RAS VPN connections fail
description: L2TP/IPsec VPN connections to a Windows RAS Server fail when using the MS-CHAPv2 authentication. Provides a resolution.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, BrCaton
ms.prod-support-area-path: Remote access
ms.technology: networking
---
# LT2P/IPsec RAS VPN connections fail when using MS-CHAPv2

This article provides a resolution for the issue that L2TP/IPsec VPN connections to a Windows RAS Server fail when using the MS-CHAPv2 authentication.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2811487

## Symptoms

L2TP/IPsec VPN connections to a Windows RAS Server fail when using the MS-CHAPv2 authentication method. Other symptoms experienced may include the end user will typically receive an error message similar to the following:

> error 691 "The remote connection was denied because the user name and password combination you provided is not recognized, or the selected authentication protocol is not permitted on the remote access server.

Additionally, the domain user's bad password count can increment, resulting in an account lockout.

## Cause

This can occur when the [LmCompatibilityLevel](/previous-versions/windows/it-pro/windows-2000-server/cc960646(v=technet.10)) settings on the authenticating DC have been modified from the defaults.

`HKLM\SYSTEM\CurrentControlSet\Control\Lsa\LmCompatibilityLevel`

For example, if you set this value to **5** (Send NTLMv2 response only. Refuse LM & NTLM), then the DC will not accept any requests that use NTLM authentication. RAS in Windows Server 2008 R2 default to NTLM to hash the password when MS-CHAP or MS-CHAPv2 are configured. Because the DC will only accept NTLMv2, the request will be denied.

> [!NOTE]
> Additional tests you can perform to confirm this is the issue include:
>
> - Test a clear text method such as PAP. As the password is not hashed authentication should succeed  
> (WARNING: PAP authentication should be used for testing only)
> - You can also test MS-CHAPv2 using credentials configured locally on the RAS server. Because there is no request sent to the DC in this scenario, authentication should succeed.

## Resolution

If for whatever reason you must use MS-CHAPv2, you can enable NTLMv2 authentication is RAS by adding this registry entry:

1. Select **Start**, select **Run**, type *regedit* in the **Open** box, and then select **OK**.
2. Locate and then select the following registry subkey:  
   `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\RemoteAccess\Policy`
3. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
4. Type *Enable NTLMv2 Compatibility*, and then press ENTER.
5. On the **Edit** menu, select **Modify**.
6. In the **Value data** box, type *1*, and then select **OK**.
7. Quit Registry Editor.
