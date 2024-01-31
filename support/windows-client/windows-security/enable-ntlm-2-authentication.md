---
title: Enable NTLM 2 authentication
description: Describes how to enable NTLM 2 authentication.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:legacy-authentication-ntlm, csstroubleshoot
ms.subservice: windows-security
---
# How to enable NTLM 2 authentication  

This article describes how to enable NTLM 2 authentication.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 239869

## Summary

Historically, Windows NT supports two variants of challenge/response authentication for network logons:

- LAN Manager (LM) challenge/response
- Windows NT challenge/response (also known as NTLM version 1 challenge/response) The LM variant allows interoperability with the installed base of Windows 95, Windows 98, and Windows 98 Second Edition clients and servers. NTLM provides improved security for connections between Windows NT clients and servers. Windows NT also supports the NTLM session security mechanism that provides for message confidentiality (encryption) and integrity (signing).

Recent improvements in computer hardware and software algorithms have made these protocols vulnerable to widely published attacks for obtaining user passwords. In its ongoing efforts to deliver more secure products to its customers, Microsoft has developed an enhancement, called NTLM version 2, that significantly improves both the authentication and session security mechanisms. NTLM 2 has been available for Windows NT 4.0 since Service Pack 4 (SP4) was released, and it is supported natively in Windows 2000. You can add NTLM 2 support to Windows 98 by installing the Active Directory Client Extensions.

After you upgrade all computers that are based on Windows 95, Windows 98, Windows 98 Second Edition, and Windows NT 4.0, you can greatly improve your organization's security by configuring clients, servers, and domain controllers to use only NTLM 2 (not LM or NTLM).

## More information

When you install Active Directory Client Extensions on a computer that is running Windows 98, the system files that provide NTLM 2 support are also automatically installed. These files are Secur32.dll, Msnp32.dll, Vredir.vxd, and Vnetsup.vxd. If you remove Active Directory Client Extension, the NTLM 2 system files are not removed because the files provide both enhanced security functionality and security-related fixes.

By default, NTLM 2 session security encryption is restricted to a maximum key length of 56 bits. Optional support for 128-bit keys is automatically installed if the system satisfies United States export regulations. To enable 128-bit NTLM 2 session security support, you must install Microsoft Internet Explorer 4.x or 5 and upgrade to 128-bit secure connection support before you install the Active Directory Client Extension.

To verify your installation version:

1. Use Windows Explorer to locate the Secur32.dll file in the %SystemRoot%\System folder.
2. Right-click the file, and then click **Properties**.
3. Click the **Version** tab. The description for the 56-bit version is "Microsoft Win32 Security Services (Export Version)." The description for the 128-bit version is "Microsoft Win32 Security Services (US and Canada Only)."  

Before you enable NTLM 2 authentication for Windows 98 clients, verify that all domain controllers for users who log on to your network from these clients are running Windows NT 4.0 Service Pack 4 or later. (The domain controllers can run Windows NT 4.0 Service Pack 6 if the client and server are joined to different domains.) No domain controller configuration is required to support NTLM 2. You must configure domain controllers only to disable support for NTLM 1 or LM authentication.  

### Enabling NTLM 2 for Windows 95, Windows 98, or Windows 98 Second Edition clients

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

To enable a Windows 95, Windows 98, or Windows 98 Second Edition client for NTLM 2 authentication, install the Directory Services Client. To activate NTLM 2 on the client, follow these steps:

1. Start Registry Editor (Regedit.exe).
2. Locate and click the following key in the registry: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control`

3. Create an LSA registry key in the registry key listed above.
4. On the Edit menu, click Add Value, and then add the following registry value:  
    Value Name: LMCompatibility  
    Data Type: REG_DWORD  
    Value: 3  
    Valid Range: 0,3  
    Description: This parameter specifies the mode of authentication and session security to be used for network logons. It does not affect interactive logons.  

      - Level 0 - Send LM and NTLM response; never use NTLM 2 session security. Clients will use LM and NTLM authentication, and never use NTLM 2 session security; domain controllers accept LM, NTLM, and NTLM 2 authentication.  

      - Level 3 - Send NTLM 2 response only. Clients will use NTLM 2 authentication and use NTLM 2 session security if the server supports it; domain controllers accept LM, NTLM, and NTLM 2 authentication.  
   > [!NOTE]
   > To enable NTLM 2 for Windows 95 Clients, install Distributed File System (DFS) Client, WinSock 2.0 Update, and Microsoft DUN 1.3 for Windows 2000.

5. Quit Registry Editor.  

> [!NOTE]
> For Windows NT 4.0 and Windows 2000 the registry key is LMCompatibilityLevel, and for Windows 95 and Windows 98-based computers, the registery key is LMCompatibility.

For reference, the full range of values for the LMCompatibilityLevel value that are supported by Windows NT 4.0 and Windows 2000 include:

- Level 0 - Send LM and NTLM response; never use NTLM 2 session security. Clients use LM and NTLM authentication, and never use NTLM 2 session security; domain controllers accept LM, NTLM, and NTLM 2 authentication.
- Level 1 - Use NTLM 2 session security if negotiated. Clients use LM and NTLM authentication, and use NTLM 2 session security if the server supports it; domain controllers accept LM, NTLM, and NTLM 2 authentication.
- Level 2 - Send NTLM response only. Clients use only NTLM authentication, and use NTLM 2 session security if the server supports it; domain controllers accept LM, NTLM, and NTLM 2 authentication.
- Level 3 - Send NTLM 2 response only. Clients use NTLM 2 authentication, and use NTLM 2 session security if the server supports it; domain controllers accept LM, NTLM, and NTLM 2 authentication.
- Level 4 - Domain controllers refuse LM responses. Clients use NTLM authentication, and use NTLM 2 session security if the server supports it; domain controllers refuse LM authentication (that is, they accept NTLM and NTLM 2).
- Level 5 - Domain controllers refuse LM and NTLM responses (accept only NTLM 2). Clients use NTLM 2 authentication, use NTLM 2 session security if the server supports it; domain controllers refuse NTLM and LM authentication (they accept only NTLM 2).A client computer can only use one protocol in talking to all servers. You cannot configure it, for example, to use NTLM v2 to connect to Windows 2000-based servers and then to use NTLM to connect to other servers. This is by design.

You can configure the minimum security that is used for programs that use the NTLM Security Support Provider (SSP) by modifying the following registry key. These values are dependent on the LMCompatibilityLevel value:

1. Start Registry Editor (Regedit.exe).
2. Locate the following key in the registry: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\control\LSA\MSV1_0`

3. On the Edit menu, click Add Value, and then add the following registry value:  
    Value Name: NtlmMinClientSec  
    Data Type: REG_WORD  
    Value: one of the values below:  

    - 0x00000010- Message integrity
    - 0x00000020- Message confidentiality
    - 0x00080000- NTLM 2 session security
    - 0x20000000- 128-bit encryption
    - 0x80000000- 56-bit encryption

4. Quit Registry Editor.  

If a client/server program uses the NTLM SSP (or uses secure Remote Procedure Call [RPC], which uses the NTLM SSP) to provide session security for a connection, the type of session security to use is determined as follows:

- The client requests any or all the following items: message integrity, message confidentiality, NTLM 2 session security, and 128-bit or 56-bit encryption.
- The server responds, indicating which items of the requested set it wants.
- The resulting set is said to have been "negotiated."  

You can use the NtlmMinClientSec value to cause client/server connections to either negotiate a given quality of session security or not to succeed. However, you should note the following items:

- If you use 0x00000010 for the NtlmMinClientSec value, the connection does not succeed if message integrity is not negotiated.
- If you use 0x00000020 for the NtlmMinClientSec value, the connection does not succeed if message confidentiality is not negotiated.
- If you use 0x00080000 for the NtlmMinClientSec value, the connection does not succeed if NTLM 2 session security is not negotiated.
- If you use 0x20000000 for the NtlmMinClientSec value, the connection does not succeed if message confidentiality is in use but 128-bit encryption is not negotiated.
