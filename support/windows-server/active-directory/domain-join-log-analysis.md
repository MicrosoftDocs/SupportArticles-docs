---
title: Domain Join Log Analysis
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

This article provides a detailed guide on what occurs on a client computer when joining an Active Directory (AD) domain. The article includes a successful `Netsetup.log` sample, a breakdown of the network traffic during the AD domain join operation, and explanations of the various types of traffic involved.

To troubleshoot domain join failures, you can compare the logs of the failed and successful scenarios to identify the cause. Logs needed for troubleshooting include `Netsetup.log`, which is located in the `%windir%\debug` folder and enabled by default, and network traces collected from the client computer.

## Sample of a successful Netsetup.log file

The following sample is a typical `Netsetup.log` file covering a successful AD domain join to a domain named *contoso.local*, collected from a Windows 10 24H2 virtual machine (VM) named *PC8*.

See the lines starting with **//** for explanations.

```output
mm/dd/yyyy HH:MM:SS:DDD -----------------------------------------------------------------
mm/dd/yyyy HH:MM:SS:DDD NetpValidateName: checking to see if 'PC8' is valid as type 1 name
mm/dd/yyyy HH:MM:SS:DDD NetpCheckNetBiosNameNotInUse for 'PC8' [MACHINE] returned 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpValidateName: name 'PC8' is valid for type 1
mm/dd/yyyy HH:MM:SS:DDD -----------------------------------------------------------------
mm/dd/yyyy HH:MM:SS:DDD NetpValidateName: checking to see if 'PC8' is valid as type 5 name
mm/dd/yyyy HH:MM:SS:DDD NetpValidateName: name 'PC8' is valid for type 5

//At least one domain controller (DC) of the specified domain is located and it's qualified for AD join operation. User is prompted in GUI for a valid domain user credential.
mm/dd/yyyy HH:MM:SS:DDD -----------------------------------------------------------------
mm/dd/yyyy HH:MM:SS:DDD NetpValidateName: checking to see if 'contoso.local' is valid as type 3 name
mm/dd/yyyy HH:MM:SS:DDD NetpCheckDomainNameIsValid [ Exists ] for 'contoso.local' returned 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpValidateName: name 'contoso.local' is valid for type 3

//Activity begins after a valid domain user credential is provided in GUI.
mm/dd/yyyy HH:MM:SS:DDD -----------------------------------------------------------------
mm/dd/yyyy HH:MM:SS:DDD NetpDoDomainJoin
mm/dd/yyyy HH:MM:SS:DDD NetpDoDomainJoin: using current computer names
mm/dd/yyyy HH:MM:SS:DDD NetpDoDomainJoin: NetpGetComputerNameEx(NetBios) returned 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpDoDomainJoin: NetpGetComputerNameEx(DnsHostName) returned 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpMachineValidToJoin: 'PC8'
mm/dd/yyyy HH:MM:SS:DDD   OS Version: 10.0
mm/dd/yyyy HH:MM:SS:DDD   Build number: 26100 (26100.ge_release.240331-1435)
mm/dd/yyyy HH:MM:SS:DDD   SKU: Windows 11 Enterprise
mm/dd/yyyy HH:MM:SS:DDD   Architecture: 64-bit (AMD64)
mm/dd/yyyy HH:MM:SS:DDD NetpMachineValidToJoin: status: 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomain
mm/dd/yyyy HH:MM:SS:DDD   HostName: PC8
mm/dd/yyyy HH:MM:SS:DDD   NetbiosName: PC8
mm/dd/yyyy HH:MM:SS:DDD   Domain: contoso.local
mm/dd/yyyy HH:MM:SS:DDD   MachineAccountOU: (NULL)
mm/dd/yyyy HH:MM:SS:DDD   Account: contoso\puser2
mm/dd/yyyy HH:MM:SS:DDD   Options: 0x25
mm/dd/yyyy HH:MM:SS:DDD NetpValidateName: checking to see if 'contoso.local' is valid as type 3 name
mm/dd/yyyy HH:MM:SS:DDD NetpCheckDomainNameIsValid [ Exists ] for 'contoso.local' returned 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpValidateName: name 'contoso.local' is valid for type 3
mm/dd/yyyy HH:MM:SS:DDD NetpDsGetDcName: trying to find DC in domain 'contoso.local', flags: 0x40001010
mm/dd/yyyy HH:MM:SS:DDD NetpDsGetDcName: failed to find a DC having account 'PC8$': 0x525, last error is 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpDsGetDcName: status of verifying DNS A record name resolution for 'DC2.contoso.local': 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpDsGetDcName: found DC '\\DC2.contoso.local' in the specified domain
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomainOnDs: NetpDsGetDcName returned: 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpDisableIDNEncoding: using FQDN contoso.local from dcinfo
mm/dd/yyyy HH:MM:SS:DDD NetpDisableIDNEncoding: DnsDisableIdnEncoding(UNTILREBOOT) on 'contoso.local' succeeded
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomainOnDs: NetpDisableIDNEncoding returned: 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomainOnDs: status of connecting to dc '\\DC2.contoso.local': 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpGetDnsHostName: PrimaryDnsSuffix defaulted to DNS domain name: contoso.local
mm/dd/yyyy HH:MM:SS:DDD NetpProvisionComputerAccount:
mm/dd/yyyy HH:MM:SS:DDD   lpDomain: contoso.local
mm/dd/yyyy HH:MM:SS:DDD   lpHostName: PC8
mm/dd/yyyy HH:MM:SS:DDD   lpMachineAccountOU: (NULL)
mm/dd/yyyy HH:MM:SS:DDD   lpDcName: DC2.contoso.local
mm/dd/yyyy HH:MM:SS:DDD   lpMachinePassword: (null)
mm/dd/yyyy HH:MM:SS:DDD   lpAccount: contoso\puser2
mm/dd/yyyy HH:MM:SS:DDD   lpPassword: (non-null)
mm/dd/yyyy HH:MM:SS:DDD   dwJoinOptions: 0x25
mm/dd/yyyy HH:MM:SS:DDD   dwOptions: 0x40000003
mm/dd/yyyy HH:MM:SS:DDD NetpLdapBind: Verified minimum encryption strength on DC2.contoso.local: 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpLdapGetLsaPrimaryDomain: reading domain data
mm/dd/yyyy HH:MM:SS:DDD NetpGetNCData: Reading NC data
mm/dd/yyyy HH:MM:SS:DDD NetpGetDomainData: Lookup domain data for: DC=contoso,DC=local
mm/dd/yyyy HH:MM:SS:DDD NetpGetDomainData: Lookup crossref data for: CN=Partitions,CN=Configuration,DC=contoso,DC=local
mm/dd/yyyy HH:MM:SS:DDD NetpLdapGetLsaPrimaryDomain: result of retrieving domain data: 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpCheckForDomainSIDCollision: returning 0x0(0).
mm/dd/yyyy HH:MM:SS:DDD NetpGetComputerObjectDn: Cracking DNS domain name contoso.local/ into Netbios on \\DC2.contoso.local
mm/dd/yyyy HH:MM:SS:DDD NetpGetComputerObjectDn: Crack results:   name = CONTOSO\

//Check if a computer object with the same name already exists or not. If yes, it's the account reuse scenario.
mm/dd/yyyy HH:MM:SS:DDD NetpGetComputerObjectDn: Cracking account name CONTOSO\PC8$ on \\DC2.contoso.local
mm/dd/yyyy HH:MM:SS:DDD NetpGetComputerObjectDn: Crack results:   Account does not exist
mm/dd/yyyy HH:MM:SS:DDD NetpCreateComputerObjectInDs: NetpGetComputerObjectDn failed: 0x534
mm/dd/yyyy HH:MM:SS:DDD NetpProvisionComputerAccount: LDAP creation failed: 0x534
mm/dd/yyyy HH:MM:SS:DDD ldap_unbind status: 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpJoinCreatePackagePart: status:0x534.
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomainOnDs: Function exits with status of: 0x534
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomainOnDs: status of disconnecting from '\\DC2.contoso.local': 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpResetIDNEncoding: DnsDisableIdnEncoding(RESETALL) on 'contoso.local' returned 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomainOnDs: NetpResetIDNEncoding on 'contoso.local': 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpDoDomainJoin: status: 0x534
mm/dd/yyyy HH:MM:SS:DDD -----------------------------------------------------------------
mm/dd/yyyy HH:MM:SS:DDD NetpDoDomainJoin
mm/dd/yyyy HH:MM:SS:DDD NetpDoDomainJoin: using current computer names
mm/dd/yyyy HH:MM:SS:DDD NetpDoDomainJoin: NetpGetComputerNameEx(NetBios) returned 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpDoDomainJoin: NetpGetComputerNameEx(DnsHostName) returned 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpMachineValidToJoin: 'PC8'
mm/dd/yyyy HH:MM:SS:DDD   OS Version: 10.0
mm/dd/yyyy HH:MM:SS:DDD   Build number: 26100 (26100.ge_release.240331-1435)
mm/dd/yyyy HH:MM:SS:DDD   SKU: Windows 11 Enterprise
mm/dd/yyyy HH:MM:SS:DDD   Architecture: 64-bit (AMD64)
mm/dd/yyyy HH:MM:SS:DDD NetpMachineValidToJoin: status: 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomain
mm/dd/yyyy HH:MM:SS:DDD   HostName: PC8
mm/dd/yyyy HH:MM:SS:DDD   NetbiosName: PC8
mm/dd/yyyy HH:MM:SS:DDD   Domain: contoso.local
mm/dd/yyyy HH:MM:SS:DDD   MachineAccountOU: (NULL)
mm/dd/yyyy HH:MM:SS:DDD   Account: contoso\puser2
mm/dd/yyyy HH:MM:SS:DDD   Options: 0x27
mm/dd/yyyy HH:MM:SS:DDD NetpValidateName: checking to see if 'contoso.local' is valid as type 3 name
mm/dd/yyyy HH:MM:SS:DDD NetpCheckDomainNameIsValid [ Exists ] for 'contoso.local' returned 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpValidateName: name 'contoso.local' is valid for type 3
mm/dd/yyyy HH:MM:SS:DDD NetpDsGetDcName: trying to find DC in domain 'contoso.local', flags: 0x40001010
mm/dd/yyyy HH:MM:SS:DDD NetpDsGetDcName: failed to find a DC having account 'PC8$': 0x525, last error is 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpDsGetDcName: status of verifying DNS A record name resolution for 'DC2.contoso.local': 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpDsGetDcName: found DC '\\DC2.contoso.local' in the specified domain
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomainOnDs: NetpDsGetDcName returned: 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpDisableIDNEncoding: using FQDN contoso.local from dcinfo
mm/dd/yyyy HH:MM:SS:DDD NetpDisableIDNEncoding: DnsDisableIdnEncoding(UNTILREBOOT) on 'contoso.local' succeeded
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomainOnDs: NetpDisableIDNEncoding returned: 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomainOnDs: status of connecting to dc '\\DC2.contoso.local': 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpGetDnsHostName: PrimaryDnsSuffix defaulted to DNS domain name: contoso.local
mm/dd/yyyy HH:MM:SS:DDD NetpProvisionComputerAccount:
mm/dd/yyyy HH:MM:SS:DDD   lpDomain: contoso.local
mm/dd/yyyy HH:MM:SS:DDD   lpHostName: PC8
mm/dd/yyyy HH:MM:SS:DDD   lpMachineAccountOU: (NULL)
mm/dd/yyyy HH:MM:SS:DDD   lpDcName: DC2.contoso.local
mm/dd/yyyy HH:MM:SS:DDD   lpMachinePassword: (null)
mm/dd/yyyy HH:MM:SS:DDD   lpAccount: contoso\puser2
mm/dd/yyyy HH:MM:SS:DDD   lpPassword: (non-null)
mm/dd/yyyy HH:MM:SS:DDD   dwJoinOptions: 0x27
mm/dd/yyyy HH:MM:SS:DDD   dwOptions: 0x40000003
mm/dd/yyyy HH:MM:SS:DDD NetpLdapBind: Verified minimum encryption strength on DC2.contoso.local: 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpLdapGetLsaPrimaryDomain: reading domain data
mm/dd/yyyy HH:MM:SS:DDD NetpGetNCData: Reading NC data
mm/dd/yyyy HH:MM:SS:DDD NetpGetDomainData: Lookup domain data for: DC=contoso,DC=local
mm/dd/yyyy HH:MM:SS:DDD NetpGetDomainData: Lookup crossref data for: CN=Partitions,CN=Configuration,DC=contoso,DC=local
mm/dd/yyyy HH:MM:SS:DDD NetpLdapGetLsaPrimaryDomain: result of retrieving domain data: 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpCheckForDomainSIDCollision: returning 0x0(0).
mm/dd/yyyy HH:MM:SS:DDD NetpGetComputerObjectDn: Cracking DNS domain name contoso.local/ into Netbios on \\DC2.contoso.local
mm/dd/yyyy HH:MM:SS:DDD NetpGetComputerObjectDn: Crack results:   name = CONTOSO\
mm/dd/yyyy HH:MM:SS:DDD NetpGetComputerObjectDn: Cracking account name CONTOSO\PC8$ on \\DC2.contoso.local
mm/dd/yyyy HH:MM:SS:DDD NetpGetComputerObjectDn: Crack results:   Account does not exist
mm/dd/yyyy HH:MM:SS:DDD NetpGetComputerObjectDn: Cracking Netbios domain name CONTOSO\ into root DN on \\DC2.contoso.local
mm/dd/yyyy HH:MM:SS:DDD NetpGetComputerObjectDn: Crack results:   name = DC=contoso,DC=local
mm/dd/yyyy HH:MM:SS:DDD NetpGetComputerObjectDn: Got DN CN=PC8,CN=Computers,DC=contoso,DC=local from the default computer container
mm/dd/yyyy HH:MM:SS:DDD NetpGetADObjectOwnerAttributes: Looking up attributes for machine account: CN=PC8,CN=Computers,DC=contoso,DC=local
mm/dd/yyyy HH:MM:SS:DDD NetpGetADObjectOwnerAttributes: Ldap Search failed: 8240
mm/dd/yyyy HH:MM:SS:DDD NetpCheckIfAccountShouldBeReused: Computer Object does not exist in OU.
mm/dd/yyyy HH:MM:SS:DDD NetpCheckIfAccountShouldBeReused:fReuseAllowed: TRUE, NetStatus:0x2030

//Computer object is created.
mm/dd/yyyy HH:MM:SS:DDD NetpModifyComputerObjectInDs: Initial attribute values:
mm/dd/yyyy HH:MM:SS:DDD     objectClass  =  Computer
mm/dd/yyyy HH:MM:SS:DDD     SamAccountName  =  PC8$
mm/dd/yyyy HH:MM:SS:DDD     userAccountControl  =  0x1000
mm/dd/yyyy HH:MM:SS:DDD     DnsHostName  =  PC8.contoso.local
mm/dd/yyyy HH:MM:SS:DDD     ServicePrincipalName  =  HOST/PC8.contoso.local  RestrictedKrbHost/PC8.contoso.local  HOST/PC8  RestrictedKrbHost/PC8
mm/dd/yyyy HH:MM:SS:DDD     unicodePwd  =  <SomePassword>
mm/dd/yyyy HH:MM:SS:DDD NetpModifyComputerObjectInDs: Computer Object does not exist in OU
mm/dd/yyyy HH:MM:SS:DDD NetpModifyComputerObjectInDs: Attribute values to set:
mm/dd/yyyy HH:MM:SS:DDD     objectClass  =  Computer
mm/dd/yyyy HH:MM:SS:DDD     SamAccountName  =  PC8$
mm/dd/yyyy HH:MM:SS:DDD     userAccountControl  =  0x1000
mm/dd/yyyy HH:MM:SS:DDD     DnsHostName  =  PC8.contoso.local
mm/dd/yyyy HH:MM:SS:DDD     ServicePrincipalName  =  HOST/PC8.contoso.local  RestrictedKrbHost/PC8.contoso.local  HOST/PC8  RestrictedKrbHost/PC8
mm/dd/yyyy HH:MM:SS:DDD     unicodePwd  =  <SomePassword>
mm/dd/yyyy HH:MM:SS:DDD Querying "CN=PC8,CN=Computers,DC=contoso,DC=local" for objectSid\objectGuid attributes

//SID of the new computer account.
mm/dd/yyyy HH:MM:SS:DDD NetpQueryAccountAttributes succeeded: got RID=0x643 objectSid=S-1-5-21-3127289744-4148518019-814850311-1603
mm/dd/yyyy HH:MM:SS:DDD NetpDeleteMachineAccountKey: called for computer 'PC8'
mm/dd/yyyy HH:MM:SS:DDD NetpGetComputerObjectDn: Cracking DNS domain name contoso.local/ into Netbios on \\DC2.contoso.local
mm/dd/yyyy HH:MM:SS:DDD NetpGetComputerObjectDn: Crack results:   name = CONTOSO\
mm/dd/yyyy HH:MM:SS:DDD NetpGetComputerObjectDn: Cracking account name CONTOSO\PC8$ on \\DC2.contoso.local
mm/dd/yyyy HH:MM:SS:DDD NetpGetComputerObjectDn: Crack results:   (Account already exists) DN = CN=PC8,CN=Computers,DC=contoso,DC=local
mm/dd/yyyy HH:MM:SS:DDD NetpDeleteMachineAccountKey: msDS-KeyCredentialLink attr was not found on computer 'PC8' - no action required.
mm/dd/yyyy HH:MM:SS:DDD NetpDeleteMachineAccountKey: returning Status: 0 
mm/dd/yyyy HH:MM:SS:DDD ldap_unbind status: 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpJoinCreatePackagePart: status:0x0.
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomainOnDs: Setting netlogon cache.
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomainOnDs: status of setting netlogon cache: 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomainOnDs: Function exits with status of: 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomainOnDs: status of disconnecting from '\\DC2.contoso.local': 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomain: DsrIsDeviceJoined returned false
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomain: NetpCompleteOfflineDomainJoin SUCCESS: Requested a reboot :0x0
mm/dd/yyyy HH:MM:SS:DDD NetpDoDomainJoin: status: 0x0
Privileges: Setting backup/restore privileges.
mm/dd/yyyy HH:MM:SS:DDD NetpProvGetWindowsImageState: IMAGE_STATE_COMPLETE.
mm/dd/yyyy HH:MM:SS:DDD NetpAddPartCollectionToRegistry.
mm/dd/yyyy HH:MM:SS:DDD NetpProvGetTargetProductVersion: Target product version: 10.0.26100.3037
mm/dd/yyyy HH:MM:SS:DDD NetpAddPartCollectionToRegistry: delete OP state key status: 0x2.
mm/dd/yyyy HH:MM:SS:DDD NetpConvertBlobToJoinState: Translating provisioning data to internal format
mm/dd/yyyy HH:MM:SS:DDD NetpConvertBlobToJoinState: Selecting version 1
mm/dd/yyyy HH:MM:SS:DDD NetpConvertBlobToJoinState: exiting: 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpJoin2RequestPackagePartInstall: Successfully persisted all fields
mm/dd/yyyy HH:MM:SS:DDD NetpJoin3RequestPackagePartInstall: Successfully persisted all fields
mm/dd/yyyy HH:MM:SS:DDD NetpJoin4RequestPackagePartInstall: Successfully persisted all fields
mm/dd/yyyy HH:MM:SS:DDD NetpAddPartCollectionToRegistry: Successfully initiated provisioning package installation: 4/4 part(s) installed.
mm/dd/yyyy HH:MM:SS:DDD NetpAddPartCollectionToRegistry: status: 0x0.
mm/dd/yyyy HH:MM:SS:DDD NetpOpenRegistry: status: 0x0.
mm/dd/yyyy HH:MM:SS:DDD NetpSetPrivileges: status: 0x0.
mm/dd/yyyy HH:MM:SS:DDD NetpRequestProvisioningPackageInstall: status: 0x0.
mm/dd/yyyy HH:MM:SS:DDD -----------------------------------------------------------------
mm/dd/yyyy HH:MM:SS:DDD NetpProvContinueProvisioningPackageInstall:
mm/dd/yyyy HH:MM:SS:DDD   Context: 0
mm/dd/yyyy HH:MM:SS:DDD NetpProvGetWindowsImageState: IMAGE_STATE_COMPLETE.
mm/dd/yyyy HH:MM:SS:DDD NetpCreatePartListFromRegistry: status: 0x0.
mm/dd/yyyy HH:MM:SS:DDD NetpCompleteOfflineDomainJoin
mm/dd/yyyy HH:MM:SS:DDD   fBootTimeCaller: FALSE
mm/dd/yyyy HH:MM:SS:DDD   fSetLocalGroups: TRUE
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomainLocal: NetpHandleJoinedStateInfo returned: 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomainLocal: NetpManageMachineSecret returned: 0x0.
mm/dd/yyyy HH:MM:SS:DDD Calling NetpQueryService to get Netlogon service state.
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomainLocal: NetpQueryService returned: 0x0.
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomainLocal: status of setting LSA pri. domain: 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpManageLocalGroupsForJoin: Adding groups for new domain, removing groups from old domain, if any.
mm/dd/yyyy HH:MM:SS:DDD NetpManageLocalGroupsForJoin: status of modifying groups related to domain 'CONTOSO' to local groups: 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpManageLocalGroupsForJoin: INFO: No old domain groups to process.
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomainLocal: Status of managing local groups: 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomainLocal: status of setting ComputerNamePhysicalDnsDomain to 'contoso.local': 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomainLocal: Controlling services and setting service start type.
mm/dd/yyyy HH:MM:SS:DDD NetpJoinDomainLocal: Updating W32TimeConfighttps://supportability.visualstudio.com/
mm/dd/yyyy HH:MM:SS:DDD NetpCompleteOfflineDomainJoin: status: 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpJoinProvider2OLContinuePackagePartInstall: ignoring Context=0 (work finished already).
mm/dd/yyyy HH:MM:SS:DDD NetpJoinProvider3OLContinuePackagePartInstall: ignoring Context=0 (work finished already).
mm/dd/yyyy HH:MM:SS:DDD NetpJoinProvider4OLContinuePackagePartInstall: ignoring Context=0 (work finished already).
mm/dd/yyyy HH:MM:SS:DDD NetpProvContinueProvisioningPackageInstall: Provisioning package installation completed successfully.
mm/dd/yyyy HH:MM:SS:DDD NetpProvContinueProvisioningPackageInstall: delete OP state key status: 0x0.

//0xa99 stands for "a restart is needed".
mm/dd/yyyy HH:MM:SS:DDD NetpProvContinueProvisioningPackageInstall: status: 0xa99.
mm/dd/yyyy HH:MM:SS:DDD -----------------------------------------------------------------
mm/dd/yyyy HH:MM:SS:DDD NetpChangeMachineName: from 'PC8' to 'PC8' using 'contoso\puser2' [0x1000]
mm/dd/yyyy HH:MM:SS:DDD NetpChangeMachineName: using DnsHostnameToComputerNameEx
mm/dd/yyyy HH:MM:SS:DDD NetpChangeMachineName: generated netbios name: 'PC8'
mm/dd/yyyy HH:MM:SS:DDD NetpDsGetDcName: trying to find DC in domain 'contoso.local', flags: 0x1010
mm/dd/yyyy HH:MM:SS:DDD NetpDsGetDcName: found DC '\\DC2.contoso.local' in the specified domain
mm/dd/yyyy HH:MM:SS:DDD NetpGetDnsHostName: Read NV Domain: contoso.local
mm/dd/yyyy HH:MM:SS:DDD NetpGetComputerObjectDn: Cracking DNS domain name contoso.local/ into Netbios on \\DC2.contoso.local
mm/dd/yyyy HH:MM:SS:DDD NetpGetComputerObjectDn: Crack results:   name = CONTOSO\
mm/dd/yyyy HH:MM:SS:DDD NetpGetComputerObjectDn: Cracking account name CONTOSO\PC8$ on \\DC2.contoso.local
mm/dd/yyyy HH:MM:SS:DDD NetpGetComputerObjectDn: Crack results:   (Account already exists) DN = CN=PC8,CN=Computers,DC=contoso,DC=local
mm/dd/yyyy HH:MM:SS:DDD NetpModifyComputerObjectInDs: Initial attribute values:
mm/dd/yyyy HH:MM:SS:DDD     DnsHostName  =  PC8.contoso.local
mm/dd/yyyy HH:MM:SS:DDD     ServicePrincipalName  =  HOST/PC8.contoso.local  RestrictedKrbHost/PC8.contoso.local  HOST/PC8  RestrictedKrbHost/PC8
mm/dd/yyyy HH:MM:SS:DDD NetpModifyComputerObjectInDs: Computer Object already exists in OU:
mm/dd/yyyy HH:MM:SS:DDD     DnsHostName  =  PC8.contoso.local
mm/dd/yyyy HH:MM:SS:DDD     ServicePrincipalName  =  RestrictedKrbHost/PC8  HOST/PC8  RestrictedKrbHost/PC8.contoso.local  HOST/PC8.contoso.local
mm/dd/yyyy HH:MM:SS:DDD NetpModifyComputerObjectInDs: There are _NO_ modifications to do
mm/dd/yyyy HH:MM:SS:DDD ldap_unbind status: 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpChangeMachineName: status of setting DnsHostName and SPN: 0x0
mm/dd/yyyy HH:MM:SS:DDD NetpChangeMachineName: DsrIsDeviceJoinedEx returned false. dsrInstance = 0
mm/dd/yyyy HH:MM:SS:DDD NetpChangeMachineName: SetComputerNameEx() returned 0x1
```

## Network traces

Network traces are helpful in pinpointing AD domain join issues. During an AD domain join operation, multiple types of traffic occur between the client and some Domain Name System (DNS) servers, and then between the client and some domain controllers (DCs). The following sections discuss each type of traffic.

> [!NOTE]
>
> The snippets are taken from Wireshark. Other network trace analysis tools might show the frame summaries and details differently.

In these network traces, the IP addresses represent the following roles:

- 192.168.100.13 - Client
- 192.168.100.12 - DNS server and DC
- 192.168.100.10 - DC

### DNS

The client queries the DNS SRV record to locate the domain's DCs to join. In the following example, the client successfully locates two DCs.

```output
Source          Destination     Protocol  Info
192.168.100.13  192.168.100.12  DNS       Standard query 0xa793 SRV _ldap._tcp.dc._msdcs.contoso.local
192.168.100.12  192.168.100.13  DNS       Standard query response 0xa793 SRV _ldap._tcp.dc._msdcs.contoso.local SRV 0 100 389 dc2.contoso.local SRV 0 100 389 dc1.contoso.local A 192.168.100.10 A 192.168.100.12
192.168.100.13  192.168.100.12  DNS       Standard query 0x623b A dc2.contoso.local
192.168.100.12  192.168.100.13  DNS       Standard query response 0x623b A dc2.contoso.local A 192.168.100.10
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

Then, the client picks up one of the DCs and uses Lightweight Directory Access Protocol (LDAP) ping over UDP port 389 to detect the functionalities of that DC.

```output
Source          Destination     Protocol  Info
192.168.100.13  192.168.100.10  CLDAP     searchRequest(1) "<ROOT>" baseObject 
192.168.100.10  192.168.100.13  CLDAP     searchResEntry(1) "<ROOT>" searchResDone(1) success  [1 result]
```

In response, the DC provides general information on the domain and that DC's current capabilities.

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

During AD domain join, Server Message Block (SMB) traffic is employed for Microsoft Remote Procedure Call (MSRPC)-based communication.

```output
Source          Destination     Protocol      Info
192.168.100.13  192.168.100.10  TCP           49708 → 445 [SYN] Seq=0 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.10  192.168.100.13  TCP           445 → 49708 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.13  192.168.100.10  TCP           49708 → 445 [ACK] Seq=1 Ack=1 Win=65280 Len=0
192.168.100.13  192.168.100.10  SMB           Negotiate Protocol Request
192.168.100.10  192.168.100.13  SMB2          Negotiate Protocol Response
192.168.100.13  192.168.100.10  SMB2          Negotiate Protocol Request
192.168.100.10  192.168.100.13  SMB2          Negotiate Protocol Response
192.168.100.13  192.168.100.10  TCP           49708 → 445 [ACK] Seq=378 Ack=629 Win=64768 Len=0
192.168.100.13  192.168.100.10  SMB2          Session Setup Request, NTLMSSP_NEGOTIATE
192.168.100.10  192.168.100.13  SMB2          Session Setup Response, Error: STATUS_MORE_PROCESSING_REQUIRED, NTLMSSP_CHALLENGE
192.168.100.13  192.168.100.10  SMB2          Session Setup Request, NTLMSSP_AUTH, User: contoso\puser2
192.168.100.10  192.168.100.13  SMB2          Session Setup Response
192.168.100.13  192.168.100.10  SMB2          Tree Connect Request Tree: \\DC2.contoso.local\IPC$
192.168.100.10  192.168.100.13  SMB2          Tree Connect Response
192.168.100.13  192.168.100.10  SMB2          Ioctl Request FSCTL_QUERY_NETWORK_INTERFACE_INFO
192.168.100.10  192.168.100.13  SMB2          Ioctl Response FSCTL_QUERY_NETWORK_INTERFACE_INFO
192.168.100.13  192.168.100.10  TCP           49708 → 445 [ACK] Seq=1409 Ack=1557 Win=65280 Len=0
192.168.100.13  192.168.100.10  SMB2          Create Request File: NETLOGON
192.168.100.10  192.168.100.13  SMB2          Create Response File: NETLOGON
192.168.100.13  192.168.100.10  SMB2          GetInfo Request FILE_INFO/SMB2_FILE_STANDARD_INFO File: NETLOGON
192.168.100.10  192.168.100.13  SMB2          GetInfo Response
192.168.100.13  192.168.100.10  DCERPC        Bind: call_id: 2, Fragment: Single, 3 context items: RPC_NETLOGON V1.0 (32bit NDR), RPC_NETLOGON V1.0 (64bit NDR), RPC_NETLOGON V1.0 (6cb71c2c-9812-4540-0300-000000000000)
192.168.100.10  192.168.100.13  SMB2          Write Response
192.168.100.13  192.168.100.10  SMB2          Read Request Len:1024 Off:0 File: NETLOGON
192.168.100.10  192.168.100.13  DCERPC        Bind_ack: call_id: 2, Fragment: Single, max_xmit: 4280 max_recv: 4280, 3 results: Provider rejection, Acceptance, Negotiate ACK
192.168.100.13  192.168.100.10  RPC_NETLOGON  DsrEnumerateDomainTrusts request
192.168.100.10  192.168.100.13  RPC_NETLOGON  DsrEnumerateDomainTrusts response
192.168.100.13  192.168.100.10  SMB2          Close Request File: NETLOGON
192.168.100.10  192.168.100.13  SMB2          Close Response
192.168.100.13  192.168.100.10  TCP           49708 → 445 [ACK] Seq=2366 Ack=2953 Win=64000 Len=0
```

### LDAP

LDAP traffic is also used during the domain join activity. Except for the leading LDAP search for RootDSE and then the binding (authentication), the remaining LDAP traffic is encrypted. Therefore, you can't read the content in the network trace.

> [!NOTE]
> Since Windows Server 2003, NTLM payloads have been encrypted by default. For Kerberos authenticated sessions, the caller can decide whether to request encryption. Other factors, such as the OS version and security policy configuration on both sides, also matter.

```output
Source          Destination     Protocol  Info
192.168.100.13  192.168.100.10  TCP       49709 → 389 [SYN] Seq=0 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.10  192.168.100.13  TCP       389 → 49709 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.13  192.168.100.10  TCP       49709 → 389 [ACK] Seq=1 Ack=1 Win=65280 Len=0
192.168.100.13  192.168.100.10  LDAP      searchRequest(6) "<ROOT>" baseObject 
192.168.100.10  192.168.100.13  TCP       389 → 49709 [ACK] Seq=1 Ack=351 Win=2097664 Len=1460 [TCP PDU reassembled in 162]
192.168.100.10  192.168.100.13  LDAP      searchResEntry(6) "<ROOT>"  | searchResDone(6) success  [1 result]
192.168.100.13  192.168.100.10  TCP       49709 → 389 [ACK] Seq=351 Ack=2719 Win=65280 Len=0
192.168.100.13  192.168.100.10  LDAP      bindRequest(8) "<ROOT>" , NTLMSSP_NEGOTIATEsasl 
192.168.100.10  192.168.100.13  LDAP      bindResponse(8) saslBindInProgress , NTLMSSP_CHALLENGE
192.168.100.13  192.168.100.10  LDAP      bindRequest(9) "<ROOT>" , NTLMSSP_AUTH, User: contoso\puser2sasl 
192.168.100.10  192.168.100.13  LDAP      bindResponse(9) success 
192.168.100.13  192.168.100.10  LDAP      SASL GSS-API Privacy: payload (144 bytes)
192.168.100.10  192.168.100.13  LDAP      SASL GSS-API Privacy: payload (1254 bytes)
192.168.100.13  192.168.100.10  LDAP      SASL GSS-API Privacy: payload (93 bytes)
192.168.100.10  192.168.100.13  LDAP      SASL GSS-API Privacy: payload (155 bytes)
192.168.100.13  192.168.100.10  LDAP      SASL GSS-API Privacy: payload (171 bytes)
192.168.100.10  192.168.100.13  LDAP      SASL GSS-API Privacy: payload (140 bytes)
192.168.100.13  192.168.100.10  LDAP      SASL GSS-API Privacy: payload (11 bytes)
192.168.100.13  192.168.100.10  TCP       49709 → 389 [FIN, ACK] Seq=1456 Ack=4590 Win=65024 Len=0
192.168.100.10  192.168.100.13  TCP       389 → 49709 [RST, ACK] Seq=4590 Ack=1456 Win=0 Len=0
192.168.100.13  192.168.100.10  TCP       49712 → 389 [SYN] Seq=0 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.10  192.168.100.13  TCP       389 → 49712 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.13  192.168.100.10  TCP       49712 → 389 [ACK] Seq=1 Ack=1 Win=65280 Len=0
192.168.100.13  192.168.100.10  LDAP      bindRequest(20) "<ROOT>" , NTLMSSP_NEGOTIATEsasl 
192.168.100.10  192.168.100.13  LDAP      bindResponse(20) saslBindInProgress , NTLMSSP_CHALLENGE
192.168.100.13  192.168.100.10  LDAP      bindRequest(21) "<ROOT>" , NTLMSSP_AUTH, User: contoso\puser2sasl 
192.168.100.10  192.168.100.13  LDAP      bindResponse(21) success 
192.168.100.13  192.168.100.10  LDAP      SASL GSS-API Privacy: payload (144 bytes)
192.168.100.10  192.168.100.13  LDAP      SASL GSS-API Privacy: payload (1254 bytes)
```

### RPC

Remote Procedure Call (RPC) traffic starts from TCP port 135. The client binds to the RPC Endpoint Mapper (EPMAP) service on TCP port 135, queries the actual ports of the Directory Replication Service Remote (DRSR) and NetLogon services, and then connects those two services.

> [!NOTE]
> By default, EPMAP traffic doesn't require authentication. Therefore, we don't recommend enabling EPMAP traffic. However, traffic of the DRSR and NETLOGON services requires authentication.

#### EPMAP traffic

```output
Source          Destination     Protocol  Info
192.168.100.13  192.168.100.10  TCP       49710 → 135 [SYN] Seq=0 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.10  192.168.100.13  TCP       135 → 49710 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.13  192.168.100.10  TCP       49710 → 135 [ACK] Seq=1 Ack=1 Win=65280 Len=0
192.168.100.13  192.168.100.10  DCERPC    Bind: call_id: 2, Fragment: Single, 3 context items: EPMv4 V3.0 (32bit NDR), EPMv4 V3.0 (64bit NDR), EPMv4 V3.0 (6cb71c2c-9812-4540-0300-000000000000)
192.168.100.10  192.168.100.13  DCERPC    Bind_ack: call_id: 2, Fragment: Single, max_xmit: 5840 max_recv: 5840, 3 results: Provider rejection, Acceptance, Negotiate ACK
192.168.100.13  192.168.100.10  EPM       Map request, DRSUAPI, 32bit NDR
192.168.100.10  192.168.100.13  EPM       Map response, DRSUAPI, 32bit NDR, DRSUAPI, 32bit NDR
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
Source          Destination     Protocol  Info
192.168.100.13  192.168.100.10  TCP       49711 → 49671 [SYN] Seq=0 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.10  192.168.100.13  TCP       49671 → 49711 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.13  192.168.100.10  TCP       49711 → 49671 [ACK] Seq=1 Ack=1 Win=65280 Len=0
192.168.100.13  192.168.100.10  DCERPC    Bind: call_id: 2, Fragment: Single, 3 context items: DRSUAPI V4.0 (32bit NDR), DRSUAPI V4.0 (64bit NDR), DRSUAPI V4.0 (6cb71c2c-9812-4540-0300-000000000000), NTLMSSP_NEGOTIATE
192.168.100.10  192.168.100.13  DCERPC    Bind_ack: call_id: 2, Fragment: Single, max_xmit: 5840 max_recv: 5840, 3 results: Provider rejection, Acceptance, Negotiate ACK, NTLMSSP_CHALLENGE
192.168.100.13  192.168.100.10  DCERPC    AUTH3: call_id: 2, Fragment: Single, NTLMSSP_AUTH, User: contoso\puser2
192.168.100.13  192.168.100.10  DRSUAPI   DsBind request
192.168.100.10  192.168.100.13  TCP       49671 → 49711 [ACK] Seq=329 Ack=929 Win=2096896 Len=0
192.168.100.10  192.168.100.13  DRSUAPI   DsBind response
192.168.100.13  192.168.100.10  DRSUAPI   DsCrackNames request
192.168.100.10  192.168.100.13  DRSUAPI   DsCrackNames response
192.168.100.13  192.168.100.10  DRSUAPI   DsCrackNames request
192.168.100.10  192.168.100.13  DRSUAPI   DsCrackNames response
192.168.100.13  192.168.100.10  DRSUAPI   DsUnbind request
192.168.100.10  192.168.100.13  DRSUAPI   DsUnbind response
192.168.100.13  192.168.100.10  TCP       49711 → 49671 [ACK] Seq=1393 Ack=905 Win=64512 Len=0
```

#### NetLogon traffic

```output
Source          Destination     Protocol      Info
192.168.100.13  192.168.100.10  TCP           49735 → 49682 [SYN] Seq=0 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.10  192.168.100.13  TCP           49682 → 49735 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.13  192.168.100.10  TCP           49735 → 49682 [ACK] Seq=1 Ack=1 Win=65280 Len=0
192.168.100.13  192.168.100.10  DCERPC        Bind: call_id: 2, Fragment: Single, 3 context items: RPC_NETLOGON V1.0 (32bit NDR), RPC_NETLOGON V1.0 (64bit NDR), RPC_NETLOGON V1.0 (6cb71c2c-9812-4540-0300-000000000000)
192.168.100.10  192.168.100.13  DCERPC        Bind_ack: call_id: 2, Fragment: Single, max_xmit: 5840 max_recv: 5840, 3 results: Provider rejection, Acceptance, Negotiate ACK
192.168.100.13  192.168.100.10  RPC_NETLOGON  NetrServerReqChallenge request, 
192.168.100.10  192.168.100.13  RPC_NETLOGON  NetrServerReqChallenge response
192.168.100.13  192.168.100.10  RPC_NETLOGON  NetrServerAuthenticate3 request
192.168.100.10  192.168.100.13  RPC_NETLOGON  NetrServerAuthenticate3 response
192.168.100.13  192.168.100.10  DCERPC        Alter_context: call_id: 4, Fragment: Single, 1 context items: RPC_NETLOGON V1.0 (64bit NDR)
192.168.100.10  192.168.100.13  DCERPC        Alter_context_resp: call_id: 4, Fragment: Single, max_xmit: 5840 max_recv: 5840, 1 results: Acceptance
192.168.100.13  192.168.100.10  RPC_NETLOGON  NetrLogonGetCapabilities request
192.168.100.10  192.168.100.13  RPC_NETLOGON  NetrLogonGetCapabilities response
192.168.100.13  192.168.100.10  RPC_NETLOGON  NetrLogonGetCapabilities request
192.168.100.10  192.168.100.13  RPC_NETLOGON  NetrLogonGetCapabilities response
192.168.100.13  192.168.100.10  RPC_NETLOGON  NetrLogonGetDomainInfo request
192.168.100.10  192.168.100.13  TCP           49682 → 49735 [ACK] Seq=505 Ack=1993 Win=2097920 Len=1460 [TCP PDU reassembled in 562]
192.168.100.10  192.168.100.13  RPC_NETLOGON  NetrLogonGetDomainInfo response
192.168.100.13  192.168.100.10  TCP           49735 → 49682 [ACK] Seq=1993 Ack=2113 Win=65280 Len=09735, DstPort=49682, PayloadLen=0, Seq=2988619262, Ack=225725553
```

### Kerberos

Kerberos traffic is also used during domain join operation because all the types of network traffic mentioned in the previous sections, including SMB, LDAP, and RPC, require authentication.

For example, in the following network trace, the client gets a Kerberos TGT for the user account `CONTOSO\puser2` and a service ticket for the target SPN `cifs/DC2.contoso.local`. Then, the client sets up an SMB session to the DC `DC2.contoso.local` with that service ticket.

```output
Source          Destination     Protocol  Info
192.168.100.13  192.168.100.10  TCP       49744 → 445 [SYN] Seq=0 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.10  192.168.100.13  TCP       445 → 49744 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.13  192.168.100.10  TCP       49744 → 445 [ACK] Seq=1 Ack=1 Win=65280 Len=0
192.168.100.13  192.168.100.10  SMB       Negotiate Protocol Request
192.168.100.10  192.168.100.13  SMB2      Negotiate Protocol Response
192.168.100.13  192.168.100.10  SMB2      Negotiate Protocol Request
192.168.100.10  192.168.100.13  SMB2      Negotiate Protocol Response
192.168.100.13  192.168.100.12  KRB5      AS-REQ
192.168.100.12  192.168.100.13  KRB5      KRB Error: KRB5KDC_ERR_PREAUTH_REQUIRED
192.168.100.13  192.168.100.12  KRB5      AS-REQ
192.168.100.12  192.168.100.13  KRB5      AS-REP
192.168.100.13  192.168.100.12  KRB5      TGS-REQ
192.168.100.12  192.168.100.13  KRB5      TGS-REP
192.168.100.13  192.168.100.10  SMB2      Session Setup Request
192.168.100.10  192.168.100.13  TCP       445 → 49744 [ACK] Seq=629 Ack=2213 Win=2097920 Len=0
192.168.100.10  192.168.100.13  SMB2      Session Setup Response
192.168.100.13  192.168.100.10  SMB2      Tree Connect Request Tree: \\DC2.contoso.local\IPC$
192.168.100.10  192.168.100.13  SMB2      Tree Connect Response
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
> Depending on the format of the user credentials provided for the domain join operation (for example, puser2@contoso.local, contoso\puser2, or contoso.local\puser2), you might see different Kerberos traffic.

#### About NTLM

Even if you don't see any Kerberos traffic, it doesn't necessarily mean the domain join operation must fail. This is because when Kerberos doesn't work under some scenarios, NT LAN Manager (NTLM) is used as a fallback. If nothing prevents NTLM from working properly, such as incompatible LMCompatibilityLevel or blocked NTLM authentication in Group Policy, the domain join still completes successfully with NTLM.

See the following example of a successful SMB session setup using NTLM authentication.

```output
Source          Destination     Protocol  Info
192.168.100.13  192.168.100.10  TCP       49708 → 445 [SYN] Seq=0 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.10  192.168.100.13  TCP       445 → 49708 [SYN, ACK] Seq=0 Ack=1 Win=65535 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.100.13  192.168.100.10  TCP       49708 → 445 [ACK] Seq=1 Ack=1 Win=65280 Len=0
192.168.100.13  192.168.100.10  SMB       Negotiate Protocol Request
192.168.100.10  192.168.100.13  SMB2      Negotiate Protocol Response
192.168.100.13  192.168.100.10  SMB2      Negotiate Protocol Request
192.168.100.10  192.168.100.13  SMB2      Negotiate Protocol Response
192.168.100.13  192.168.100.10  TCP       49708 → 445 [ACK] Seq=378 Ack=629 Win=64768 Len=0
192.168.100.13  192.168.100.10  SMB2      Session Setup Request, NTLMSSP_NEGOTIATE
192.168.100.10  192.168.100.13  SMB2      Session Setup Response, Error: STATUS_MORE_PROCESSING_REQUIRED, NTLMSSP_CHALLENGE
192.168.100.13  192.168.100.10  SMB2      Session Setup Request, NTLMSSP_AUTH, User: contoso\puser2
192.168.100.10  192.168.100.13  SMB2      Session Setup Response
192.168.100.13  192.168.100.10  SMB2      Tree Connect Request Tree: \\DC2.contoso.local\IPC$
192.168.100.10  192.168.100.13  SMB2      Tree Connect Response
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

[!INCLUDE [third-party-disclaimer](../../includes/third-party-disclaimer.md)]
