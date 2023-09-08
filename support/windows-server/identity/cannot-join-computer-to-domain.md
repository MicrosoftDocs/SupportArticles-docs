---
title: Unable to join computers to a domain
description: Provides a solution to an issue where users can't join a computer to an Active Directory domain.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:domain-join-issues, csstroubleshoot
ms.technology: windows-server-active-directory
---
# Unable to Join Windows Server 2008 R2 or Windows 7 Computer to Active Directory Domain

This article helps fix an issue where users can't join a computer to an Active Directory domain.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2008652

## Symptoms

You try to join a Windows Server 2008 R2 or a Windows 7 machine to an Active Directory domain using **Computer Name/Domain Changes** under **System Properties.**  
The destination domain has either Windows 2000, Windows Server 2003, or Windows Server 2008 domain controllers and may have Windows NT 4.0 domain controllers present.
When trying to join the Windows Server 2008 R2 machine to the domain by specifying the fully qualified domain name (FQDN) in the domain join UI, the operation fails and you receive the error:

> An Active Directory Domain Controller (AD DC) for the domain \<target DNS domain name> couldn't be contacted  
> Ensure that the domain name is typed correctly

In the `%windir%\debug\Netsetup.log` on the client you see the following sequence:

> *\<DateTime>* NetpValidateName: checking to see if 'CLIENT-NAME' is valid as type 1 name  
> *\<DateTime>* NetpCheckNetBiosNameNotInUse for 'CLIENT-NAME'[MACHINE] returned 0x0  
> *\<DateTime>* NetpValidateName: name 'CLIENT-NAME' is valid for type 1  
> *\<DateTime>*  
>
> *\<DateTime>* NetpValidateName: checking to see if 'CLIENT-NAME' is valid as type 5 name  
> *\<DateTime>* NetpValidateName: name 'CLIENT-NAME' is valid for type 5  
> *\<DateTime>*  
>
> *\<DateTime>* **NetpValidateName: checking to see if `domain.com`** is valid as type 3 name  
> *\<DateTime>* **NetpCheckDomainNameIsValid for `domain.com` returned 0x54b, last error is 0x0**  
> *\<DateTime>* **NetpCheckDomainNameIsValid [ Exists ] for `domain.com` returned 0x54b**  

When trying to join the Windows Server 2008 R2 computer to the domain by specifying the NetBIOS name in the domain join UI, you receive a different error:

> The following error occurred attempting to join the domain \<NetBIOS target domain name>. The specified domain either does not exist or could not be contacted.

In the `%windir%\debug\Netsetup.log` on the client you see the following sequence:

> *\<DateTime>* -----------------------------------------------------------------  
*\<DateTime>* NetpDoDomainJoin  
*\<DateTime>* NetpMachineValidToJoin: 'CLIENT-NAME'  
*\<DateTime>*  OS Version: 6.1  
*\<DateTime>*  Build number: 7600 (7600.win7_rtm.090713-1255)  
*\<DateTime>*  SKU: Windows Server 2008 R2 Enterprise  
*\<DateTime>* NetpDomainJoinLicensingCheck: ulLicenseValue=1, Status: 0x0  
*\<DateTime>* NetpGetLsaPrimaryDomain: status: 0x0  
*\<DateTime>* NetpMachineValidToJoin: status: 0x0  
*\<DateTime>* NetpJoinDomain  
*\<DateTime>*  Machine: CLIENT-NAME  
*\<DateTime>*  Domain: Domain_Name  
*\<DateTime>*  MachineAccountOU: (NULL)  
*\<DateTime>*  Account: Domain_Name\admx054085  
*\<DateTime>*  Options: 0x27  
*\<DateTime>* NetpLoadParameters: loading registry parameters...  
*\<DateTime>* NetpLoadParameters: DNSNameResolutionRequired not found, defaulting to '1' 0x2  
*\<DateTime>* NetpLoadParameters: DomainCompatibilityMode not found, defaulting to '0' 0x2  
*\<DateTime>* NetpLoadParameters: status: 0x2  
*\<DateTime>* NetpValidateName: checking to see if 'Domain_Name' is valid as type 3 name  
*\<DateTime>* NetpValidateName:  'Domain_Name' is not a valid Dns domain name: 0x2554  
*\<DateTime>* NetpCheckDomainNameIsValid [ Exists ] for 'Domain_Name' returned 0x0  
*\<DateTime>* NetpValidateName: name 'Domain_Name' is valid for type 3  
*\<DateTime>* NetpDsGetDcName: trying to find DC in domain 'Domain_Name', flags: 0x40001010  
*\<DateTime>* **NetpDsGetDcName: failed to find a DC in the specified domain: 0x54b, last error is 0x0**  
*\<DateTime>* **NetpJoinDomainOnDs: NetpDsGetDcName returned: 0x54b**  
*\<DateTime>* **NetpJoinDomainOnDs: Function exits with status of: 0x54b**  
*\<DateTime>* **NetpDoDomainJoin: status: 0x54b**  

Domain joins by Windows Server 2003 computers to the same target domain succeed by specifying the NetBIOS domain name in the domain join UI. Domain joins using the FQDN also fail.  
You can also successfully join the same Windows Server 2008 R2 machine to a different Active Directory domain in the same forest specifying the FQDN domain name.

## Cause

The errors occur if **NT4Emulator** is set to **0x1** in the following registry subkey of the helper domain controller used to join the target domain:  
`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters`  
Value Name: NT4Emulator  
Value Type:  REG_DWORD  
Value Data: 1  

## Resolution

To resolve this issue either delete the **NT4Emulator** registry value on the Active Directory domain controllers in the destination domain if Windows NT 4.0 domain controllers are no longer present or can be retired. Otherwise, set the following registry value on the Windows 7 or Windows Server 2008 R2 client before attempting to join the domain:

1. Start Registry Editor (`Regedit.exe`).  

2. Locate the following key in the registry:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters`

3. If it does not exist, create a new REG_DWORD value named **NeutralizeNT4Emulator**, and set the value to **0x1**.

4. Quit Registry Editor.  

This registry setting allows the Active Directory domain controllers with the **NT4Emulator** setting to respond normally to the requesting client (avoiding Windows NT 4.0 emulation mode).

## More information

In the case of the join by FQDN, the joining client does not receive an adequate response to the LDAP pings it sends to the domain controllers at the beginning of the domain join process. The helper domain controller responds but the joining client considers the response incomplete.

After receiving the same replies from all domain controllers located using DNS, it falls back to performing a NetBIOS name query for the FQDN domain name to locate a domain controller, however this gets no response and the join operation fails.
If the NetBIOS scenario the client sends a NetLogonSamRequest to all domain controllers it receives from the WINS query for the domain name. However it receives no adequate response and fails with the second error.
