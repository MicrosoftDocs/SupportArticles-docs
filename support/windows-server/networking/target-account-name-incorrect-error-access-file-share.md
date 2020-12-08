---
title: 
description: Describes a problem in which Event ID 4 and Event ID 1097 are logged in the Server log. Provides a Resolution.
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: nandve
---
# "Target account name is incorrect" error when a domain user accesses a share on a file server that is running Windows Server 2012 R2

_Original product version:_ &nbsp; Windows Server 2012 R2 Datacenter, Windows Server 2012 R2 Standard  
_Original KB number:_ &nbsp; 3040803

## Symptoms

When domain users try to access a share on a file server that is running Windows Server 2012 R2, they cannot access the share, and they receive the following error message:

Logon failure: Target account name is incorrect.

Additionally when this problem occurs, Event ID 4 and Event ID 1097 are logged in the Server log. This problem may occur for several hours or up to a day. Then, the user loses access to the share on the server.

Event ID 4 

The Kerberos client received a KRB_AP_ERR_MODIFIED error from the server **server_name** $. The target name used was **server_name** $. This indicates that the target server failed to decrypt the ticket provided by the client. This can occur when the target server principal name (SPN) is registered on an account other than the account the target service is using. Please ensure that the target SPN is registered on, and only registered on, the account used by the server. This error can also happen when the target service is using a different password for the target service account than what the Kerberos Key Distribution Center (KDC) has for the target service account. Please ensure that the service on the server and the KDC are both updated to use the current password. If the server name is not fully qualified, and the target domain (**DNS_prefix**. **dns_suffix**) is different from the client domain (**DNS_prefix**. **dns_suffix**), check if there are identically named server accounts in these two domains, or use the fully-qualified name to identify the server.

Event ID 1097 

The processing of Group Policy failed. Windows could not determine the computer account to enforce Group Policy settings. This may be transient. Group Policy settings, including computer configuration, will not be enforced for this computer.

## Cause

This problem occurs because the file server cannot decrypt the ticket that was encrypted in AES256.

## Resolution

To resolve this problem, set the value of the SupportedEncryptionTypes attribute to 0x7fffffff . To do this, follow these steps:
1. In the Group Policy Management Console (GPMC), expand **Computer Configuration**, expand **Windows Settings**, expand **Security Settings**, expand **Local Policies**, and then select **Security Options**.
2. Click to select the **Network security: Configure encryption types allowed for Kerberos** option.
3. Click to select the **Define these policy settings**  check box and all six check boxes for the encryption types.
4. Click **OK**, and then close the GPMC.

> [!NOTE]
>  This policy sets the SupportedEncryptionTypes registry entry to a value of 0x7FFFFFFF . The SupportedEncryptionTypes registry entry is at the following location:

`HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\parameters` 

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## References

[Kerberos](https://technet.microsoft.com/library/cc753173%28v=ws.10%29.aspx) 

[Changes in Kerberos Authentication](https://technet.microsoft.com/library/dd560670%28v=ws.10%29.aspx) 

[Interpreting the SupportedEncryptionTypes Registry Key](http://blogs.technet.com/b/petergu/archive/2013/04/15/interpreting-the-supportedencryptiontypes-registry-key.aspx) 

[Kerberos Enhancements](https://technet.microsoft.com/library/cc749438%28v=ws.10%29.aspx) 

[You cannot log on to a Windows 7-based or Windows Server 2008 R2-based client computer after you disable AES encryption for Kerberos authentication](https://support.microsoft.com/help/2768494)
