---
title: SSL/TLS communication problems after you install KB 931125
description: This kb will be used to discussion symptoms from installing the KB 931125 package on Servers.
ms.date: 12/03/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: tode, arrenc
---
# SSL/TLS communication problems after you install KB 931125

_Original product version:_ &nbsp; Windows Server 2012 Datacenter, Windows Server 2012 Datacenter, Windows Server 2012 Essentials, Windows Server 2012 Standard, Windows Server 2012 Standard, Windows Server 2008 Datacenter, Windows Server 2008 Datacenter without Hyper-V, Windows Server 2008 Enterprise, Windows Server 2008 Enterprise without Hyper-V, Windows Server 2008 R2 Datacenter, Windows Server 2008 R2 Enterprise, Windows Server 2008 R2 Service Pack 1, Windows Server 2008 R2 Standard, Windows Server 2008 Service Pack 2, Windows Server 2008 Standard, Windows Server 2008 Standard without Hyper-V, Windows Small Business Server 2008 Premium, Windows Small Business Server 2008 Standard, Windows Small Business Server 2011 Essentials, Windows Small Business Server 2011 Premium Add-On, Windows Small Business Server 2011 Standard, Windows Server 2012 R2 Datacenter, Windows Server 2012 R2 Essentials, Windows Server 2012 R2 Foundation, Windows Server 2012 R2 Preview, Windows Server 2012 R2 Standard  
_Original KB number:_ &nbsp; 2801679

## Symptoms

After December 11, 2012, applications and operations that are dependent on TLS-based authentications fail may suddenly fail although they have no apparent configuration change. Some of the applications and operations that may fail include, but are not limited to, the following:
- Wireless network access that uses certificate-based authentication
- Wired network access that uses certificate-based authentication
- Client connectivity to Lync or to Office Communications Server
- Voice mail that uses Exchange Server together with Unified Messaging
- SSL-enabled website access
- Outlook logons
- OS boot delays (slow boot)
- User logons delays (slow logon)Events that are logged in Windows or in application-specific event logs, and that either scope or definitively identify the symptom that is discussed in this article, include, but are not limited to, events that are listed in the following table. 

| Event log| Event source| Event ID| Event text |
|---|---|---|---|
|System|Schannel|36885|When asking for client authentication, this server sends a list of trusted certificate authorities to the client. The client uses this list to choose a client certificate that is trusted by the server. Currently, this server trusts so many certificate authorities that the list has grown too long. This list has thus been truncated. The administrator of this machine should review the certificate authorities trusted for client authentication and remove those that do not really need to be trusted.|
|System|Schannel|36887|The following fatal alert was received: 47|
|System|NapAgent|39|The Network Access Protection Agent was unable to determine which HRAs to request a health certificate from. A network change or if GP is configured, a configuration change will prompt further attempts to acquire a health certificate. Otherwise no further attempts will be made.Contact the HRA administrator for more information.|
|System|RemoteAccess|20225|The following error occurred in the Point to Point Protocol module on port: VPN2-509, UserName: <username>. The connection was prevented because of a policy configured on your RAS/VPN server. Specifically, the authentication method used by the server to verify your username and password may not match the authentication method configured in your connection profile. Please contact the Administrator of the RAS server and notify them of this error.|
|System|RemoteAccess|20271|The user <username> connected from <IP address> but failed an authentication attempt due to the following reason: The connection was prevented because of a policy configured on your RAS/VPN server. Specifically, the authentication method used by the server to verify your username and password may not match the authentication method configured in your connection profile. Please contact the Administrator of the RAS server and notify them of this error.|
|||||

## Cause

These problems may occur if you updated your Third-party Root Certication Authorities by using the December 2012 KB 931125 update package. The KB 931125 package that was posted on December 11, 2012, was intended only for client SKUs. However, it was also offered for Server SKUs for a short time on Windows Update and WSUS.

This package installed more than 330 Third-party Root Certication Authorities. Currently, the maximum size of the trusted certificate authorities list that the Schannel security package supports is 16 kilobytes (KB). Having a large amount of Third-party Root Certication Authorities will go over the 16k limit, and you will experience TLS/SSL communication problems.

## Resolution

If you use WSUS, and you did not install the December 2012 KB 931125 update, you should sync your WSUS servers, and then approve the expirations so that your servers do not install the update.

If you installed the December 2012 KB 931125 update package, you should use the following resolution to remove additional Third-party Root Certication Authorities on all servers that now have a large amount of Third-party Root Certication Authorities.

> [!NOTE]
> This solution removes all Third-party Root Certication Authorities. If your server has connectivity to Windows Update, it will automatically add back Third-party Root Certication Authorities as needed, as also discussed in KB 931125. If an affected server is isolated or disonnected from the Internet, you must manually add the necessary Third-party Root Certication Authorities back as you would have done in the past. (Or, you can install them by using Group Policy.)

To have us fix this problem for you, go to the "[Here's an easy fix](#fixitformealways)" section. If you prefer to fix this problem manually, go to the "[Let me fix it myself](#letmefixitmyselfalways)" section.

### Here's an easy fix

To fix this problem automatically, click the **Download** button. In the **File Download** dialog box, click **Run** or **Open**, and then follow the steps in the easy fix wizard.
- Make sure that you make a backup of the registry and of all affected keys before you make any changes to your system.
- This wizard may be in English only. However, the automatic fix also works for other language versions of Windows.
- If you're not on the computer that has the problem, save the easy fix solution to a flash drive or a CD, and then run it on the computer that has the problem.

### Let me fix it myself

*Easy fix 50974*  

Delete the following registry key:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SystemCertificates\AuthRoot\Certificates` 

To do this, follow these steps:
1. Start Registry Editor
2. Locate the following registry subkey:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SystemCertificates\AuthRoot` 
3. Right-click and then delete the key that is called "Certificates"> [!NOTE]
> Make sure that you make a backup of the registry and affected keys before you make any changes to your system.

## More Information

These problems may occur if a TLS/SSL server contains many entries in the trusted root certification list. The server sends a list of trusted certificate authorities to the client if the following conditions are true:
- The server uses the Transport Layer Security (TLS)/SSL protocol to encrypt network traffic.
- Client certificates are required for authentication during the authentication handshake process.
This list of trusted certificate authorities represents the authorities from which the server can accept a client certificate. To be authenticated by the server, the client must have a certificate that is present in the chain of certificates to a root certificate from the server's list. This is because the client certificate is always the end-entity certificate at the end of the chain. The client certificate isn't part of the chain.

Currently, the maximum size of the trusted certificate authorities list that the Schannel security package supports is 16 KB in Windows Server 2008, Windows Server 2008 R2, and Windows Server 2012.

Schannel creates the list of trusted certificate authorities by searching the Trusted Root Certification Authorities store on the local computer. Every certificate that is trusted for client authentication purposes is added to the list. If the size of this list exceeds 16 KB, Schannel logs Warning event ID 36855. Then, Schannel truncates the list of trusted root certificates and sends this truncated list to the client computer.

When the client computer receives the truncated list of trusted root certificates, the client computer may not have a certificate that exists in the chain of a trusted certificate issuer. For example, the client computer may have a certificate that corresponds to a trusted root certificate that Schannel truncated from the list of trusted certificate authorities. Therefore, the server cannot authenticate the client.
