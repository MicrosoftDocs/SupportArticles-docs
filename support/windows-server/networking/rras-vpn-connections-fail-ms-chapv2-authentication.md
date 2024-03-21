---
title: VPN connections fail when using the MS-CHAPv2 authentication
description: VPN connections to a Windows RAS Server fail when using the MS-CHAPv2 authentication. Provides a resolution.
ms.date: 12/26/2023
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, BrCaton
ms.custom: sap:Network Connectivity and File Sharing\Remote access (VPN, RRAS, CMAK and AOVPN), csstroubleshoot
---
# VPN connections fail when using MS-CHAPv2

This article resolves the issue that VPN connections to a Windows RRAS Server fail when using the MS-CHAPv2 authentication.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2811487

## Symptoms

VPN connections to a Windows RRAS Server fail when using the MS-CHAPv2 authentication method. Other symptoms include the end user may receive an error message like this one:

> error 691 "The remote connection was denied because the user name and password combination you provided is not recognized, or the selected authentication protocol is not permitted on the remote access server.

Additionally, the domain user's bad password count can increment, resulting in an account lockout.

## Cause

This issue can occur when the [LmCompatibilityLevel](/previous-versions/windows/it-pro/windows-2000-server/cc960646(v=technet.10)) settings on the authenticating DC have been modified from the defaults.

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\LmCompatibilityLevel`

For example, when you set this value to **5** (Send NTLMv2 response only. Refuse LM & NTLM), the DC won't accept any requests that use NTLM authentication. When MS-CHAP or MS-CHAPv2 are configured, RAS in Windows Server 2008 R2 will default to NTLM to hash the password. Because the DC only accepts NTLMv2, the request will be denied.

> [!NOTE]
> Other tests you can perform to confirm this issue include:
>
> - Test a clear text method such as PAP. As the password is not hashed authentication should succeed  
> (WARNING: PAP authentication should be used for testing only)
> - Test MS-CHAPv2 by using credentials configured locally on the RAS server. Because no request is sent to the DC in this scenario, authentication should succeed.

## Resolution

If you must use MS-CHAPv2, you can enable NTLMv2 authentication by adding this registry entry:

1. Select **Start** > **Run**, type *regedit* in the **Open** box, and then select **OK**.
2. Locate and select the following registry subkey:  
   `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\RemoteAccess\Policy`
3. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
4. Type *Enable NTLMv2 Compatibility*, and then press ENTER.
5. On the **Edit** menu, select **Modify**.
6. In the **Value data** box, type *1*, and then select **OK**.
7. Exit Registry Editor.

> [!NOTE]
> You may need to reload NPS services on the NPS Server or the Radius Server.
