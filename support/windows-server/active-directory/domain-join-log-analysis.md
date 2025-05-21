---
title: Domain join log analysis
description: Provides a detailed guide on what occurs on a client computer during a domain join operation.
ms.date: 06/04/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: raviks, eriw, dennhu
ms.custom:
- sap:active directory\on-premises active directory domain join
- pcy:WinComm Directory Services
---
# Domain join log analysis

This article provides a detailed guide on what occurs on a client machine when it is joining an Active Directory (AD) domain. The article includes a sample of successful Netsetup.log, a breakdown of the network traffic during the AD domain join operation, and explanations of the various types of traffic involved.

To troubleshoot domain join failures, we can compare the logs of the failure scenario and successful scenario to identify the cause. Logs needed for troubleshooting include `Netsetup.log`, which is located at `%windir%\debug` folder and enabled by default, and network trace collected from the client computer.

## Sample of a successful Netsetup.log

The following sample is the typical `Netsetup.log` covering a successful AD domain join to the domain named *contoso.local*, collected from a Windows 10 24H2 virtual machine (VM) named *HOST88*.

See lines starting with **//** for explanations.

```output
03/06/2025 11:28:14:530 -----------------------------------------------------------------
03/06/2025 11:28:14:530 NetpValidateName: checking to see if 'HOST88' is valid as type 1 name
03/06/2025 11:28:14:530 NetpCheckNetBiosNameNotInUse for 'HOST88' [MACHINE] returned 0x0
03/06/2025 11:28:14:530 NetpValidateName: name 'HOST88' is valid for type 1
03/06/2025 11:28:14:541 -----------------------------------------------------------------
03/06/2025 11:28:14:541 NetpValidateName: checking to see if 'HOST88' is valid as type 5 name
03/06/2025 11:28:14:541 NetpValidateName: name 'HOST88' is valid for type 5

//At least one domain controller (DC) of the specified domain is located and it's qualified for AD join operation. User is prompted in GUI for a valid domain user credential.
03/06/2025 11:28:14:562 -----------------------------------------------------------------
03/06/2025 11:28:14:562 NetpValidateName: checking to see if 'contoso.local' is valid as type 3 name
03/06/2025 11:28:14:639 NetpCheckDomainNameIsValid [ Exists ] for 'contoso.local' returned 0x0
03/06/2025 11:28:14:639 NetpValidateName: name 'contoso.local' is valid for type 3

//Activity begins after a valid domain user credential is provided in GUI.
03/06/2025 11:29:05:537 -----------------------------------------------------------------
03/06/2025 11:29:05:537 NetpDoDomainJoin
03/06/2025 11:29:05:537 NetpDoDomainJoin: using current computer names
03/06/2025 11:29:05:537 NetpDoDomainJoin: NetpGetComputerNameEx(NetBios) returned 0x0
03/06/2025 11:29:05:537 NetpDoDomainJoin: NetpGetComputerNameEx(DnsHostName) returned 0x0
03/06/2025 11:29:05:537 NetpMachineValidToJoin: 'HOST88'
03/06/2025 11:29:05:537   OS Version: 10.0
03/06/2025 11:29:05:537   Build number: 26100 (26100.ge_release.240331-1435)
03/06/2025 11:29:05:548   SKU: Windows 11 Enterprise
03/06/2025 11:29:05:548   Architecture: 64-bit (AMD64)
03/06/2025 11:29:05:559 NetpMachineValidToJoin: status: 0x0
03/06/2025 11:29:05:559 NetpJoinDomain
03/06/2025 11:29:05:559   HostName: HOST88
03/06/2025 11:29:05:559   NetbiosName: HOST88
03/06/2025 11:29:05:559   Domain: contoso.local
03/06/2025 11:29:05:559   MachineAccountOU: (NULL)
03/06/2025 11:29:05:559   Account: contoso\puser2
03/06/2025 11:29:05:559   Options: 0x25
03/06/2025 11:29:05:569 NetpValidateName: checking to see if 'contoso.local' is valid as type 3 name
03/06/2025 11:29:05:632 NetpCheckDomainNameIsValid [ Exists ] for 'contoso.local' returned 0x0
03/06/2025 11:29:05:632 NetpValidateName: name 'contoso.local' is valid for type 3
03/06/2025 11:29:05:632 NetpDsGetDcName: trying to find DC in domain 'contoso.local', flags: 0x40001010
03/06/2025 11:29:06:519 NetpDsGetDcName: failed to find a DC having account 'HOST88$': 0x525, last error is 0x0
03/06/2025 11:29:06:539 NetpDsGetDcName: status of verifying DNS A record name resolution for 'DC2.contoso.local': 0x0
03/06/2025 11:29:06:539 NetpDsGetDcName: found DC '\\DC2.contoso.local' in the specified domain
03/06/2025 11:29:06:539 NetpJoinDomainOnDs: NetpDsGetDcName returned: 0x0
03/06/2025 11:29:06:539 NetpDisableIDNEncoding: using FQDN contoso.local from dcinfo
03/06/2025 11:29:06:549 NetpDisableIDNEncoding: DnsDisableIdnEncoding(UNTILREBOOT) on 'contoso.local' succeeded
03/06/2025 11:29:06:549 NetpJoinDomainOnDs: NetpDisableIDNEncoding returned: 0x0
03/06/2025 11:29:06:674 NetpJoinDomainOnDs: status of connecting to dc '\\DC2.contoso.local': 0x0
03/06/2025 11:29:06:674 NetpGetDnsHostName: PrimaryDnsSuffix defaulted to DNS domain name: contoso.local
03/06/2025 11:29:06:678 NetpProvisionComputerAccount:
03/06/2025 11:29:06:678   lpDomain: contoso.local
03/06/2025 11:29:06:678   lpHostName: HOST88
03/06/2025 11:29:06:678   lpMachineAccountOU: (NULL)
03/06/2025 11:29:06:678   lpDcName: DC2.contoso.local
03/06/2025 11:29:06:678   lpMachinePassword: (null)
03/06/2025 11:29:06:678   lpAccount: contoso\puser2
03/06/2025 11:29:06:678   lpPassword: (non-null)
03/06/2025 11:29:06:678   dwJoinOptions: 0x25
03/06/2025 11:29:06:678   dwOptions: 0x40000003
03/06/2025 11:29:06:696 NetpLdapBind: Verified minimum encryption strength on DC2.contoso.local: 0x0
03/06/2025 11:29:06:696 NetpLdapGetLsaPrimaryDomain: reading domain data
03/06/2025 11:29:06:696 NetpGetNCData: Reading NC data
03/06/2025 11:29:06:706 NetpGetDomainData: Lookup domain data for: DC=contoso,DC=local
03/06/2025 11:29:06:708 NetpGetDomainData: Lookup crossref data for: CN=Partitions,CN=Configuration,DC=contoso,DC=local
03/06/2025 11:29:06:710 NetpLdapGetLsaPrimaryDomain: result of retrieving domain data: 0x0
03/06/2025 11:29:06:710 NetpCheckForDomainSIDCollision: returning 0x0(0).
03/06/2025 11:29:06:733 NetpGetComputerObjectDn: Cracking DNS domain name contoso.local/ into Netbios on \\DC2.contoso.local
03/06/2025 11:29:06:739 NetpGetComputerObjectDn: Crack results:   name = CONTOSO\

//Check if a computer object with the same name already exists or not. If yes, it's the account reuse scenario.
03/06/2025 11:29:06:739 NetpGetComputerObjectDn: Cracking account name CONTOSO\HOST88$ on \\DC2.contoso.local
03/06/2025 11:29:06:741 NetpGetComputerObjectDn: Crack results:   Account does not exist
03/06/2025 11:29:06:741 NetpCreateComputerObjectInDs: NetpGetComputerObjectDn failed: 0x534
03/06/2025 11:29:06:741 NetpProvisionComputerAccount: LDAP creation failed: 0x534
03/06/2025 11:29:06:743 ldap_unbind status: 0x0
03/06/2025 11:29:06:743 NetpJoinCreatePackagePart: status:0x534.
03/06/2025 11:29:06:743 NetpJoinDomainOnDs: Function exits with status of: 0x534
03/06/2025 11:29:06:743 NetpJoinDomainOnDs: status of disconnecting from '\\DC2.contoso.local': 0x0
03/06/2025 11:29:06:745 NetpResetIDNEncoding: DnsDisableIdnEncoding(RESETALL) on 'contoso.local' returned 0x0
03/06/2025 11:29:06:745 NetpJoinDomainOnDs: NetpResetIDNEncoding on 'contoso.local': 0x0
03/06/2025 11:29:06:745 NetpDoDomainJoin: status: 0x534
03/06/2025 11:29:06:755 -----------------------------------------------------------------
03/06/2025 11:29:06:755 NetpDoDomainJoin
03/06/2025 11:29:06:755 NetpDoDomainJoin: using current computer names
03/06/2025 11:29:06:755 NetpDoDomainJoin: NetpGetComputerNameEx(NetBios) returned 0x0
03/06/2025 11:29:06:755 NetpDoDomainJoin: NetpGetComputerNameEx(DnsHostName) returned 0x0
03/06/2025 11:29:06:755 NetpMachineValidToJoin: 'HOST88'
03/06/2025 11:29:06:755   OS Version: 10.0
03/06/2025 11:29:06:755   Build number: 26100 (26100.ge_release.240331-1435)
03/06/2025 11:29:06:760   SKU: Windows 11 Enterprise
03/06/2025 11:29:06:760   Architecture: 64-bit (AMD64)
03/06/2025 11:29:06:762 NetpMachineValidToJoin: status: 0x0
03/06/2025 11:29:06:762 NetpJoinDomain
03/06/2025 11:29:06:762   HostName: HOST88
03/06/2025 11:29:06:762   NetbiosName: HOST88
03/06/2025 11:29:06:762   Domain: contoso.local
03/06/2025 11:29:06:762   MachineAccountOU: (NULL)
03/06/2025 11:29:06:762   Account: contoso\puser2
03/06/2025 11:29:06:762   Options: 0x27
03/06/2025 11:29:06:768 NetpValidateName: checking to see if 'contoso.local' is valid as type 3 name
03/06/2025 11:29:06:835 NetpCheckDomainNameIsValid [ Exists ] for 'contoso.local' returned 0x0
03/06/2025 11:29:06:835 NetpValidateName: name 'contoso.local' is valid for type 3
03/06/2025 11:29:06:835 NetpDsGetDcName: trying to find DC in domain 'contoso.local', flags: 0x40001010
03/06/2025 11:29:07:703 NetpDsGetDcName: failed to find a DC having account 'HOST88$': 0x525, last error is 0x0
03/06/2025 11:29:07:712 NetpDsGetDcName: status of verifying DNS A record name resolution for 'DC2.contoso.local': 0x0
03/06/2025 11:29:07:712 NetpDsGetDcName: found DC '\\DC2.contoso.local' in the specified domain
03/06/2025 11:29:07:712 NetpJoinDomainOnDs: NetpDsGetDcName returned: 0x0
03/06/2025 11:29:07:712 NetpDisableIDNEncoding: using FQDN contoso.local from dcinfo
03/06/2025 11:29:07:712 NetpDisableIDNEncoding: DnsDisableIdnEncoding(UNTILREBOOT) on 'contoso.local' succeeded
03/06/2025 11:29:07:712 NetpJoinDomainOnDs: NetpDisableIDNEncoding returned: 0x0
03/06/2025 11:29:07:712 NetpJoinDomainOnDs: status of connecting to dc '\\DC2.contoso.local': 0x0
03/06/2025 11:29:07:712 NetpGetDnsHostName: PrimaryDnsSuffix defaulted to DNS domain name: contoso.local
03/06/2025 11:29:07:719 NetpProvisionComputerAccount:
03/06/2025 11:29:07:719   lpDomain: contoso.local
03/06/2025 11:29:07:719   lpHostName: HOST88
03/06/2025 11:29:07:719   lpMachineAccountOU: (NULL)
03/06/2025 11:29:07:719   lpDcName: DC2.contoso.local
03/06/2025 11:29:07:719   lpMachinePassword: (null)
03/06/2025 11:29:07:719   lpAccount: contoso\puser2
03/06/2025 11:29:07:719   lpPassword: (non-null)
03/06/2025 11:29:07:719   dwJoinOptions: 0x27
03/06/2025 11:29:07:719   dwOptions: 0x40000003
03/06/2025 11:29:07:744 NetpLdapBind: Verified minimum encryption strength on DC2.contoso.local: 0x0
03/06/2025 11:29:07:744 NetpLdapGetLsaPrimaryDomain: reading domain data
03/06/2025 11:29:07:744 NetpGetNCData: Reading NC data
03/06/2025 11:29:07:744 NetpGetDomainData: Lookup domain data for: DC=contoso,DC=local
03/06/2025 11:29:07:744 NetpGetDomainData: Lookup crossref data for: CN=Partitions,CN=Configuration,DC=contoso,DC=local
03/06/2025 11:29:07:744 NetpLdapGetLsaPrimaryDomain: result of retrieving domain data: 0x0
03/06/2025 11:29:07:744 NetpCheckForDomainSIDCollision: returning 0x0(0).
03/06/2025 11:29:07:750 NetpGetComputerObjectDn: Cracking DNS domain name contoso.local/ into Netbios on \\DC2.contoso.local
03/06/2025 11:29:07:750 NetpGetComputerObjectDn: Crack results:   name = CONTOSO\
03/06/2025 11:29:07:750 NetpGetComputerObjectDn: Cracking account name CONTOSO\HOST88$ on \\DC2.contoso.local
03/06/2025 11:29:07:750 NetpGetComputerObjectDn: Crack results:   Account does not exist
03/06/2025 11:29:07:750 NetpGetComputerObjectDn: Cracking Netbios domain name CONTOSO\ into root DN on \\DC2.contoso.local
03/06/2025 11:29:07:750 NetpGetComputerObjectDn: Crack results:   name = DC=contoso,DC=local
03/06/2025 11:29:07:750 NetpGetComputerObjectDn: Got DN CN=HOST88,CN=Computers,DC=contoso,DC=local from the default computer container
03/06/2025 11:29:07:750 NetpGetADObjectOwnerAttributes: Looking up attributes for machine account: CN=HOST88,CN=Computers,DC=contoso,DC=local
03/06/2025 11:29:07:750 NetpGetADObjectOwnerAttributes: Ldap Search failed: 8240
03/06/2025 11:29:07:750 NetpCheckIfAccountShouldBeReused: Computer Object does not exist in OU.
03/06/2025 11:29:07:750 NetpCheckIfAccountShouldBeReused:fReuseAllowed: TRUE, NetStatus:0x2030

//Computer object is created.
03/06/2025 11:29:07:750 NetpModifyComputerObjectInDs: Initial attribute values:
03/06/2025 11:29:07:750     objectClass  =  Computer
03/06/2025 11:29:07:750     SamAccountName  =  HOST88$
03/06/2025 11:29:07:750     userAccountControl  =  0x1000
03/06/2025 11:29:07:750     DnsHostName  =  HOST88.contoso.local
03/06/2025 11:29:07:750     ServicePrincipalName  =  HOST/HOST88.contoso.local  RestrictedKrbHost/HOST88.contoso.local  HOST/HOST88  RestrictedKrbHost/HOST88
03/06/2025 11:29:07:750     unicodePwd  =  <SomePassword>
03/06/2025 11:29:07:750 NetpModifyComputerObjectInDs: Computer Object does not exist in OU
03/06/2025 11:29:07:750 NetpModifyComputerObjectInDs: Attribute values to set:
03/06/2025 11:29:07:750     objectClass  =  Computer
03/06/2025 11:29:07:750     SamAccountName  =  HOST88$
03/06/2025 11:29:07:750     userAccountControl  =  0x1000
03/06/2025 11:29:07:750     DnsHostName  =  HOST88.contoso.local
03/06/2025 11:29:07:750     ServicePrincipalName  =  HOST/HOST88.contoso.local  RestrictedKrbHost/HOST88.contoso.local  HOST/HOST88  RestrictedKrbHost/HOST88
03/06/2025 11:29:07:750     unicodePwd  =  <SomePassword>
03/06/2025 11:29:07:857 Querying "CN=HOST88,CN=Computers,DC=contoso,DC=local" for objectSid\objectGuid attributes

//SID of the new computer account.
03/06/2025 11:29:07:859 NetpQueryAccountAttributes succeeded: got RID=0x643 objectSid=S-1-5-21-3127289744-4148518019-814850311-1603
03/06/2025 11:29:07:859 NetpDeleteMachineAccountKey: called for computer 'HOST88'
03/06/2025 11:29:07:867 NetpGetComputerObjectDn: Cracking DNS domain name contoso.local/ into Netbios on \\DC2.contoso.local
03/06/2025 11:29:07:867 NetpGetComputerObjectDn: Crack results:   name = CONTOSO\
03/06/2025 11:29:07:867 NetpGetComputerObjectDn: Cracking account name CONTOSO\HOST88$ on \\DC2.contoso.local
03/06/2025 11:29:07:876 NetpGetComputerObjectDn: Crack results:   (Account already exists) DN = CN=HOST88,CN=Computers,DC=contoso,DC=local
03/06/2025 11:29:07:876 NetpDeleteMachineAccountKey: msDS-KeyCredentialLink attr was not found on computer 'HOST88' - no action required.
03/06/2025 11:29:07:876 NetpDeleteMachineAccountKey: returning Status: 0 
03/06/2025 11:29:07:876 ldap_unbind status: 0x0
03/06/2025 11:29:07:876 NetpJoinCreatePackagePart: status:0x0.
03/06/2025 11:29:07:927 NetpJoinDomainOnDs: Setting netlogon cache.
03/06/2025 11:29:07:948 NetpJoinDomainOnDs: status of setting netlogon cache: 0x0
03/06/2025 11:29:07:948 NetpJoinDomainOnDs: Function exits with status of: 0x0
03/06/2025 11:29:07:950 NetpJoinDomainOnDs: status of disconnecting from '\\DC2.contoso.local': 0x0
03/06/2025 11:29:07:959 NetpJoinDomain: DsrIsDeviceJoined returned false
03/06/2025 11:29:08:303 NetpJoinDomain: NetpCompleteOfflineDomainJoin SUCCESS: Requested a reboot :0x0
03/06/2025 11:29:08:303 NetpDoDomainJoin: status: 0x0
Privileges: Setting backup/restore privileges.
03/06/2025 11:29:07:888 NetpProvGetWindowsImageState: IMAGE_STATE_COMPLETE.
03/06/2025 11:29:07:888 NetpAddPartCollectionToRegistry.
03/06/2025 11:29:07:888 NetpProvGetTargetProductVersion: Target product version: 10.0.26100.3037
03/06/2025 11:29:07:893 NetpAddPartCollectionToRegistry: delete OP state key status: 0x2.
03/06/2025 11:29:07:893 NetpConvertBlobToJoinState: Translating provisioning data to internal format
03/06/2025 11:29:07:893 NetpConvertBlobToJoinState: Selecting version 1
03/06/2025 11:29:07:893 NetpConvertBlobToJoinState: exiting: 0x0
03/06/2025 11:29:07:895 NetpJoin2RequestPackagePartInstall: Successfully persisted all fields
03/06/2025 11:29:07:901 NetpJoin3RequestPackagePartInstall: Successfully persisted all fields
03/06/2025 11:29:07:913 NetpJoin4RequestPackagePartInstall: Successfully persisted all fields
03/06/2025 11:29:07:917 NetpAddPartCollectionToRegistry: Successfully initiated provisioning package installation: 4/4 part(s) installed.
03/06/2025 11:29:07:917 NetpAddPartCollectionToRegistry: status: 0x0.
03/06/2025 11:29:07:917 NetpOpenRegistry: status: 0x0.
03/06/2025 11:29:07:917 NetpSetPrivileges: status: 0x0.
03/06/2025 11:29:07:917 NetpRequestProvisioningPackageInstall: status: 0x0.
03/06/2025 11:29:07:966 -----------------------------------------------------------------
03/06/2025 11:29:07:966 NetpProvContinueProvisioningPackageInstall:
03/06/2025 11:29:07:968   Context: 0
03/06/2025 11:29:07:968 NetpProvGetWindowsImageState: IMAGE_STATE_COMPLETE.
03/06/2025 11:29:07:971 NetpCreatePartListFromRegistry: status: 0x0.
03/06/2025 11:29:07:971 NetpCompleteOfflineDomainJoin
03/06/2025 11:29:07:971   fBootTimeCaller: FALSE
03/06/2025 11:29:07:971   fSetLocalGroups: TRUE
03/06/2025 11:29:07:971 NetpJoinDomainLocal: NetpHandleJoinedStateInfo returned: 0x0
03/06/2025 11:29:08:190 NetpJoinDomainLocal: NetpManageMachineSecret returned: 0x0.
03/06/2025 11:29:08:190 Calling NetpQueryService to get Netlogon service state.
03/06/2025 11:29:08:190 NetpJoinDomainLocal: NetpQueryService returned: 0x0.
03/06/2025 11:29:08:200 NetpJoinDomainLocal: status of setting LSA pri. domain: 0x0
03/06/2025 11:29:08:200 NetpManageLocalGroupsForJoin: Adding groups for new domain, removing groups from old domain, if any.
03/06/2025 11:29:08:264 NetpManageLocalGroupsForJoin: status of modifying groups related to domain 'CONTOSO' to local groups: 0x0
03/06/2025 11:29:08:266 NetpManageLocalGroupsForJoin: INFO: No old domain groups to process.
03/06/2025 11:29:08:266 NetpJoinDomainLocal: Status of managing local groups: 0x0
03/06/2025 11:29:08:290 NetpJoinDomainLocal: status of setting ComputerNamePhysicalDnsDomain to 'contoso.local': 0x0
03/06/2025 11:29:08:290 NetpJoinDomainLocal: Controlling services and setting service start type.
03/06/2025 11:29:08:290 NetpJoinDomainLocal: Updating W32TimeConfig
03/06/2025 11:29:08:298 NetpCompleteOfflineDomainJoin: status: 0x0
03/06/2025 11:29:08:298 NetpJoinProvider2OLContinuePackagePartInstall: ignoring Context=0 (work finished already).
03/06/2025 11:29:08:298 NetpJoinProvider3OLContinuePackagePartInstall: ignoring Context=0 (work finished already).
03/06/2025 11:29:08:298 NetpJoinProvider4OLContinuePackagePartInstall: ignoring Context=0 (work finished already).
03/06/2025 11:29:08:298 NetpProvContinueProvisioningPackageInstall: Provisioning package installation completed successfully.
03/06/2025 11:29:08:299 NetpProvContinueProvisioningPackageInstall: delete OP state key status: 0x0.

//0xa99 stands for "a restart is needed".
03/06/2025 11:29:08:299 NetpProvContinueProvisioningPackageInstall: status: 0xa99.
03/06/2025 11:29:10:559 -----------------------------------------------------------------
03/06/2025 11:29:10:559 NetpChangeMachineName: from 'HOST88' to 'HOST88' using 'contoso\puser2' [0x1000]
03/06/2025 11:29:10:559 NetpChangeMachineName: using DnsHostnameToComputerNameEx
03/06/2025 11:29:10:559 NetpChangeMachineName: generated netbios name: 'HOST88'
03/06/2025 11:29:10:559 NetpDsGetDcName: trying to find DC in domain 'contoso.local', flags: 0x1010
03/06/2025 11:29:10:559 NetpDsGetDcName: found DC '\\DC2.contoso.local' in the specified domain
03/06/2025 11:29:10:559 NetpGetDnsHostName: Read NV Domain: contoso.local
03/06/2025 11:29:14:830 NetpGetComputerObjectDn: Cracking DNS domain name contoso.local/ into Netbios on \\DC2.contoso.local
03/06/2025 11:29:14:830 NetpGetComputerObjectDn: Crack results:   name = CONTOSO\
03/06/2025 11:29:14:830 NetpGetComputerObjectDn: Cracking account name CONTOSO\HOST88$ on \\DC2.contoso.local
03/06/2025 11:29:14:830 NetpGetComputerObjectDn: Crack results:   (Account already exists) DN = CN=HOST88,CN=Computers,DC=contoso,DC=local
03/06/2025 11:29:14:844 NetpModifyComputerObjectInDs: Initial attribute values:
03/06/2025 11:29:14:844     DnsHostName  =  HOST88.contoso.local
03/06/2025 11:29:14:844     ServicePrincipalName  =  HOST/HOST88.contoso.local  RestrictedKrbHost/HOST88.contoso.local  HOST/HOST88  RestrictedKrbHost/HOST88
03/06/2025 11:29:14:844 NetpModifyComputerObjectInDs: Computer Object already exists in OU:
03/06/2025 11:29:14:844     DnsHostName  =  HOST88.contoso.local
03/06/2025 11:29:14:844     ServicePrincipalName  =  RestrictedKrbHost/HOST88  HOST/HOST88  RestrictedKrbHost/HOST88.contoso.local  HOST/HOST88.contoso.local
03/06/2025 11:29:14:844 NetpModifyComputerObjectInDs: There are _NO_ modifications to do
03/06/2025 11:29:14:844 ldap_unbind status: 0x0
03/06/2025 11:29:14:844 NetpChangeMachineName: status of setting DnsHostName and SPN: 0x0
03/06/2025 11:29:14:844 NetpChangeMachineName: DsrIsDeviceJoinedEx returned false. dsrInstance = 0
03/06/2025 11:29:14:862 NetpChangeMachineName: SetComputerNameEx() returned 0x1
```

## Network traces

Network traces are helpful in pinpointing AD domain join issues. During an AD domain join operation, multiple types of traffic occur between the client and some Domain Name System (DNS) server, and then between the client and some DCs. The following sections discuss each type of traffic.

### DNS

The client queries the DNS SRV record to locate the DCs of the domain to join. In the following example, the client manages to locate 2 DCs.

```output
Source  Destination  Protocol Name  Description
HOST88.contoso.local  dc1.contoso.local  DNS  DNS:QueryId = 0xA793, QUERY (Standard query), Query  for _ldap._tcp.dc._msdcs.contoso.local of type SRV on class Internet
dc1.contoso.local  HOST88.contoso.local  DNS  DNS:QueryId = 0xA793, QUERY (Standard query), Response - Success, 192.168.100.10, 192.168.100.12
HOST88.contoso.local  dc1.contoso.local  DNS  DNS:QueryId = 0x623B, QUERY (Standard query), Query  for dc2.contoso.local of type Host Addr on class Internet
dc1.contoso.local  HOST88.contoso.local  DNS  DNS:QueryId = 0x623B, QUERY (Standard query), Response - Success, 192.168.100.10
```

```output
  Frame: Number = 4, Captured Frame Length = 200, MediaType = ETHERNET
+ Ethernet: Etype = Internet IP (IPv4),DestinationAddress:[00-15-5D-3D-04-04],SourceAddress:[00-15-5D-3D-04-02]
+ Ipv4: Src = 192.168.100.12, Dest = 192.168.100.13, Next Protocol = UDP, Packet ID = 37531, Total IP Length = 186
+ Udp: SrcPort = DNS(53), DstPort = 53141, Length = 166
- Dns: QueryId = 0xA793, QUERY (Standard query), Response - Success, 192.168.100.10, 192.168.100.12 
    QueryIdentifier: 42899 (0xA793)
  + Flags:  Response, Opcode - QUERY (Standard query), AA, RD, RA, Rcode - Success
    QuestionCount: 1 (0x1)
    AnswerCount: 2 (0x2)
    NameServerCount: 0 (0x0)
    AdditionalCount: 2 (0x2)
  + QRecord: _ldap._tcp.dc._msdcs.contoso.local of type SRV on class Internet
  + ARecord: _ldap._tcp.dc._msdcs.contoso.local of type SRV on class Internet
  + ARecord: _ldap._tcp.dc._msdcs.contoso.local of type SRV on class Internet
  + AdditionalRecord: dc2.contoso.local of type Host Addr on class Internet: 192.168.100.10
  + AdditionalRecord: dc1.contoso.local of type Host Addr on class Internet: 192.168.100.12
```

### LDAP ping

Then the client picks up one DC and uses Lightweight Directory Access Protocol (LDAP) ping over UDP port 389 to detect the functionalities of that DC.

```output
Source  Destination  Protocol Name  Description
HOST88.contoso.local  dc2.contoso.local  LDAPMessage  LDAPMessage:Search Request, MessageID: 1
dc2.contoso.local  HOST88.contoso.local  NetLogon  NetLogon:LogonSAMLogonResponseEX (SAM Response to SAM logon request): 23 (0x17)
```

In the response, the DC provides the general information of the domain and that DC's current capabilities.

```output
  Frame: Number = 10, Captured Frame Length = 207, MediaType = ETHERNET
+ Ethernet: Etype = Internet IP (IPv4),DestinationAddress:[00-15-5D-3D-04-04],SourceAddress:[00-15-5D-3D-04-05]
+ Ipv4: Src = 192.168.100.10, Dest = 192.168.100.13, Next Protocol = UDP, Packet ID = 24499, Total IP Length = 193
+ Udp: SrcPort = LDAP(389), DstPort = 53143, Length = 173
  Cldap: (CLDAP)Search Result Entry, MessageID: 1, Status: Success
+ LDAPMessage: Search Result Entry, MessageID: 1
- NetlogonAttribute: LogonSAMLogonResponseEX (SAM Response to SAM logon request): 23 (0x17)
  - SamLogonResponseEx: DC2.contoso.local
     Opcode: LogonSAMLogonResponseEX
     Sbz: 0 (0x0)
   + Flags: 0x0001F15C 
     DomainGuid: {0B9F6161-49E4-46DD-B912-86494F62BA53}
     DnsForestName: contoso.local
     DnsDomainName: contoso.local
     DnsHostName: DC2.contoso.local
     NetbiosDomainName: CONTOSO
     NetbiosComputerName: DC2
     UserName: 
     DcSiteName: Default-First-Site-Name
     ClientSiteName: 
   + Version: 0x00000005 NT Version 5 Client
   + LmNtToken: Windows NT Networking: 0xFFFF
   + Lm20Token: OS/2 LAN Manager 2.0 (or later) Networking: 0xFFFF
+ LDAPMessage: search Result Done, MessageID: 1
```

```output
   - Flags: 0x0001F15C 
      DSPDCFLAG:                 (...............................0) DC is not a PDC of Domain.
      Reserved1:                 (..............................0.)
      DSGCFlag:                  (.............................1..) DC is a GC of forest.
      DSLDAPFlag:                (............................1...) Server supports an LDAP server.
      DSDSFlag:                  (...........................1....) DC supports a DS and is a Domain Controller.
      DSKDCFlag:                 (..........................0.....) DC is not running KDC service.
      DSTimeServFlag:            (.........................1......) DC is running time service.
      DSClosestFlag:             (........................0.......) DC is not in closest site to client.
      DSWritableFlag:            (.......................1........) DC has a writable DS.
      DSGoodTimeServFlag:        (......................0.........) DC is running time service (does not have clock hardware).
      DSNDNCFlag:                (.....................0..........) DomainName is a non-domain NC serviced by the LDAP server.
      DSSelectSecretDomain6Flag: (....................0...........) The server is notan RODC.
      DSFullSecretDomain6Flag:   (...................1............) The server is a writable DC.
      DSWSFlag:                  (..................1.............) The Active Directory Web Service is present on the server.
      Reserved:                  (...000000000000111..............)
      DSDNSControllerFlag:       (..0.............................) DomainControllerName is not a DNS name.
      DSDNSDomainFlag:           (.0..............................) DomainName is not a DNS name.
      DSDNSForestFlag:           (0...............................) DnsForestName is not a DNS name.
```

### SMB

During AD domain join, Server Message Block (SMB) traffic is employed for Microsoft Remote Procedure Call (MSRPC) based communication.

```output
Source  Destination  Protocol Name  Description
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=......S., SrcPort=49708, DstPort=Microsoft-DS(445), PayloadLen=0, Seq=125899379, Ack=0
dc2.contoso.local  HOST88.contoso.local  TCP  TCP:Flags=...A..S., SrcPort=Microsoft-DS(445), DstPort=49708, PayloadLen=0, Seq=3354173409, Ack=125899380
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=...A...., SrcPort=49708, DstPort=Microsoft-DS(445), PayloadLen=0, Seq=125899380, Ack=3354173410
HOST88.contoso.local  dc2.contoso.local  SMB  SMB:C; Negotiate, Dialect = NT LM 0.12, SMB 2.002, SMB 2.???
dc2.contoso.local  HOST88.contoso.local  SMB2  SMB2:R   NEGOTIATE (0x0), GUID={AEEC955A-89D6-C899-40AB-A8E0AA928A2C}
HOST88.contoso.local  dc2.contoso.local  SMB2  SMB2:C   NEGOTIATE (0x0), GUID={04043D5D-1500-C3B7-11EF-FA3AB1842093}
dc2.contoso.local  HOST88.contoso.local  SMB2  SMB2:R   NEGOTIATE (0x0), GUID={AEEC955A-89D6-C899-40AB-A8E0AA928A2C}
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=...A...., SrcPort=49708, DstPort=Microsoft-DS(445), PayloadLen=0, Seq=125899757, Ack=3354174038
HOST88.contoso.local  dc2.contoso.local  SMB2  SMB2:C   SESSION SETUP (0x1)
dc2.contoso.local  HOST88.contoso.local  SMB2  SMB2:R  - NT Status: System - Error, Code = (22) STATUS_MORE_PROCESSING_REQUIRED  SESSION SETUP (0x1), SessionFlags=0x0
HOST88.contoso.local  dc2.contoso.local  SMB2  SMB2:C   SESSION SETUP (0x1)
dc2.contoso.local  HOST88.contoso.local  SMB2  SMB2:R   SESSION SETUP (0x1), SessionFlags=0x0
HOST88.contoso.local  dc2.contoso.local  SMB2  SMB2:C   TREE CONNECT (0x3), Path=\\DC2.contoso.local\IPC$
dc2.contoso.local  HOST88.contoso.local  SMB2  SMB2:R   TREE CONNECT (0x3), TID=0x1
HOST88.contoso.local  dc2.contoso.local  SMB2  SMB2:C   IOCTL (0xb), FID=0xFFFFFFFFFFFFFFFF
dc2.contoso.local  HOST88.contoso.local  SMB2  SMB2:R   IOCTL (0xb)
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=...A...., SrcPort=49708, DstPort=Microsoft-DS(445), PayloadLen=0, Seq=125900788, Ack=3354174966
HOST88.contoso.local  dc2.contoso.local  SMB2  SMB2:C   CREATE (0x5), Sh(RWD), File=NETLOGON@#290
dc2.contoso.local  HOST88.contoso.local  SMB2  SMB2:R   CREATE (0x5), FID=0x1300000001(NETLOGON@#290)
HOST88.contoso.local  dc2.contoso.local  SMB2  SMB2:C   QUERY INFORMATION (0x10), Class=FileStandardInformation (5), FID=0x1300000001(NETLOGON@#290)
dc2.contoso.local  HOST88.contoso.local  SMB2  SMB2:R   QUERY INFORMATION (0x10), File=NETLOGON@#290
HOST88.contoso.local  dc2.contoso.local  MSRPC  MSRPC:c/o Bind: Netlogon(NRPC) UUID{12345678-1234-ABCD-EF00-01234567CFFB}  Call=0x2  Assoc Grp=0x0  Xmit=0x10B8  Recv=0x10B8
dc2.contoso.local  HOST88.contoso.local  SMB2  SMB2:R   WRITE (0x9), File=NETLOGON@#290
HOST88.contoso.local  dc2.contoso.local  SMB2  SMB2:C   READ (0x8), FID=0x1300000001  (NETLOGON@#290) , 0x400 bytes from offset 0 (0x0)
dc2.contoso.local  HOST88.contoso.local  MSRPC  MSRPC:c/o Bind Ack:  Call=0x2  Assoc Grp=0x47C8  Xmit=0x10B8  Recv=0x10B8
HOST88.contoso.local  dc2.contoso.local  NRPC  NRPC:DsrEnumerateDomainTrusts Request, ServerName = \\DC2.contoso.local, Flags = 0x0000003F
dc2.contoso.local  HOST88.contoso.local  NRPC  NRPC:DsrEnumerateDomainTrusts Response, DomainCount = 3, ReturnValue = ERROR_SUCCESS
HOST88.contoso.local  dc2.contoso.local  SMB2  SMB2:C   CLOSE (0x6), FID=0x1300000001(NETLOGON@#290)
dc2.contoso.local  HOST88.contoso.local  SMB2  SMB2:R   CLOSE (0x6), File=NETLOGON@#290
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=...A...., SrcPort=49708, DstPort=Microsoft-DS(445), PayloadLen=0, Seq=125901745, Ack=3354176362

```

### LDAP

LDAP traffic is used during domain join activity as well. Note that except for the leading LDAP search, which is for RootDSE and then the binding (authentication), the remaining LDAP traffic is encrypted. You cannot read the content in Network Monitor or Wireshark.

```output
Source  Destination  Protocol Name  Description
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=......S., SrcPort=49709, DstPort=LDAP(389), PayloadLen=0, Seq=2785227450, Ack=0
dc2.contoso.local  HOST88.contoso.local  TCP  TCP:Flags=...A..S., SrcPort=LDAP(389), DstPort=49709, PayloadLen=0, Seq=616784870, Ack=2785227451
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=...A...., SrcPort=49709, DstPort=LDAP(389), PayloadLen=0, Seq=2785227451, Ack=616784871
HOST88.contoso.local  dc2.contoso.local  LDAPMessage  LDAPMessage:Search Request, MessageID: 6
dc2.contoso.local  HOST88.contoso.local  LDAPMessage  LDAPMessage:Search Result Entry, MessageID: 6
dc2.contoso.local  HOST88.contoso.local  TCP  TCP:[Continuation to #161]Flags=...AP..., SrcPort=LDAP(389), DstPort=49709, PayloadLen=1258, Seq=616786331 - 616787589, Ack=2785227801
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=...A...., SrcPort=49709, DstPort=LDAP(389), PayloadLen=0, Seq=2785227801, Ack=616787589
HOST88.contoso.local  dc2.contoso.local  LDAPMessage  LDAPMessage:Bind Request, MessageID: 8
dc2.contoso.local  HOST88.contoso.local  LDAPMessage  LDAPMessage:Bind Response, MessageID: 8
HOST88.contoso.local  dc2.contoso.local  LDAPMessage  LDAPMessage:Bind Request, MessageID: 9
dc2.contoso.local  HOST88.contoso.local  LDAPMessage  LDAPMessage:Bind Response, MessageID: 9
HOST88.contoso.local  dc2.contoso.local  LDAPSASLBuffer  LDAPSASLBuffer:BufferLength: 160, AuthMechanism: GSS-SPNEGO
dc2.contoso.local  HOST88.contoso.local  LDAPSASLBuffer  LDAPSASLBuffer:BufferLength: 1270, AuthMechanism: GSS-SPNEGO
HOST88.contoso.local  dc2.contoso.local  LDAPSASLBuffer  LDAPSASLBuffer:BufferLength: 109, AuthMechanism: GSS-SPNEGO
dc2.contoso.local  HOST88.contoso.local  LDAPSASLBuffer  LDAPSASLBuffer:BufferLength: 171, AuthMechanism: GSS-SPNEGO
HOST88.contoso.local  dc2.contoso.local  LDAPSASLBuffer  LDAPSASLBuffer:BufferLength: 187, AuthMechanism: GSS-SPNEGO
dc2.contoso.local  HOST88.contoso.local  LDAPSASLBuffer  LDAPSASLBuffer:BufferLength: 156, AuthMechanism: GSS-SPNEGO
HOST88.contoso.local  dc2.contoso.local  LDAPSASLBuffer  LDAPSASLBuffer:BufferLength: 27, AuthMechanism: GSS-SPNEGO
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=...A...F, SrcPort=49709, DstPort=LDAP(389), PayloadLen=0, Seq=2785228906, Ack=616789460
dc2.contoso.local  HOST88.contoso.local  TCP  TCP:Flags=...A.R.., SrcPort=LDAP(389), DstPort=49709, PayloadLen=0, Seq=616789460, Ack=2785228906
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=......S., SrcPort=49712, DstPort=LDAP(389), PayloadLen=0, Seq=2375446589, Ack=0
233  11:29:07 AM 3/6/2025  60.9814190    dc2.contoso.local  HOST88.contoso.local  TCP  TCP:Flags=...A..S., SrcPort=LDAP(389), DstPort=49712, PayloadLen=0, Seq=3472306490, Ack=2375446590
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=...A...., SrcPort=49712, DstPort=LDAP(389), PayloadLen=0, Seq=2375446590, Ack=3472306491
HOST88.contoso.local  dc2.contoso.local  LDAPMessage  LDAPMessage:Bind Request, MessageID: 20
dc2.contoso.local  HOST88.contoso.local  LDAPMessage  LDAPMessage:Bind Response, MessageID: 20
HOST88.contoso.local  dc2.contoso.local  LDAPMessage  LDAPMessage:Bind Request, MessageID: 21
dc2.contoso.local  HOST88.contoso.local  LDAPMessage  LDAPMessage:Bind Response, MessageID: 21
HOST88.contoso.local  dc2.contoso.local  LDAPSASLBuffer  LDAPSASLBuffer:BufferLength: 160, AuthMechanism: GSS-SPNEGO
dc2.contoso.local  HOST88.contoso.local  LDAPSASLBuffer  LDAPSASLBuffer:BufferLength: 1270, AuthMechanism: GSS-SPNEGO
HOST88.contoso.local  dc2.contoso.local  LDAPSASLBuffer  LDAPSASLBuffer:BufferLength: 109, AuthMechanism: GSS-SPNEGO
dc2.contoso.local  HOST88.contoso.local  LDAPSASLBuffer  LDAPSASLBuffer:BufferLength: 171, AuthMechanism: GSS-SPNEGO
HOST88.contoso.local  dc2.contoso.local  LDAPSASLBuffer  LDAPSASLBuffer:BufferLength: 187, AuthMechanism: GSS-SPNEGO
```

### RPC

Remote Procedure Call (RPC) traffic starts from TCP 135 port. The client binds to the RPC Endpoint Mapper (EPMP in netmon trace) service at TCP 135 port, queries the actual port of DRSR and NetLogon services, and then connects those 2 services.

> [!NOTE]
> By default, the traffic of EPMAP doesn't requires authentication, but others traffics do.

#### EPMAP traffic

```output
Source  Destination  Protocol Name  Description
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=......S., SrcPort=49710, DstPort=DCE endpoint resolution(135), PayloadLen=0, Seq=2427001163, Ack=0
dc2.contoso.local  HOST88.contoso.local  TCP  TCP:Flags=...A..S., SrcPort=DCE endpoint resolution(135), DstPort=49710, PayloadLen=0, Seq=565983964, Ack=2427001164
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=...A...., SrcPort=49710, DstPort=DCE endpoint resolution(135), PayloadLen=0, Seq=2427001164, Ack=565983965
HOST88.contoso.local  dc2.contoso.local  MSRPC  MSRPC:c/o Bind: EPT(EPMP) UUID{E1AF8308-5D1F-11C9-91A4-08002B14A0FA}  Call=0x2  Assoc Grp=0x0  Xmit=0x16D0  Recv=0x16D0
dc2.contoso.local  HOST88.contoso.local  MSRPC  MSRPC:c/o Bind Ack:  Call=0x2  Assoc Grp=0x3AA1  Xmit=0x16D0  Recv=0x16D0
HOST88.contoso.local  dc2.contoso.local  EPM  EPM:Request: ept_map: NDR, DRSR(DRSR) {E3514235-4B06-11D1-AB04-00C04FC2DCD2} v4.0, RPC v5, 0.0.0.0:135 (0x87) [DCE endpoint resolution(135)]
dc2.contoso.local  HOST88.contoso.local  EPM  EPM:Response: ept_map: NDR, DRSR(DRSR) {E3514235-4B06-11D1-AB04-00C04FC2DCD2} v4.0, RPC v5192.168.100.10, 192.168.100.10:49664 (0xC200) [49664]
```

```output
  Frame: Number = 180, Captured Frame Length = 322, MediaType = ETHERNET
+ Ethernet: Etype = Internet IP (IPv4),DestinationAddress:[00-15-5D-3D-04-04],SourceAddress:[00-15-5D-3D-04-05]
+ Ipv4: Src = 192.168.100.10, Dest = 192.168.100.13, Next Protocol = TCP, Packet ID = 24520, Total IP Length = 308
+ Tcp: Flags=...AP..., SrcPort=DCE endpoint resolution(135), DstPort=49710, PayloadLen=268, Seq=565984073 - 565984341, Ack=2427001492, Win=8194 (scale factor 0x8) = 2097664
+ Msrpc: c/o Response: EPT(EPMP) {E1AF8308-5D1F-11C9-91A4-08002B14A0FA}  Call=0x2  Context=0x1  Hint=0xF4  Cancels=0x0 
- Epm: Response: ept_map: NDR, DRSR(DRSR) {E3514235-4B06-11D1-AB04-00C04FC2DCD2} v4.0, RPC v5192.168.100.10, 192.168.100.10:49664 (0xC200) [49664]
  + EntryHandle: 
    NumTowers: 2 (0x2)
  - Towers: 2 Elements
   + ArrayInfo: 2 Elements
   + TwrPtr: Pointer To 0x0000000000000003
   + TwrPtr: Pointer To 0x0000000000000004
   + Tower: NDR, DRSR(DRSR) {E3514235-4B06-11D1-AB04-00C04FC2DCD2} v4.0, RPC v5, 192.168.100.10:49671 (0xC207) [49671]
   + Tower: NDR, DRSR(DRSR) {E3514235-4B06-11D1-AB04-00C04FC2DCD2} v4.0, RPC v5192.168.100.10, 192.168.100.10:49664 (0xC200) [49664]
  + Pad: 1 Bytes
  + Status: 0x00000000 - EP_S_SUCCESS
```

#### DRSR traffic

```output
Source  Destination  Protocol Name  Description
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=......S., SrcPort=49711, DstPort=49671, PayloadLen=0, Seq=1098174753, Ack=0
dc2.contoso.local  HOST88.contoso.local  TCP  TCP:Flags=...A..S., SrcPort=49671, DstPort=49711, PayloadLen=0, Seq=57262962, Ack=1098174754
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=...A...., SrcPort=49711, DstPort=49671, PayloadLen=0, Seq=1098174754, Ack=57262963,
HOST88.contoso.local  dc2.contoso.local  MSRPC  MSRPC:c/o Bind: DRSR(DRSR) UUID{E3514235-4B06-11D1-AB04-00C04FC2DCD2}  Call=0x2  Assoc Grp=0x0  Xmit=0x16D0  Recv=0x16D0
dc2.contoso.local  HOST88.contoso.local  MSRPC  MSRPC:c/o Bind Ack:  Call=0x2  Assoc Grp=0x47C7  Xmit=0x16D0  Recv=0x16D0
HOST88.contoso.local  dc2.contoso.local  MSRPC  MSRPC:c/o Auth3:  Call=0x2
HOST88.contoso.local  dc2.contoso.local  DRSR  DRSR:drsuapi:IDL_DRSBind Request, *Encrypted*
dc2.contoso.local  HOST88.contoso.local  TCP  TCP:Flags=...A...., SrcPort=49671, DstPort=49711, PayloadLen=0, Seq=57263291, Ack=1098175682
dc2.contoso.local  HOST88.contoso.local  DRSR  DRSR:drsuapi:IDL_DRSBind Response, *Encrypted*
HOST88.contoso.local  dc2.contoso.local  DRSR  DRSR:drsuapi:IDL_DRSCrackNames Request, *Encrypted*
dc2.contoso.local  HOST88.contoso.local  DRSR  DRSR:drsuapi:IDL_DRSCrackNames Response, *Encrypted*
HOST88.contoso.local  dc2.contoso.local  DRSR  DRSR:drsuapi:IDL_DRSCrackNames Request, *Encrypted*
dc2.contoso.local  HOST88.contoso.local  DRSR  DRSR:drsuapi:IDL_DRSCrackNames Response, *Encrypted*
HOST88.contoso.local  dc2.contoso.local  DRSR  DRSR:drsuapi:IDL_DRSUnbind Request, *Encrypted*
dc2.contoso.local  HOST88.contoso.local  DRSR  DRSR:drsuapi:IDL_DRSUnbind Response, *Encrypted*
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=...A...., SrcPort=49711, DstPort=49671, PayloadLen=0, Seq=1098176146, Ack=57263867
HOST88.contoso.local  dc2.contoso.local  DRSR  DRSR:drsuapi:IDL_DRSBind Request, *Encrypted*
dc2.contoso.local  HOST88.contoso.local  DRSR  DRSR:drsuapi:IDL_DRSBind Response, *Encrypted*
HOST88.contoso.local  dc2.contoso.local  DRSR  DRSR:drsuapi:IDL_DRSCrackNames Request, *Encrypted*
dc2.contoso.local  HOST88.contoso.local  DRSR  DRSR:drsuapi:IDL_DRSCrackNames Response, *Encrypted*
HOST88.contoso.local  dc2.contoso.local  DRSR  DRSR:drsuapi:IDL_DRSCrackNames Request, *Encrypted*
dc2.contoso.local  HOST88.contoso.local  DRSR  DRSR:drsuapi:IDL_DRSCrackNames Response, *Encrypted*
HOST88.contoso.local  dc2.contoso.local  DRSR  DRSR:drsuapi:IDL_DRSCrackNames Request, *Encrypted*
dc2.contoso.local  HOST88.contoso.local  DRSR  DRSR:drsuapi:IDL_DRSCrackNames Response, *Encrypted*
HOST88.contoso.local  dc2.contoso.local  DRSR  DRSR:drsuapi:IDL_DRSUnbind Request, *Encrypted*
dc2.contoso.local  HOST88.contoso.local  DRSR  DRSR:drsuapi:IDL_DRSUnbind Response, *Encrypted*
```

#### NetLogon traffic

```output
Source  Destination  Protocol Name  Description
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=......S., SrcPort=49735, DstPort=49682, PayloadLen=0, Seq=2988617269, Ack=0
dc2.contoso.local  HOST88.contoso.local  TCP  TCP:Flags=...A..S., SrcPort=49682, DstPort=49735, PayloadLen=0, Seq=225723440, Ack=2988617270
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=...A...., SrcPort=49735, DstPort=49682, PayloadLen=0, Seq=2988617270, Ack=225723441
HOST88.contoso.local  dc2.contoso.local  MSRPC  MSRPC:c/o Bind: Netlogon(NRPC) UUID{12345678-1234-ABCD-EF00-01234567CFFB}  Call=0x2  Assoc Grp=0x0  Xmit=0x16D0  Recv=0x16D0
dc2.contoso.local  HOST88.contoso.local  MSRPC  MSRPC:c/o Bind Ack:  Call=0x2  Assoc Grp=0x47C9  Xmit=0x16D0  Recv=0x16D0
HOST88.contoso.local  dc2.contoso.local  NRPC  NRPC:NetrServerReqChallenge Request, PrimaryName = \\DC2.contoso.local, ComputerName = HOST88
dc2.contoso.local  HOST88.contoso.local  NRPC  NRPC:NetrServerReqChallenge Response, ReturnValue = Success
HOST88.contoso.local  dc2.contoso.local  NRPC  NRPC:NetrServerAuthenticate3 Request, PrimaryName = \\DC2.contoso.local, AccountName = HOST88$, ComputerName = HOST88, SecureChannelType = WorkstationSecureChannel , NegotiateFlags = 0x612FFFFF
dc2.contoso.local  HOST88.contoso.local  NRPC  NRPC:NetrServerAuthenticate3 Response, NegotiateFlags = 0x612FFFFF, AccountRid = 1603, ReturnValue = Success
HOST88.contoso.local  dc2.contoso.local  MSRPC  MSRPC:c/o Alter Cont: Netlogon(NRPC)  UUID{12345678-1234-ABCD-EF00-01234567CFFB}  Call=0x4
dc2.contoso.local  HOST88.contoso.local  MSRPC  MSRPC:c/o Alter Cont Resp:  Call=0x4  Assoc Grp=0x47C9  Xmit=0x16D0  Recv=0x16D0
HOST88.contoso.local  dc2.contoso.local  NRPC  NRPC:NetrLogonGetCapabilities Request, *Encrypted*
dc2.contoso.local  HOST88.contoso.local  NRPC  NRPC:NetrLogonGetCapabilities Response, *Encrypted*
HOST88.contoso.local  dc2.contoso.local  NRPC  NRPC:NetrLogonGetCapabilities Request, *Encrypted*
dc2.contoso.local  HOST88.contoso.local  NRPC  NRPC:NetrLogonGetCapabilities Response, *Encrypted*
HOST88.contoso.local  dc2.contoso.local  NRPC  NRPC:NetrLogonGetDomainInfo Request, *Encrypted*  
dc2.contoso.local  HOST88.contoso.local  NRPC  NRPC:NetrLogonGetDomainInfo Response, partial*Un-Interpreted*
dc2.contoso.local  HOST88.contoso.local  TCP  TCP:[Continuation to #561]Flags=...AP..., SrcPort=49682, DstPort=49735, PayloadLen=148, Seq=225725405 - 225725553, Ack=2988619262
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=...A...., SrcPort=49735, DstPort=49682, PayloadLen=0, Seq=2988619262, Ack=225725553
```

### Kerberos

Kerberos traffic also appears during domain join operation. The miscellaneous types of network traffic mentioned above, including SMB, LDAP and RPC, all require authentication. Typically, Kerberos is used.

For example, in the following network trace, the client gets a Kerberos TGT for the user account **CONTOSO\puser2** and the service ticket for the target SPN **cifs/DC2.contoso.local**. Then the client sets up the SMB session to the DC DC2.contoso.local with that service ticket.

```output
Source  Destination  Protocol Name  Description
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=......S., SrcPort=49744, DstPort=Microsoft-DS(445), PayloadLen=0, Seq=787220943, Ack=0
dc2.contoso.local  HOST88.contoso.local  TCP  TCP:Flags=...A..S., SrcPort=Microsoft-DS(445), DstPort=49744, PayloadLen=0, Seq=3412289245, Ack=787220944
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=...A...., SrcPort=49744, DstPort=Microsoft-DS(445), PayloadLen=0, Seq=787220944, Ack=3412289246
HOST88.contoso.local  dc2.contoso.local  SMB  SMB:C; Negotiate, Dialect = NT LM 0.12, SMB 2.002, SMB 2.???
dc2.contoso.local  HOST88.contoso.local  SMB2  SMB2:R   NEGOTIATE (0x0), GUID={AAE1D73A-9C29-A9B8-48C1-BDD3D0C60992}
HOST88.contoso.local  dc2.contoso.local  SMB2  SMB2:C   NEGOTIATE (0x0), GUID={04043D5D-1500-D1B7-11F0-0F9CE8E3C36C}
dc2.contoso.local  HOST88.contoso.local  SMB2  SMB2:R   NEGOTIATE (0x0), GUID={AAE1D73A-9C29-A9B8-48C1-BDD3D0C60992}
HOST88.contoso.local  dc1.contoso.local  KerberosV5  KerberosV5:AS Request Cname: puser2 Realm: contoso.local Sname: krbtgt/contoso.local
dc1.contoso.local  HOST88.contoso.local  KerberosV5  KerberosV5:KRB_ERROR  - KDC_ERR_PREAUTH_REQUIRED (25)
HOST88.contoso.local  dc1.contoso.local  KerberosV5  KerberosV5:AS Request Cname: puser2 Realm: contoso.local Sname: krbtgt/contoso.local
dc1.contoso.local  HOST88.contoso.local  KerberosV5  KerberosV5:AS Response Ticket[Realm: CONTOSO.LOCAL, Sname: krbtgt/CONTOSO.LOCAL]
HOST88.contoso.local  dc1.contoso.local  KerberosV5  KerberosV5:TGS Request Realm: CONTOSO.LOCAL Sname: cifs/DC2.contoso.local
dc1.contoso.local  HOST88.contoso.local  KerberosV5  KerberosV5:TGS Response Cname: puser2
HOST88.contoso.local  dc2.contoso.local  SMB2  SMB2:C   SESSION SETUP (0x1)
dc2.contoso.local  HOST88.contoso.local  TCP  TCP:Flags=...A...., SrcPort=Microsoft-DS(445), DstPort=49744, PayloadLen=0, Seq=3412289874, Ack=787223156
dc2.contoso.local  HOST88.contoso.local  SMB2  SMB2:R   SESSION SETUP (0x1), SessionFlags=0x0
HOST88.contoso.local  dc2.contoso.local  SMB2  SMB2:C   TREE CONNECT (0x3), Path=\\DC2.contoso.local\IPC$
dc2.contoso.local  HOST88.contoso.local  SMB2  SMB2:R   TREE CONNECT (0x3), TID=0x1
HOST88.contoso.local  dc2.contoso.local  SMB2  SMB2:C   IOCTL (0xb), FID=0xFFFFFFFFFFFFFFFF
dc2.contoso.local  HOST88.contoso.local  SMB2  SMB2:R   IOCTL (0xb)
```

```output
- SMB2: C   SESSION SETUP (0x1) 
    SMBIdentifier: SMB
  + SMB2Header: C SESSION SETUP (0x1),TID=0x0000, MID=0x0002, PID=0xFEFF, SID=0x0000
  - CSessionSetup: 
     StructureSize: 25 (0x19)
     VcNumber: 0 (0x0)
   + SecurityMode: 2 (0x2)
   + Capabilities: 0x1
     Channel: 0 (0x0)
     SecurityBufferOffset: 88 (0x58)
     SecurityBufferLength: 1743 (0x6CF)
     PreviousSessionId: 0 (0x0)
   - securityBlob: 
    - GSSAPI: 
     - InitialContextToken: 
      + ApplicationHeader: 
      + ThisMech: SpnegoToken (1.3.6.1.5.5.2)
      - InnerContextToken: 0x1
       - SpnegoToken: 0x1
        + ChoiceTag: 
        - NegTokenInit: 
         + SequenceHeader: 
         + Tag0: 
         + MechTypes: Prefer MsKerberosToken (1.2.840.48018.1.2.2)
         + Tag2: 
         + OctetStringHeader: 
         - MechToken: 0x1
          - MsKerberosToken: 0x1
           - KerberosInitToken: 
            + ApplicationHeader: 
            + ThisMech: KerberosToken (1.2.840.113554.1.2.2)
            - InnerContextToken: 0x1
             - KerberosToken: 0x1
                TokId: Krb5ApReq (0x100)
              - ApReq: KRB_AP_REQ (14)
               + ApplicationTag: 
               + SequenceHeader: 
               + Tag0: 
               + PvNo: 5
               + Tag1: 
               + MsgType: KRB_AP_REQ (14)
               + Tag2: 0x1
               + ApOptions: 
               + Tag3: 
               + Ticket: Realm: CONTOSO.LOCAL, Sname: cifs/DC2.contoso.local
```


Depending on the format of the user credential provided for the domain join operation (e.g., puser2@contoso.local or contoso\puser2 or contoso.local\puser2), you may see different Kerberos traffic.

#### About NTLM

Even if you don't see any Kerberos traffic, that doesn't necessarily mean the domain join operation must fail. This is because when Kerberos cannot work under some scenarios, NTLM will be tried as the fallback. As long as nothing is preventing NTLM from working properly such as incompatible LMCompatibilityLevel or blocked NTLM authentication in Group Policy, domain join may still complete successfully with NTLM.

Below is an example of successful SMB session setup using NTLM authentication.

```output
Source  Destination  Protocol Name  Description
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=......S., SrcPort=49708, DstPort=Microsoft-DS(445), PayloadLen=0, Seq=125899379, Ack=0
dc2.contoso.local  HOST88.contoso.local  TCP  TCP:Flags=...A..S., SrcPort=Microsoft-DS(445), DstPort=49708, PayloadLen=0, Seq=3354173409, Ack=125899380
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=...A...., SrcPort=49708, DstPort=Microsoft-DS(445), PayloadLen=0, Seq=125899380, Ack=3354173410
HOST88.contoso.local  dc2.contoso.local  SMB  SMB:C; Negotiate, Dialect = NT LM 0.12, SMB 2.002, SMB 2.???
dc2.contoso.local  HOST88.contoso.local  SMB2  SMB2:R   NEGOTIATE (0x0), GUID={AEEC955A-89D6-C899-40AB-A8E0AA928A2C}
HOST88.contoso.local  dc2.contoso.local  SMB2  SMB2:C   NEGOTIATE (0x0), GUID={04043D5D-1500-C3B7-11EF-FA3AB1842093}
dc2.contoso.local  HOST88.contoso.local  SMB2  SMB2:R   NEGOTIATE (0x0), GUID={AEEC955A-89D6-C899-40AB-A8E0AA928A2C}
HOST88.contoso.local  dc2.contoso.local  TCP  TCP:Flags=...A...., SrcPort=49708, DstPort=Microsoft-DS(445), PayloadLen=0, Seq=125899757, Ack=3354174038
HOST88.contoso.local  dc2.contoso.local  SMB2  SMB2:C   SESSION SETUP (0x1)
dc2.contoso.local  HOST88.contoso.local  SMB2  SMB2:R  - NT Status: System - Error, Code = (22) STATUS_MORE_PROCESSING_REQUIRED  SESSION SETUP (0x1), SessionFlags=0x0
HOST88.contoso.local  dc2.contoso.local  SMB2  SMB2:C   SESSION SETUP (0x1)
dc2.contoso.local  HOST88.contoso.local  SMB2  SMB2:R   SESSION SETUP (0x1), SessionFlags=0x0
HOST88.contoso.local  dc2.contoso.local  SMB2  SMB2:C   TREE CONNECT (0x3), Path=\\DC2.contoso.local\IPC$
System  dc2.contoso.local  HOST88.contoso.local  SMB2  SMB2:R   TREE CONNECT (0x3), TID=0x1
```

```output
- SMB2: C   SESSION SETUP (0x1) 
    SMBIdentifier: SMB
  + SMB2Header: C SESSION SETUP (0x1),TID=0x0000, MID=0x0003, PID=0xFEFF, SID=0x2000003D
  - CSessionSetup: 
     StructureSize: 25 (0x19)
     VcNumber: 0 (0x0)
   + SecurityMode: 2 (0x2)
   + Capabilities: 0x1
     Channel: 0 (0x0)
     SecurityBufferOffset: 88 (0x58)
     SecurityBufferLength: 525 (0x20D)
     PreviousSessionId: 0 (0x0)
   - securityBlob: 
    - GSSAPI: 
     - NegotiationToken: 
      + ChoiceTag: 
      - NegTokenResp: 
       + SequenceHeader: 
       + Tag0: 
       + NegState: accept-incomplete (1)
       + Tag2: 
       + OctetStringHeader: 
       + ResponseToken: NTLM AUTHENTICATE MESSAGEVersion:v2, Domain: contoso, User: puser2, Workstation: HOST88
       + Tag3: 
       + OctetStringHeader: 
       + MechListMic: Version: 1

```

# Conclusion

Understanding the various logs and network traffic types involved in an AD domain join can significantly aid in troubleshooting and resolving AD domain join failures. By comparing logs from successful and unsuccessful attempts and analyzing the traffic patterns, you can pinpoint where issues arise and address them effectively.


:date: Page updated by dennhu to substitute the sample `netsetup.log` from a Win11 24H2 machine. Also update the RPC and Kerberos sections. 04/04/2025.

:date: Page updated by dennhu to substitute texts for all screenshots. 05/20/2025.
