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

The following sample is the typical `Netsetup.log` covering a successful AD domain join to the domain named *contoso.local*, collected from a Windows 10 24H2 virtual machine (VM) named *PC8*.

See lines starting with **//** for explanations.

```output
03/06/2025 11:28:14:530 -----------------------------------------------------------------
03/06/2025 11:28:14:530 NetpValidateName: checking to see if 'PC8' is valid as type 1 name
03/06/2025 11:28:14:530 NetpCheckNetBiosNameNotInUse for 'PC8' [MACHINE] returned 0x0
03/06/2025 11:28:14:530 NetpValidateName: name 'PC8' is valid for type 1
03/06/2025 11:28:14:541 -----------------------------------------------------------------
03/06/2025 11:28:14:541 NetpValidateName: checking to see if 'PC8' is valid as type 5 name
03/06/2025 11:28:14:541 NetpValidateName: name 'PC8' is valid for type 5

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
03/06/2025 11:29:05:537 NetpMachineValidToJoin: 'PC8'
03/06/2025 11:29:05:537   OS Version: 10.0
03/06/2025 11:29:05:537   Build number: 26100 (26100.ge_release.240331-1435)
03/06/2025 11:29:05:548   SKU: Windows 11 Enterprise
03/06/2025 11:29:05:548   Architecture: 64-bit (AMD64)
03/06/2025 11:29:05:559 NetpMachineValidToJoin: status: 0x0
03/06/2025 11:29:05:559 NetpJoinDomain
03/06/2025 11:29:05:559   HostName: PC8
03/06/2025 11:29:05:559   NetbiosName: PC8
03/06/2025 11:29:05:559   Domain: contoso.local
03/06/2025 11:29:05:559   MachineAccountOU: (NULL)
03/06/2025 11:29:05:559   Account: contoso\puser2
03/06/2025 11:29:05:559   Options: 0x25
03/06/2025 11:29:05:569 NetpValidateName: checking to see if 'contoso.local' is valid as type 3 name
03/06/2025 11:29:05:632 NetpCheckDomainNameIsValid [ Exists ] for 'contoso.local' returned 0x0
03/06/2025 11:29:05:632 NetpValidateName: name 'contoso.local' is valid for type 3
03/06/2025 11:29:05:632 NetpDsGetDcName: trying to find DC in domain 'contoso.local', flags: 0x40001010
03/06/2025 11:29:06:519 NetpDsGetDcName: failed to find a DC having account 'PC8$': 0x525, last error is 0x0
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
03/06/2025 11:29:06:678   lpHostName: PC8
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
03/06/2025 11:29:06:739 NetpGetComputerObjectDn: Cracking account name CONTOSO\PC8$ on \\DC2.contoso.local
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
03/06/2025 11:29:06:755 NetpMachineValidToJoin: 'PC8'
03/06/2025 11:29:06:755   OS Version: 10.0
03/06/2025 11:29:06:755   Build number: 26100 (26100.ge_release.240331-1435)
03/06/2025 11:29:06:760   SKU: Windows 11 Enterprise
03/06/2025 11:29:06:760   Architecture: 64-bit (AMD64)
03/06/2025 11:29:06:762 NetpMachineValidToJoin: status: 0x0
03/06/2025 11:29:06:762 NetpJoinDomain
03/06/2025 11:29:06:762   HostName: PC8
03/06/2025 11:29:06:762   NetbiosName: PC8
03/06/2025 11:29:06:762   Domain: contoso.local
03/06/2025 11:29:06:762   MachineAccountOU: (NULL)
03/06/2025 11:29:06:762   Account: contoso\puser2
03/06/2025 11:29:06:762   Options: 0x27
03/06/2025 11:29:06:768 NetpValidateName: checking to see if 'contoso.local' is valid as type 3 name
03/06/2025 11:29:06:835 NetpCheckDomainNameIsValid [ Exists ] for 'contoso.local' returned 0x0
03/06/2025 11:29:06:835 NetpValidateName: name 'contoso.local' is valid for type 3
03/06/2025 11:29:06:835 NetpDsGetDcName: trying to find DC in domain 'contoso.local', flags: 0x40001010
03/06/2025 11:29:07:703 NetpDsGetDcName: failed to find a DC having account 'PC8$': 0x525, last error is 0x0
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
03/06/2025 11:29:07:719   lpHostName: PC8
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
03/06/2025 11:29:07:750 NetpGetComputerObjectDn: Cracking account name CONTOSO\PC8$ on \\DC2.contoso.local
03/06/2025 11:29:07:750 NetpGetComputerObjectDn: Crack results:   Account does not exist
03/06/2025 11:29:07:750 NetpGetComputerObjectDn: Cracking Netbios domain name CONTOSO\ into root DN on \\DC2.contoso.local
03/06/2025 11:29:07:750 NetpGetComputerObjectDn: Crack results:   name = DC=contoso,DC=local
03/06/2025 11:29:07:750 NetpGetComputerObjectDn: Got DN CN=PC8,CN=Computers,DC=contoso,DC=local from the default computer container
03/06/2025 11:29:07:750 NetpGetADObjectOwnerAttributes: Looking up attributes for machine account: CN=PC8,CN=Computers,DC=contoso,DC=local
03/06/2025 11:29:07:750 NetpGetADObjectOwnerAttributes: Ldap Search failed: 8240
03/06/2025 11:29:07:750 NetpCheckIfAccountShouldBeReused: Computer Object does not exist in OU.
03/06/2025 11:29:07:750 NetpCheckIfAccountShouldBeReused:fReuseAllowed: TRUE, NetStatus:0x2030

//Computer object is created.
03/06/2025 11:29:07:750 NetpModifyComputerObjectInDs: Initial attribute values:
03/06/2025 11:29:07:750     objectClass  =  Computer
03/06/2025 11:29:07:750     SamAccountName  =  PC8$
03/06/2025 11:29:07:750     userAccountControl  =  0x1000
03/06/2025 11:29:07:750     DnsHostName  =  PC8.contoso.local
03/06/2025 11:29:07:750     ServicePrincipalName  =  HOST/PC8.contoso.local  RestrictedKrbHost/PC8.contoso.local  HOST/PC8  RestrictedKrbHost/PC8
03/06/2025 11:29:07:750     unicodePwd  =  <SomePassword>
03/06/2025 11:29:07:750 NetpModifyComputerObjectInDs: Computer Object does not exist in OU
03/06/2025 11:29:07:750 NetpModifyComputerObjectInDs: Attribute values to set:
03/06/2025 11:29:07:750     objectClass  =  Computer
03/06/2025 11:29:07:750     SamAccountName  =  PC8$
03/06/2025 11:29:07:750     userAccountControl  =  0x1000
03/06/2025 11:29:07:750     DnsHostName  =  PC8.contoso.local
03/06/2025 11:29:07:750     ServicePrincipalName  =  HOST/PC8.contoso.local  RestrictedKrbHost/PC8.contoso.local  HOST/PC8  RestrictedKrbHost/PC8
03/06/2025 11:29:07:750     unicodePwd  =  <SomePassword>
03/06/2025 11:29:07:857 Querying "CN=PC8,CN=Computers,DC=contoso,DC=local" for objectSid\objectGuid attributes

//SID of the new computer account.
03/06/2025 11:29:07:859 NetpQueryAccountAttributes succeeded: got RID=0x643 objectSid=S-1-5-21-3127289744-4148518019-814850311-1603
03/06/2025 11:29:07:859 NetpDeleteMachineAccountKey: called for computer 'PC8'
03/06/2025 11:29:07:867 NetpGetComputerObjectDn: Cracking DNS domain name contoso.local/ into Netbios on \\DC2.contoso.local
03/06/2025 11:29:07:867 NetpGetComputerObjectDn: Crack results:   name = CONTOSO\
03/06/2025 11:29:07:867 NetpGetComputerObjectDn: Cracking account name CONTOSO\PC8$ on \\DC2.contoso.local
03/06/2025 11:29:07:876 NetpGetComputerObjectDn: Crack results:   (Account already exists) DN = CN=PC8,CN=Computers,DC=contoso,DC=local
03/06/2025 11:29:07:876 NetpDeleteMachineAccountKey: msDS-KeyCredentialLink attr was not found on computer 'PC8' - no action required.
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
03/06/2025 11:29:10:559 NetpChangeMachineName: from 'PC8' to 'PC8' using 'contoso\puser2' [0x1000]
03/06/2025 11:29:10:559 NetpChangeMachineName: using DnsHostnameToComputerNameEx
03/06/2025 11:29:10:559 NetpChangeMachineName: generated netbios name: 'PC8'
03/06/2025 11:29:10:559 NetpDsGetDcName: trying to find DC in domain 'contoso.local', flags: 0x1010
03/06/2025 11:29:10:559 NetpDsGetDcName: found DC '\\DC2.contoso.local' in the specified domain
03/06/2025 11:29:10:559 NetpGetDnsHostName: Read NV Domain: contoso.local
03/06/2025 11:29:14:830 NetpGetComputerObjectDn: Cracking DNS domain name contoso.local/ into Netbios on \\DC2.contoso.local
03/06/2025 11:29:14:830 NetpGetComputerObjectDn: Crack results:   name = CONTOSO\
03/06/2025 11:29:14:830 NetpGetComputerObjectDn: Cracking account name CONTOSO\PC8$ on \\DC2.contoso.local
03/06/2025 11:29:14:830 NetpGetComputerObjectDn: Crack results:   (Account already exists) DN = CN=PC8,CN=Computers,DC=contoso,DC=local
03/06/2025 11:29:14:844 NetpModifyComputerObjectInDs: Initial attribute values:
03/06/2025 11:29:14:844     DnsHostName  =  PC8.contoso.local
03/06/2025 11:29:14:844     ServicePrincipalName  =  HOST/PC8.contoso.local  RestrictedKrbHost/PC8.contoso.local  HOST/PC8  RestrictedKrbHost/PC8
03/06/2025 11:29:14:844 NetpModifyComputerObjectInDs: Computer Object already exists in OU:
03/06/2025 11:29:14:844     DnsHostName  =  PC8.contoso.local
03/06/2025 11:29:14:844     ServicePrincipalName  =  RestrictedKrbHost/PC8  HOST/PC8  RestrictedKrbHost/PC8.contoso.local  HOST/PC8.contoso.local
03/06/2025 11:29:14:844 NetpModifyComputerObjectInDs: There are _NO_ modifications to do
03/06/2025 11:29:14:844 ldap_unbind status: 0x0
03/06/2025 11:29:14:844 NetpChangeMachineName: status of setting DnsHostName and SPN: 0x0
03/06/2025 11:29:14:844 NetpChangeMachineName: DsrIsDeviceJoinedEx returned false. dsrInstance = 0
03/06/2025 11:29:14:862 NetpChangeMachineName: SetComputerNameEx() returned 0x1
```

## Network traces

Network traces are helpful in pinpointing AD domain join issues. During an AD domain join operation, multiple types of traffic occur between the client and some Domain Name System (DNS) server, and then between the client and some DCs. The following sections discuss each type of traffic.

### DNS

The client queries the DNS SRV record to locate the DCs of the domain to join. In the following example, the client manages to locate two DCs.

```output
Source		Destination	Protocol	Info
192.168.100.13	192.168.100.12	DNS		Standard query 0xa793 SRV _ldap._tcp.dc._msdcs.contoso.local
192.168.100.12	192.168.100.13	DNS		Standard query response 0xa793 SRV _ldap._tcp.dc._msdcs.contoso.local SRV 0 100 389 dc2.contoso.local SRV 0 100 389 dc1.contoso.local A 192.168.100.10 A 192.168.100.12
192.168.100.13	192.168.100.12	DNS		Standard query 0x623b A dc2.contoso.local
192.168.100.12	192.168.100.13	DNS		Standard query response 0x623b A dc2.contoso.local A 192.168.100.10
```

```output
Internet Protocol Version 4, Src: 192.168.100.12, Dst: 192.168.100.13
User Datagram Protocol, Src Port: 53, Dst Port: 53141
Domain Name System (response)
    Transaction ID: 0xa793
    Flags: 0x8580 Standard query response, No error
    Questions: 1
    Answer RRs: 2
    Authority RRs: 0
    Additional RRs: 2
    Queries
        _ldap._tcp.dc._msdcs.contoso.local: type SRV, class IN
    Answers
        _ldap._tcp.dc._msdcs.contoso.local: type SRV, class IN, priority 0, weight 100, port 389, target dc2.contoso.local
        _ldap._tcp.dc._msdcs.contoso.local: type SRV, class IN, priority 0, weight 100, port 389, target dc1.contoso.local
    Additional records
        dc2.contoso.local: type A, class IN, addr 192.168.100.10
        dc1.contoso.local: type A, class IN, addr 192.168.100.12
```

### LDAP ping

Then the client picks up one of the DCs and uses Lightweight Directory Access Protocol (LDAP) ping over UDP port 389 to detect the functionalities of that DC.

```output
Source		Destination	Protocol	Info
192.168.100.13	192.168.100.10	CLDAP		searchRequest(1) "<ROOT>" baseObject 
192.168.100.10	192.168.100.13	CLDAP		searchResEntry(1) "<ROOT>" searchResDone(1) success  [1 result]
```

In the response, the DC provides the general information of the domain and that DC's current capabilities.

```output
Internet Protocol Version 4, Src: 192.168.100.10, Dst: 192.168.100.13
User Datagram Protocol, Src Port: 389, Dst Port: 53143
Connectionless Lightweight Directory Access Protocol
    LDAPMessage searchResEntry(1) "<ROOT>" [1 result]
        messageID: 1
        protocolOp: searchResEntry (4)
            searchResEntry
                objectName: <MISSING>
                attributes: 1 item
                    PartialAttributeList item Netlogon
                        type: Netlogon
                        vals: 1 item
                            Operation code: LOGON_SAM_LOGON_RESPONSE_EX (23)
                             […]Flags: 0x0001f15c, WDC: Domain controller is a Windows 2008 writable NC, Writable: This dc is WRITABLE, Time Serv: This dc is running TIME SERVICES (ntp), DS: This dc supports DS, LDAP: This is an LDAP server, GC: This is a GLOBAL CA
                                0... .... .... .... .... .... .... .... = FDC: The NC is not the default forest NC (Windows 2008)
                                .0.. .... .... .... .... .... .... .... = DNC: The NC is not the default NC (Windows 2008)
                                ..0. .... .... .... .... .... .... .... = DNS: Server name is not in DNS format (Windows 2008)
                                .... .... .... .... ...1 .... .... .... = WDC: Domain controller is a Windows 2008 writable NC
                                .... .... .... .... .... 0... .... .... = RODC: Domain controller is not a Windows 2008 RODC
                                .... .... .... .... .... .0.. .... .... = NDNC: Domain is NOT non-domain nc serviced by ldap server
                                .... .... .... .... .... ..0. .... .... = Good Time Serv: This dc does NOT have a good time service (i.e. no hardware clock)
                                .... .... .... .... .... ...1 .... .... = Writable: This dc is WRITABLE
                                .... .... .... .... .... .... 0... .... = Closest: This server is NOT in the same site as the client
                                .... .... .... .... .... .... .1.. .... = Time Serv: This dc is running TIME SERVICES (ntp)
                                .... .... .... .... .... .... ..0. .... = KDC: This is NOT a kdc (kerberos)
                                .... .... .... .... .... .... ...1 .... = DS: This dc supports DS
                                .... .... .... .... .... .... .... 1... = LDAP: This is an LDAP server
                                .... .... .... .... .... .... .... .1.. = GC: This is a GLOBAL CATALOGUE of forest
                                .... .... .... .... .... .... .... ...0 = PDC: This is NOT a pdc
                            Domain GUID: 0b9f6161-49e4-46dd-b912-86494f62ba53
                            Forest: contoso.local
                            Domain: contoso.local
                            Hostname: DC2.contoso.local
                            NetBIOS Domain: CONTOSO
                            NetBIOS Hostname: DC2
                            Username: <Root>
                            Server Site: Default-First-Site-Name
                            Client Site: <Root>
                            Version Flags: 0x00000005, V1: Client requested version 1 netlogon response, V5EX: Client requested version 5 extended netlogon response
                            LM Token: 0xffff
                            NT Token: 0xffff
        [Response To: 9]
        [Time: 0.003877200 seconds]
    LDAPMessage searchResDone(1) success [1 result]
```

### SMB

During AD domain join, Server Message Block (SMB) traffic is employed for Microsoft Remote Procedure Call (MSRPC) based communication.

```output
Source		Destination	Protocol	Info
192.168.100.13	192.168.100.10	TCP		49708 → 445 [SYN] Seq=0 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.10	192.168.100.13	TCP		445 → 49708 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.13	192.168.100.10	TCP		49708 → 445 [ACK] Seq=1 Ack=1 Win=65280 Len=0
192.168.100.13	192.168.100.10	SMB		Negotiate Protocol Request
192.168.100.10	192.168.100.13	SMB2		Negotiate Protocol Response
192.168.100.13	192.168.100.10	SMB2		Negotiate Protocol Request
192.168.100.10	192.168.100.13	SMB2		Negotiate Protocol Response
192.168.100.13	192.168.100.10	TCP		49708 → 445 [ACK] Seq=378 Ack=629 Win=64768 Len=0
192.168.100.13	192.168.100.10	SMB2		Session Setup Request, NTLMSSP_NEGOTIATE
192.168.100.10	192.168.100.13	SMB2		Session Setup Response, Error: STATUS_MORE_PROCESSING_REQUIRED, NTLMSSP_CHALLENGE
192.168.100.13	192.168.100.10	SMB2		Session Setup Request, NTLMSSP_AUTH, User: contoso\puser2
192.168.100.10	192.168.100.13	SMB2		Session Setup Response
192.168.100.13	192.168.100.10	SMB2		Tree Connect Request Tree: \\DC2.contoso.local\IPC$
192.168.100.10	192.168.100.13	SMB2		Tree Connect Response
192.168.100.13	192.168.100.10	SMB2		Ioctl Request FSCTL_QUERY_NETWORK_INTERFACE_INFO
192.168.100.10	192.168.100.13	SMB2		Ioctl Response FSCTL_QUERY_NETWORK_INTERFACE_INFO
192.168.100.13	192.168.100.10	TCP		49708 → 445 [ACK] Seq=1409 Ack=1557 Win=65280 Len=0
192.168.100.13	192.168.100.10	SMB2		Create Request File: NETLOGON
192.168.100.10	192.168.100.13	SMB2		Create Response File: NETLOGON
192.168.100.13	192.168.100.10	SMB2		GetInfo Request FILE_INFO/SMB2_FILE_STANDARD_INFO File: NETLOGON
192.168.100.10	192.168.100.13	SMB2		GetInfo Response
192.168.100.13	192.168.100.10	DCERPC		Bind: call_id: 2, Fragment: Single, 3 context items: RPC_NETLOGON V1.0 (32bit NDR), RPC_NETLOGON V1.0 (64bit NDR), RPC_NETLOGON V1.0 (6cb71c2c-9812-4540-0300-000000000000)
192.168.100.10	192.168.100.13	SMB2		Write Response
192.168.100.13	192.168.100.10	SMB2		Read Request Len:1024 Off:0 File: NETLOGON
192.168.100.10	192.168.100.13	DCERPC		Bind_ack: call_id: 2, Fragment: Single, max_xmit: 4280 max_recv: 4280, 3 results: Provider rejection, Acceptance, Negotiate ACK
192.168.100.13	192.168.100.10	RPC_NETLOGON	DsrEnumerateDomainTrusts request
192.168.100.10	192.168.100.13	RPC_NETLOGON	DsrEnumerateDomainTrusts response
192.168.100.13	192.168.100.10	SMB2		Close Request File: NETLOGON
192.168.100.10	192.168.100.13	SMB2		Close Response
192.168.100.13	192.168.100.10	TCP		49708 → 445 [ACK] Seq=2366 Ack=2953 Win=64000 Len=0
```

### LDAP

LDAP traffic is used during domain join activity as well.

> [!NOTE]
> Except for the leading LDAP search, which is for RootDSE and then the binding (authentication), the remaining LDAP traffic is encrypted. You cannot read the content in Network Monitor or Wireshark.

```output
Source		Destination	Protocol	Info
192.168.100.13	192.168.100.10	TCP		49709 → 389 [SYN] Seq=0 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.10	192.168.100.13	TCP		389 → 49709 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.13	192.168.100.10	TCP		49709 → 389 [ACK] Seq=1 Ack=1 Win=65280 Len=0
192.168.100.13	192.168.100.10	LDAP		searchRequest(6) "<ROOT>" baseObject 
192.168.100.10	192.168.100.13	TCP		389 → 49709 [ACK] Seq=1 Ack=351 Win=2097664 Len=1460 [TCP PDU reassembled in 162]
192.168.100.10	192.168.100.13	LDAP		searchResEntry(6) "<ROOT>"  | searchResDone(6) success  [1 result]
192.168.100.13	192.168.100.10	TCP		49709 → 389 [ACK] Seq=351 Ack=2719 Win=65280 Len=0
192.168.100.13	192.168.100.10	LDAP		bindRequest(8) "<ROOT>" , NTLMSSP_NEGOTIATEsasl 
192.168.100.10	192.168.100.13	LDAP		bindResponse(8) saslBindInProgress , NTLMSSP_CHALLENGE
192.168.100.13	192.168.100.10	LDAP		bindRequest(9) "<ROOT>" , NTLMSSP_AUTH, User: contoso\puser2sasl 
192.168.100.10	192.168.100.13	LDAP		bindResponse(9) success 
192.168.100.13	192.168.100.10	LDAP		SASL GSS-API Privacy: payload (144 bytes)
192.168.100.10	192.168.100.13	LDAP		SASL GSS-API Privacy: payload (1254 bytes)
192.168.100.13	192.168.100.10	LDAP		SASL GSS-API Privacy: payload (93 bytes)
192.168.100.10	192.168.100.13	LDAP		SASL GSS-API Privacy: payload (155 bytes)
192.168.100.13	192.168.100.10	LDAP		SASL GSS-API Privacy: payload (171 bytes)
192.168.100.10	192.168.100.13	LDAP		SASL GSS-API Privacy: payload (140 bytes)
192.168.100.13	192.168.100.10	LDAP		SASL GSS-API Privacy: payload (11 bytes)
192.168.100.13	192.168.100.10	TCP		49709 → 389 [FIN, ACK] Seq=1456 Ack=4590 Win=65024 Len=0
192.168.100.10	192.168.100.13	TCP		389 → 49709 [RST, ACK] Seq=4590 Ack=1456 Win=0 Len=0
192.168.100.13	192.168.100.10	TCP		49712 → 389 [SYN] Seq=0 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.10	192.168.100.13	TCP		389 → 49712 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.13	192.168.100.10	TCP		49712 → 389 [ACK] Seq=1 Ack=1 Win=65280 Len=0
192.168.100.13	192.168.100.10	LDAP		bindRequest(20) "<ROOT>" , NTLMSSP_NEGOTIATEsasl 
192.168.100.10	192.168.100.13	LDAP		bindResponse(20) saslBindInProgress , NTLMSSP_CHALLENGE
192.168.100.13	192.168.100.10	LDAP		bindRequest(21) "<ROOT>" , NTLMSSP_AUTH, User: contoso\puser2sasl 
192.168.100.10	192.168.100.13	LDAP		bindResponse(21) success 
192.168.100.13	192.168.100.10	LDAP		SASL GSS-API Privacy: payload (144 bytes)
192.168.100.10	192.168.100.13	LDAP		SASL GSS-API Privacy: payload (1254 bytes)
```

### RPC

Remote Procedure Call (RPC) traffic starts from TCP 135 port. The client binds to the RPC Endpoint Mapper (EPMP) service at TCP 135 port, queries the actual port of Directory Replication Service Remote (DRSR) and the NetLogon services, and then connects those 2 services.

> [!NOTE]
> By default, the traffic of EPMAP doesn't requires authentication, but others traffics do.

#### EPMAP traffic

```output
Source		Destination	Protocol	Info
192.168.100.13	192.168.100.10	TCP		49710 → 135 [SYN] Seq=0 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.10	192.168.100.13	TCP		135 → 49710 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.13	192.168.100.10	TCP		49710 → 135 [ACK] Seq=1 Ack=1 Win=65280 Len=0
192.168.100.13	192.168.100.10	DCERPC		Bind: call_id: 2, Fragment: Single, 3 context items: EPMv4 V3.0 (32bit NDR), EPMv4 V3.0 (64bit NDR), EPMv4 V3.0 (6cb71c2c-9812-4540-0300-000000000000)
192.168.100.10	192.168.100.13	DCERPC		Bind_ack: call_id: 2, Fragment: Single, max_xmit: 5840 max_recv: 5840, 3 results: Provider rejection, Acceptance, Negotiate ACK
192.168.100.13	192.168.100.10	EPM		Map request, DRSUAPI, 32bit NDR
192.168.100.10	192.168.100.13	EPM		Map response, DRSUAPI, 32bit NDR, DRSUAPI, 32bit NDR
```

```output
Internet Protocol Version 4, Src: 192.168.100.10, Dst: 192.168.100.13
Transmission Control Protocol, Src Port: 135, Dst Port: 49710, Seq: 109, Ack: 329, Len: 268
Distributed Computing Environment / Remote Procedure Call (DCE/RPC) Response, Fragment: Single, FragLen: 268, Call: 2, Ctx: 1, [Req: #179]
DCE/RPC Endpoint Mapper, Map
    Operation: Map (3)
    [Request in frame: 179]
    Handle: 0000000000000000000000000000000000000000
    Num Towers: 2
    Tower array:
        Max Count: 4
        Offset: 0
        Actual Count: 2
        Tower pointer:
            Referent ID: 0x0000000000000003
            Length: 75
            Length: 75
            Number of floors: 5
            Floor 1 UUID: DRSUAPI
            Floor 2 UUID: 32bit NDR
            Floor 3 RPC connection-oriented protocol
            Floor 4 TCP Port:49671
            Floor 5 IP:192.168.100.10
        Tower pointer:
            Referent ID: 0x0000000000000004
            NDR-Padding: 00
            Length: 75
            Length: 75
            Number of floors: 5
            Floor 1 UUID: DRSUAPI
            Floor 2 UUID: 32bit NDR
            Floor 3 RPC connection-oriented protocol
            Floor 4 TCP Port:49664
            Floor 5 IP:192.168.100.10
    Return code: 0x00000000
```

#### DRSR traffic

```output
Source		Destination	Protocol	Info
192.168.100.13	192.168.100.10	TCP		49711 → 49671 [SYN] Seq=0 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.10	192.168.100.13	TCP		49671 → 49711 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.13	192.168.100.10	TCP		49711 → 49671 [ACK] Seq=1 Ack=1 Win=65280 Len=0
192.168.100.13	192.168.100.10	DCERPC		Bind: call_id: 2, Fragment: Single, 3 context items: DRSUAPI V4.0 (32bit NDR), DRSUAPI V4.0 (64bit NDR), DRSUAPI V4.0 (6cb71c2c-9812-4540-0300-000000000000), NTLMSSP_NEGOTIATE
192.168.100.10	192.168.100.13	DCERPC		Bind_ack: call_id: 2, Fragment: Single, max_xmit: 5840 max_recv: 5840, 3 results: Provider rejection, Acceptance, Negotiate ACK, NTLMSSP_CHALLENGE
192.168.100.13	192.168.100.10	DCERPC		AUTH3: call_id: 2, Fragment: Single, NTLMSSP_AUTH, User: contoso\puser2
192.168.100.13	192.168.100.10	DRSUAPI		DsBind request
192.168.100.10	192.168.100.13	TCP		49671 → 49711 [ACK] Seq=329 Ack=929 Win=2096896 Len=0
192.168.100.10	192.168.100.13	DRSUAPI		DsBind response
192.168.100.13	192.168.100.10	DRSUAPI		DsCrackNames request
192.168.100.10	192.168.100.13	DRSUAPI		DsCrackNames response
192.168.100.13	192.168.100.10	DRSUAPI		DsCrackNames request
192.168.100.10	192.168.100.13	DRSUAPI		DsCrackNames response
192.168.100.13	192.168.100.10	DRSUAPI		DsUnbind request
192.168.100.10	192.168.100.13	DRSUAPI		DsUnbind response
192.168.100.13	192.168.100.10	TCP		49711 → 49671 [ACK] Seq=1393 Ack=905 Win=64512 Len=0
```

#### NetLogon traffic

```output
Source		Destination	Protocol	Info
192.168.100.13	192.168.100.10	TCP		49735 → 49682 [SYN] Seq=0 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.10	192.168.100.13	TCP		49682 → 49735 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.13	192.168.100.10	TCP		49735 → 49682 [ACK] Seq=1 Ack=1 Win=65280 Len=0
192.168.100.13	192.168.100.10	DCERPC		Bind: call_id: 2, Fragment: Single, 3 context items: RPC_NETLOGON V1.0 (32bit NDR), RPC_NETLOGON V1.0 (64bit NDR), RPC_NETLOGON V1.0 (6cb71c2c-9812-4540-0300-000000000000)
192.168.100.10	192.168.100.13	DCERPC		Bind_ack: call_id: 2, Fragment: Single, max_xmit: 5840 max_recv: 5840, 3 results: Provider rejection, Acceptance, Negotiate ACK
192.168.100.13	192.168.100.10	RPC_NETLOGON	NetrServerReqChallenge request, 
192.168.100.10	192.168.100.13	RPC_NETLOGON	NetrServerReqChallenge response
192.168.100.13	192.168.100.10	RPC_NETLOGON	NetrServerAuthenticate3 request
192.168.100.10	192.168.100.13	RPC_NETLOGON	NetrServerAuthenticate3 response
192.168.100.13	192.168.100.10	DCERPC		Alter_context: call_id: 4, Fragment: Single, 1 context items: RPC_NETLOGON V1.0 (64bit NDR)
192.168.100.10	192.168.100.13	DCERPC		Alter_context_resp: call_id: 4, Fragment: Single, max_xmit: 5840 max_recv: 5840, 1 results: Acceptance
192.168.100.13	192.168.100.10	RPC_NETLOGON	NetrLogonGetCapabilities request
192.168.100.10	192.168.100.13	RPC_NETLOGON	NetrLogonGetCapabilities response
192.168.100.13	192.168.100.10	RPC_NETLOGON	NetrLogonGetCapabilities request
192.168.100.10	192.168.100.13	RPC_NETLOGON	NetrLogonGetCapabilities response
192.168.100.13	192.168.100.10	RPC_NETLOGON	NetrLogonGetDomainInfo request
192.168.100.10	192.168.100.13	TCP		49682 → 49735 [ACK] Seq=505 Ack=1993 Win=2097920 Len=1460 [TCP PDU reassembled in 562]
192.168.100.10	192.168.100.13	RPC_NETLOGON	NetrLogonGetDomainInfo response
192.168.100.13	192.168.100.10	TCP		49735 → 49682 [ACK] Seq=1993 Ack=2113 Win=65280 Len=09735, DstPort=49682, PayloadLen=0, Seq=2988619262, Ack=225725553
```

### Kerberos

Kerberos traffic is also used during domain join operation, because all the types of network traffic mentioned in the previous sections, including SMB, LDAP and RPC, require authentication.

For example, in the following network trace, the client gets a Kerberos TGT for the user account **CONTOSO\puser2** and the service ticket for the target SPN **cifs/DC2.contoso.local**. Then, the client sets up the SMB session to the DC DC2.contoso.local with that service ticket.

```output
Source		Destination	Protocol	Info
192.168.100.13	192.168.100.10	TCP		49744 → 445 [SYN] Seq=0 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.10	192.168.100.13	TCP		445 → 49744 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.13	192.168.100.10	TCP		49744 → 445 [ACK] Seq=1 Ack=1 Win=65280 Len=0
192.168.100.13	192.168.100.10	SMB		Negotiate Protocol Request
192.168.100.10	192.168.100.13	SMB2		Negotiate Protocol Response
192.168.100.13	192.168.100.10	SMB2		Negotiate Protocol Request
192.168.100.10	192.168.100.13	SMB2		Negotiate Protocol Response
192.168.100.13	192.168.100.12	KRB5		AS-REQ
192.168.100.12	192.168.100.13	KRB5		KRB Error: KRB5KDC_ERR_PREAUTH_REQUIRED
192.168.100.13	192.168.100.12	KRB5		AS-REQ
192.168.100.12	192.168.100.13	KRB5		AS-REP
192.168.100.13	192.168.100.12	KRB5		TGS-REQ
192.168.100.12	192.168.100.13	KRB5		TGS-REP
192.168.100.13	192.168.100.10	SMB2		Session Setup Request
192.168.100.10	192.168.100.13	TCP		445 → 49744 [ACK] Seq=629 Ack=2213 Win=2097920 Len=0
192.168.100.10	192.168.100.13	SMB2		Session Setup Response
192.168.100.13	192.168.100.10	SMB2		Tree Connect Request Tree: \\DC2.contoso.local\IPC$
192.168.100.10	192.168.100.13	SMB2		Tree Connect Response
```

```output
Internet Protocol Version 4, Src: 192.168.100.13, Dst: 192.168.100.10
Transmission Control Protocol, Src Port: 49744, Dst Port: 445, Seq: 378, Ack: 629, Len: 1835
NetBIOS Session Service
SMB2 (Server Message Block Protocol version 2)
    SMB2 Header
    Session Setup Request (0x01)
        [Preauth Hash: acb9fe5793b11a4fdd2a0704f000c058ded10b1ed6ec84218dae74293937653a19d9d5a52b9c033300a77a9ba75533505976ae182db8a4786354874a3ea65802]
        StructureSize: 0x0019
        Flags: 0
        Security mode: 0x02, Signing required
        Capabilities: 0x00000001, DFS
        Channel: None (0x00000000)
        Previous Session Id: 0x0000000000000000
        Blob Offset: 0x00000058
        Blob Length: 1743
        Security Blob […]: 608206cb06062b0601050502a08206bf308206bba030302e06092a864882f71201020206092a864886f712010202060a2b06010401823702021e060a2b06010401823702020aa2820685048206816082067d06092a864886f71201020201006e82066c30820668a003020105a1
            GSS-API Generic Security Service Application Program Interface
                OID: 1.3.6.1.5.5.2 (SPNEGO - Simple Protected Negotiation)
                Simple Protected Negotiation
                    negTokenInit
                        mechTypes: 4 items
                        mechToken […]: 6082067d06092a864886f71201020201006e82066c30820668a003020105a10302010ea20703050020000000a382050461820500308204fca003020105a10f1b0d434f4e544f534f2e4c4f43414ca2243022a003020102a11b30191b04636966731b114443322e636f6e746f736f2e
                        krb5_blob […]: 6082067d06092a864886f71201020201006e82066c30820668a003020105a10302010ea20703050020000000a382050461820500308204fca003020105a10f1b0d434f4e544f534f2e4c4f43414ca2243022a003020102a11b30191b04636966731b114443322e636f6e746f736f2e
                            KRB5 OID: 1.2.840.113554.1.2.2 (KRB5 - Kerberos 5)
                            krb5_tok_id: KRB5_AP_REQ (0x0001)
                            Kerberos
                                ap-req
                                    pvno: 5
                                    msg-type: krb-ap-req (14)
                                    Padding: 0
                                    ap-options: 20000000
                                    ticket
                                        tkt-vno: 5
                                        realm: CONTOSO.LOCAL
                                        sname
                                            name-type: kRB5-NT-SRV-INST (2)
                                            sname-string: 2 items
                                                SNameString: cifs
                                                SNameString: DC2.contoso.local
                                        enc-part
                                    authenticator
                                        etype: eTYPE-AES256-CTS-HMAC-SHA1-96 (18)
                                        cipher […]: 9eae7c8e2a749b3418f5687f48c40f53dfb997c22f8ae043e9895e5f3b835e52a7e843b88ab39cf0f8b1522dc6b55eeb35ce7b967518c73001c541359c390a8ccf14c41b9790127ab6a90b1edf608620b0e25d5c7f6d2d3d771cd80e466489fe183760dcfc5f74397f626efa9d7ab36d6
```

> [!NOTE]
> Depending on the format of the user credential provided for the domain join operation (for example, puser2@contoso.local or contoso\puser2 or contoso.local\puser2), you may see different Kerberos traffic.

#### About NTLM

Even if you don't see any Kerberos traffic, that doesn't necessarily mean the domain join operation must fail. This is because when Kerberos cannot work under some scenarios, NT LAN Manager (NTLM) is used as the fallback. As long as nothing is preventing NTLM from working properly such as incompatible LMCompatibilityLevel or blocked NTLM authentication in Group Policy, domain join still completes successfully with NTLM.

See the following example of successful SMB session setup using NTLM authentication.

```output
Source		Destination	Protocol	Info
192.168.100.13	192.168.100.10	TCP		49708 → 445 [SYN] Seq=0 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.10	192.168.100.13	TCP		445 → 49708 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.13	192.168.100.10	TCP		49708 → 445 [ACK] Seq=1 Ack=1 Win=65280 Len=0
192.168.100.13	192.168.100.10	SMB		Negotiate Protocol Request
192.168.100.10	192.168.100.13	SMB2		Negotiate Protocol Response
192.168.100.13	192.168.100.10	SMB2		Negotiate Protocol Request
192.168.100.10	192.168.100.13	SMB2		Negotiate Protocol Response
192.168.100.13	192.168.100.10	TCP		49708 → 445 [ACK] Seq=378 Ack=629 Win=64768 Len=0
192.168.100.13	192.168.100.10	SMB2		Session Setup Request, NTLMSSP_NEGOTIATE
192.168.100.10	192.168.100.13	SMB2		Session Setup Response, Error: STATUS_MORE_PROCESSING_REQUIRED, NTLMSSP_CHALLENGE
192.168.100.13	192.168.100.10	SMB2		Session Setup Request, NTLMSSP_AUTH, User: contoso\puser2
192.168.100.10	192.168.100.13	SMB2		Session Setup Response
192.168.100.13	192.168.100.10	SMB2		Tree Connect Request Tree: \\DC2.contoso.local\IPC$
192.168.100.10	192.168.100.13	SMB2		Tree Connect Response
```

```output
Internet Protocol Version 4, Src: 192.168.100.13, Dst: 192.168.100.10
Transmission Control Protocol, Src Port: 49708, Dst Port: 445, Seq: 544, Ack: 948, Len: 617
NetBIOS Session Service
SMB2 (Server Message Block Protocol version 2)
    SMB2 Header
    Session Setup Request (0x01)
        [Preauth Hash: b27bfb4660a46d9183e4f1676a311567aafc1702ca6b8bd2d9144c0aac5a0b9c70456a812994645dfe181151639957199c2ff250e04d71e84e17931fea69ee40]
        StructureSize: 0x0019
        Flags: 0
        Security mode: 0x02, Signing required
        Capabilities: 0x00000001, DFS
        Channel: None (0x00000000)
        Previous Session Id: 0x0000000000000000
        Blob Offset: 0x00000058
        Blob Length: 525
        Security Blob […]: a182020930820205a0030a0101a28201e8048201e44e544c4d5353500003000000180018007e0000003e013e01960000000e000e00580000000c000c00660000000c000c007200000010001000d4010000158288e20a00f4650000000f0ed0e858cf63c79a990287d4db5aeea7
            GSS-API Generic Security Service Application Program Interface
                Simple Protected Negotiation
                    negTokenTarg
                        negResult: accept-incomplete (1)
                        responseToken […]: 4e544c4d5353500003000000180018007e0000003e013e01960000000e000e00580000000c000c00660000000c000c007200000010001000d4010000158288e20a00f4650000000f0ed0e858cf63c79a990287d4db5aeea763006f006e0074006f0073006f0070007500730065
                        NTLM Secure Service Provider
                            NTLMSSP identifier: NTLMSSP
                            NTLM Message Type: NTLMSSP_AUTH (0x00000003)
                            Lan Manager Response: 000000000000000000000000000000000000000000000000
                            LMv2 Client Challenge: 0000000000000000
                            NTLM Response […]: 88cf14e2f2d8941c12f2c6d0c556acae0101000000000000f1a1d8e3478edb0125fb4dfefea846130000000002000e0043004f004e0054004f0053004f000100060044004300320004001a0063006f006e0074006f0073006f002e006c006f00630061006c0003002200440043
                            Domain name: contoso
                            User name: puser2
                            Host name: PC8
                            Session Key: 9f59e186b4db8971705236fce82fa514
                             […]Negotiate Flags: 0xe2888215, Negotiate 56, Negotiate Key Exchange, Negotiate 128, Negotiate Version, Negotiate Target Info, Negotiate Extended Session Security, Negotiate Always Sign, Negotiate NTLM key, Negotiate Sign, Request Targe
                            Version 10.0 (Build 26100); NTLM Current Revision 15
                            MIC: 0ed0e858cf63c79a990287d4db5aeea7
                        mechListMIC: 01000000f034f89d42da9b4d00000000
                        NTLMSSP Verifier
```
