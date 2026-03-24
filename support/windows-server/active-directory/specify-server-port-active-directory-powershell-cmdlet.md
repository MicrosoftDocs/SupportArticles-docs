---
title: Specify a server name and port number for an Active Directory cmdlet
description: 
ms.date: 03/25/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, herbertm, v-appelgatet
ms.custom:
- sap:Active Directory\Object attribute management, RID issues, and Group Scope
- pcy:WinComm Directory Services
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Specify a server name and port number for an Active Directory cmdlet

## Summary

When you use Windows PowerShell cmdlets to manage Active Directory Domain Services (AD DS), you can often specify a `-server` option. This option specifies the domain controller (DC) on which the command runs. To be more precise, you can specify a port number as well as a DC name.

```powershell
Get-ADCentralAccessRule -Filter * -server dc01.contoso.com:3268
```

This article explains how a port number affects the way that the command runs.

## More Information

 The following table lists the most common ports that you can use to connect to particular servers, and how to use them.

| Port | Comments |
| --- | --- |
| Port 389 | The default port that the Active Directory cmdlets use to connect to specific servers. |
| Port 3268 | The global catalog (GC) port. Use this port to optimize searches, to search all domains in a forest, and to search the whole forest. The GC is read-only. |
| Ports 636 and 3269 | The ports for secure LDAP connections to DCs and GCs. Use the Simple Authentication and Security Layer (SASL) protocol when you use these ports to connect. Don't use Transport Layer Security (TLS).<br /><br />**Important** Active Directory Web Services (ADWS), a service that most of the AD module cmdlets use<sup>\*</sup>, doesn't recognize TLS. |
| Custom port for Lightweight Directory Service (LDS) instances | Use the port number to identify the instance to connect to. Each instance can have a different schema and has a different set of naming contexts. These LDS instances are writable. |
| Custom port for mounted AD DS snapshots | Use the port number to specify which mounted snapshot instance to connect to. Each mounted snapshot instance can have a different schema and has a different set of naming contexts. Mounted snapshots are read-only. |

\* The cmdlets in the Active Directory PowerShell module don't connect directly to a particular server and port. Instead, they connect to Active Directory Web Services (ADWS) on port 9389. ADWS connects to the local Active Directory instance on the cmdlet's behalf.

## References

- [Service overview and network port requirements](./networking/service-overview-and-network-port-requirements.md)
- [AD DS: Database Mounting Tool (Snapshot Viewer or Snapshot Browser)](previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc753246(v=ws.10))
- [Active Directory Snapshot](archive/technet-wiki/28644.active-directory-snapshot)

The following table provides an index of the AD module cmdlets that support the `-server` option.

> [!NOTE]  
>
> - Some of these cmdlets can connect to a server without using a particular port number.
> - Some of these cmdlets might not use ADWS. To be certain, you can check the "Notes" section of the cmdlet's reference article. "Notes" lists whether the cmdlet requires ADWS.

| **Cmdlet** | **Description** |
|----|----|
| [Add-ADCentralAccessPolicyMember](powershell/module/activedirectory/add-adcentralaccesspolicymember) | Adds central access rules to a central access policy in Active Directory. |
| [Add-ADComputerServiceAccount](powershell/module/activedirectory/add-adcomputerserviceaccount) | Adds one or more service accounts to an Active Directory computer. |
| [Add-ADDomainControllerPasswordReplicationPolicy](powershell/module/activedirectory/add-addomaincontrollerpasswordreplicationpolicy) | Adds users, computers, and groups to the allowed or denied list of a read-only domain controller password replication policy. |
| [Add-ADFineGrainedPasswordPolicySubject](powershell/module/activedirectory/add-adfinegrainedpasswordpolicysubject) | Applies a fine-grained password policy to one more users and groups. |
| [Add-ADGroupMember](powershell/module/activedirectory/add-adgroupmember) | Adds one or more members to an Active Directory group. |
| [Add-ADPrincipalGroupMembership](powershell/module/activedirectory/add-adprincipalgroupmembership) | Adds a member to one or more Active Directory groups. |
| [Add-ADResourcePropertyListMember](powershell/module/activedirectory/add-adresourcepropertylistmember) | Adds one or more resource properties to a resource property list in Active Directory. |
| [Clear-ADAccountExpiration](powershell/module/activedirectory/clear-adaccountexpiration) | Clears the expiration date for an Active Directory account. |
| [Clear-ADClaimTransformLink](powershell/module/activedirectory/clear-adclaimtransformlink) | Removes a claims transformation from being applied to one or more cross-forest trust relationships in Active Directory. |
| [Complete-ADServiceAccountMigration](powershell/module/activedirectory/complete-adserviceaccountmigration) | Completes the migration process and supersedes a normal user account to a delegated managed service account. |
| [Disable-ADAccount](powershell/module/activedirectory/disable-adaccount) | Disables an Active Directory account. |
| [Disable-ADOptionalFeature](powershell/module/activedirectory/disable-adoptionalfeature) | Disables an Active Directory optional feature. |
| [Enable-ADAccount](powershell/module/activedirectory/enable-adaccount) | Enables an Active Directory account. |
| [Enable-ADOptionalFeature](powershell/module/activedirectory/enable-adoptionalfeature) | Enables an Active Directory optional feature. |
| [Get-ADAccountAuthorizationGroup](powershell/module/activedirectory/get-adaccountauthorizationgroup) | Gets the accounts token group information. |
| [Get-ADAccountResultantPasswordReplicationPolicy](powershell/module/activedirectory/get-adaccountresultantpasswordreplicationpolicy) | Gets the resultant password replication policy for an Active Directory account. |
| [Get-ADAuthenticationPolicy](powershell/module/activedirectory/get-adauthenticationpolicy) | Gets one or more Active Directory Domain Services authentication policies. |
| [Get-ADAuthenticationPolicySilo](powershell/module/activedirectory/get-adauthenticationpolicysilo) | Gets one or more Active Directory Domain Services authentication policy silos. |
| [Get-ADCentralAccessPolicy](powershell/module/activedirectory/get-adcentralaccesspolicy) | Retrieves central access policies from Active Directory. |
| [Get-ADCentralAccessRule](powershell/module/activedirectory/get-adcentralaccessrule) | Retrieves central access rules from Active Directory. |
| [Get-ADClaimTransformPolicy](powershell/module/activedirectory/get-adclaimtransformpolicy) | Returns one or more Active Directory claim transform objects based on a specified filter. |
| [Get-ADClaimType](powershell/module/activedirectory/get-adclaimtype) | Returns a claim type from Active Directory. |
| [Get-ADComputer](powershell/module/activedirectory/get-adcomputer) | Gets one or more Active Directory computers. |
| [Get-ADComputerServiceAccount](powershell/module/activedirectory/get-adcomputerserviceaccount) | Gets the service accounts hosted by a computer. |
| [Get-ADDefaultDomainPasswordPolicy](powershell/module/activedirectory/get-addefaultdomainpasswordpolicy) | Gets the default password policy for an Active Directory domain. |
| [Get-ADDomain](powershell/module/activedirectory/get-addomain) | Gets an Active Directory domain. |
| [Get-ADDomainController](powershell/module/activedirectory/get-addomaincontroller) | Gets one or more Active Directory domain controllers based on discoverable services criteria, search parameters or by providing a domain controller identifier, such as the NetBIOS name. |
| [Get-ADDomainControllerPasswordReplicationPolicy](powershell/module/activedirectory/get-addomaincontrollerpasswordreplicationpolicy) | Gets the members of the allowed list or denied list of a read-only domain controller's password replication policy. |
| [Get-ADDomainControllerPasswordReplicationPolicyUsage](powershell/module/activedirectory/get-addomaincontrollerpasswordreplicationpolicyusage) | Gets the Active Directory accounts that are authenticated by a read-only domain controller or that are in the revealed list of the domain controller. |
| [Get-ADFineGrainedPasswordPolicy](powershell/module/activedirectory/get-adfinegrainedpasswordpolicy) | Gets one or more Active Directory fine-grained password policies. |
| [Get-ADFineGrainedPasswordPolicySubject](powershell/module/activedirectory/get-adfinegrainedpasswordpolicysubject) | Gets the users and groups to which a fine-grained password policy is applied. |
| [Get-ADForest](powershell/module/activedirectory/get-adforest) | Gets an Active Directory forest. |
| [Get-ADGroup](powershell/module/activedirectory/get-adgroup) | Gets one or more Active Directory groups. |
| [Get-ADGroupMember](powershell/module/activedirectory/get-adgroupmember) | Gets the members of an Active Directory group. |
| [Get-ADObject](powershell/module/activedirectory/get-adobject) | Gets one or more Active Directory objects. |
| [Get-ADOptionalFeature](powershell/module/activedirectory/get-adoptionalfeature) | Gets one or more Active Directory optional features. |
| [Get-ADOrganizationalUnit](powershell/module/activedirectory/get-adorganizationalunit) | Gets one or more Active Directory organizational units. |
| [Get-ADPrincipalGroupMembership](powershell/module/activedirectory/get-adprincipalgroupmembership) | Gets the Active Directory groups that have a specified user, computer, group, or service account. |
| [Get-ADReplicationAttributeMetadata](powershell/module/activedirectory/get-adreplicationattributemetadata) | Gets the replication metadata for one or more Active Directory replication partners. |
| [Get-ADReplicationConnection](powershell/module/activedirectory/get-adreplicationconnection) | Returns a specific Active Directory replication connection or a set of AD replication connection objects based on a specified filter. |
| [Get-ADReplicationPartnerMetadata](powershell/module/activedirectory/get-adreplicationpartnermetadata) | Returns the replication metadata for a set of one or more replication partners. |
| [Get-ADReplicationSite](powershell/module/activedirectory/get-adreplicationsite) | Returns a specific Active Directory replication site or a set of replication site objects based on a specified filter. |
| [Get-ADReplicationSiteLink](powershell/module/activedirectory/get-adreplicationsitelink) | Returns a specific Active Directory site link or a set of site links based on a specified filter. |
| [Get-ADReplicationSiteLinkBridge](powershell/module/activedirectory/get-adreplicationsitelinkbridge) | Gets a specific Active Directory site link bridge or a set of site link bridge objects based on a specified filter. |
| [Get-ADReplicationSubnet](powershell/module/activedirectory/get-adreplicationsubnet) | Gets one or more Active Directory subnets. |
| [Get-ADResourceProperty](powershell/module/activedirectory/get-adresourceproperty) | Gets one or more resource properties. |
| [Get-ADResourcePropertyList](powershell/module/activedirectory/get-adresourcepropertylist) | Gets resource property lists from Active Directory. |
| [Get-ADResourcePropertyValueType](powershell/module/activedirectory/get-adresourcepropertyvaluetype) | Gets a resource property value type from Active Directory. |
| [Get-ADRootDSE](powershell/module/activedirectory/get-adrootdse) | Gets the root of a directory server information tree. |
| [Get-ADServiceAccount](powershell/module/activedirectory/get-adserviceaccount) | Gets one or more Active Directory managed service accounts or group managed service accounts. |
| [Get-ADTrust](powershell/module/activedirectory/get-adtrust) | Gets all trusted domain objects in the directory. |
| [Get-ADUser](powershell/module/activedirectory/get-aduser) | Gets one or more Active Directory users. |
| [Get-ADUserResultantPasswordPolicy](powershell/module/activedirectory/get-aduserresultantpasswordpolicy) | Gets the resultant password policy for a user. |
| [Grant-ADAuthenticationPolicySiloAccess](powershell/module/activedirectory/grant-adauthenticationpolicysiloaccess) | Grants permission to join an authentication policy silo. |
| [Move-ADDirectoryServer](powershell/module/activedirectory/move-addirectoryserver) | Moves a directory server in Active Directory to a new site. |
| [Move-ADDirectoryServerOperationMasterRole](powershell/module/activedirectory/move-addirectoryserveroperationmasterrole) | Moves operation master roles to an Active Directory directory server. |
| [Move-ADObject](powershell/module/activedirectory/move-adobject) | Moves an Active Directory object or a container of objects to a different container or domain. |
| [New-ADAuthenticationPolicy](powershell/module/activedirectory/new-adauthenticationpolicy) | Creates an Active Directory Domain Services authentication policy object. |
| [New-ADAuthenticationPolicySilo](powershell/module/activedirectory/new-adauthenticationpolicysilo) | Creates an Active Directory Domain Services authentication policy silo object. |
| [New-ADCentralAccessPolicy](powershell/module/activedirectory/new-adcentralaccesspolicy) | Creates a new central access policy in Active Directory containing a set of central access rules. |
| [New-ADCentralAccessRule](powershell/module/activedirectory/new-adcentralaccessrule) | Creates a central access rule in Active Directory. |
| [New-ADClaimTransformPolicy](powershell/module/activedirectory/new-adclaimtransformpolicy) | Creates a new claim transformation policy object in Active Directory. |
| [New-ADClaimType](powershell/module/activedirectory/new-adclaimtype) | Creates a new claim type in Active Directory. |
| [New-ADComputer](powershell/module/activedirectory/new-adcomputer) | Creates a new Active Directory computer object. |
| [New-ADFineGrainedPasswordPolicy](powershell/module/activedirectory/new-adfinegrainedpasswordpolicy) | Creates a new Active Directory fine-grained password policy. |
| [New-ADGroup](powershell/module/activedirectory/new-adgroup) | Creates an Active Directory group. |
| [New-ADObject](powershell/module/activedirectory/new-adobject) | Creates an Active Directory object. |
| [New-ADOrganizationalUnit](powershell/module/activedirectory/new-adorganizationalunit) | Creates an Active Directory organizational unit. |
| [New-ADReplicationSite](powershell/module/activedirectory/new-adreplicationsite) | Creates an Active Directory replication site in the directory. |
| [New-ADReplicationSiteLink](powershell/module/activedirectory/new-adreplicationsitelink) | Creates a new Active Directory site link for in managing replication. |
| [New-ADReplicationSiteLinkBridge](powershell/module/activedirectory/new-adreplicationsitelinkbridge) | Creates a site link bridge in Active Directory for replication. |
| [New-ADReplicationSubnet](powershell/module/activedirectory/new-adreplicationsubnet) | Creates an Active Directory replication subnet object. |
| [New-ADResourceProperty](powershell/module/activedirectory/new-adresourceproperty) | Creates a resource property in Active Directory. |
| [New-ADResourcePropertyList](powershell/module/activedirectory/new-adresourcepropertylist) | Creates a resource property list in Active Directory. |
| [New-ADServiceAccount](powershell/module/activedirectory/new-adserviceaccount) | Creates a new Active Directory managed service account or group managed service account object. |
| [New-ADUser](powershell/module/activedirectory/new-aduser) | Creates an Active Directory user. |
| [Remove-ADAuthenticationPolicy](powershell/module/activedirectory/remove-adauthenticationpolicy) | Removes an Active Directory Domain Services authentication policy object. |
| [Remove-ADAuthenticationPolicySilo](powershell/module/activedirectory/remove-adauthenticationpolicysilo) | Removes an Active Directory Domain Services authentication policy silo object. |
| [Remove-ADCentralAccessPolicy](powershell/module/activedirectory/remove-adcentralaccesspolicy) | Removes a central access policy from Active Directory. |
| [Remove-ADCentralAccessPolicyMember](powershell/module/activedirectory/remove-adcentralaccesspolicymember) | Removes central access rules from a central access policy in Active Directory. |
| [Remove-ADCentralAccessRule](powershell/module/activedirectory/remove-adcentralaccessrule) | Removes a central access rule from Active Directory. |
| [Remove-ADClaimTransformPolicy](powershell/module/activedirectory/remove-adclaimtransformpolicy) | Removes a claim transformation policy object from Active Directory. |
| [Remove-ADClaimType](powershell/module/activedirectory/remove-adclaimtype) | Removes a claim type from Active Directory. |
| [Remove-ADComputer](powershell/module/activedirectory/remove-adcomputer) | Removes an Active Directory computer. |
| [Remove-ADComputerServiceAccount](powershell/module/activedirectory/remove-adcomputerserviceaccount) | Removes one or more service accounts from a computer. |
| [Remove-ADDomainControllerPasswordReplicationPolicy](powershell/module/activedirectory/remove-addomaincontrollerpasswordreplicationpolicy) | Removes users, computers, and groups from the allowed or denied list of a read-only domain controller password replication policy. |
| [Remove-ADFineGrainedPasswordPolicy](powershell/module/activedirectory/remove-adfinegrainedpasswordpolicy) | Removes an Active Directory fine-grained password policy. |
| [Remove-ADFineGrainedPasswordPolicySubject](powershell/module/activedirectory/remove-adfinegrainedpasswordpolicysubject) | Removes one or more users from a fine-grained password policy. |
| [Remove-ADGroup](powershell/module/activedirectory/remove-adgroup) | Removes an Active Directory group. |
| [Remove-ADGroupMember](powershell/module/activedirectory/remove-adgroupmember) | Removes one or more members from an Active Directory group. |
| [Remove-ADObject](powershell/module/activedirectory/remove-adobject) | Removes an Active Directory object. |
| [Remove-ADOrganizationalUnit](powershell/module/activedirectory/remove-adorganizationalunit) | Removes an Active Directory organizational unit. |
| [Remove-ADPrincipalGroupMembership](powershell/module/activedirectory/remove-adprincipalgroupmembership) | Removes a member from one or more Active Directory groups. |
| [Remove-ADReplicationSite](powershell/module/activedirectory/remove-adreplicationsite) | Deletes the specified replication site object from Active Directory. |
| [Remove-ADReplicationSiteLink](powershell/module/activedirectory/remove-adreplicationsitelink) | Deletes an Active Directory site link used to manage replication. |
| [Remove-ADReplicationSiteLinkBridge](powershell/module/activedirectory/remove-adreplicationsitelinkbridge) | Deletes a replication site link bridge from Active Directory. |
| [Remove-ADReplicationSubnet](powershell/module/activedirectory/remove-adreplicationsubnet) | Deletes the specified Active Directory replication subnet object from the directory. |
| [Remove-ADResourceProperty](powershell/module/activedirectory/remove-adresourceproperty) | Removes a resource property from Active Directory. |
| [Remove-ADResourcePropertyList](powershell/module/activedirectory/remove-adresourcepropertylist) | Removes one or more resource property lists from Active Directory. |
| [Remove-ADResourcePropertyListMember](powershell/module/activedirectory/remove-adresourcepropertylistmember) | Removes one or more resource properties from a resource property list in Active Directory. |
| [Remove-ADServiceAccount](powershell/module/activedirectory/remove-adserviceaccount) | Removes an Active Directory managed service account or group managed service account object. |
| [Remove-ADUser](powershell/module/activedirectory/remove-aduser) | Removes an Active Directory user. |
| [Rename-ADObject](powershell/module/activedirectory/rename-adobject) | Changes the name of an Active Directory object. |
| [Reset-ADServiceAccountMigration](powershell/module/activedirectory/reset-adserviceaccountmigration) | Resets the state of a migration to an delegated managed service account and unlinks the delegated managed service account from the user account. |
| [Restore-ADObject](powershell/module/activedirectory/restore-adobject) | Restores an Active Directory object. |
| [Revoke-ADAuthenticationPolicySiloAccess](powershell/module/activedirectory/revoke-adauthenticationpolicysiloaccess) | Revokes membership in an authentication policy silo for the specified account. |
| [Search-ADAccount](powershell/module/activedirectory/search-adaccount) | Gets Active Directory user, computer, or service accounts. |
| [Set-ADAccountAuthenticationPolicySilo](powershell/module/activedirectory/set-adaccountauthenticationpolicysilo) | Modifies the authentication policy or authentication policy silo of an account. |
| [Set-ADAccountControl](powershell/module/activedirectory/set-adaccountcontrol) | Modifies user account control (UAC) values for an Active Directory account. |
| [Set-ADAccountExpiration](powershell/module/activedirectory/set-adaccountexpiration) | Sets the expiration date for an Active Directory account. |
| [Set-ADAccountPassword](powershell/module/activedirectory/set-adaccountpassword) | Modifies the password of an Active Directory account. |
| [Set-ADAuthenticationPolicy](powershell/module/activedirectory/set-adauthenticationpolicy) | Modifies an Active Directory Domain Services authentication policy object. |
| [Set-ADAuthenticationPolicySilo](powershell/module/activedirectory/set-adauthenticationpolicysilo) | Modifies an Active Directory Domain Services authentication policy silo object. |
| [Set-ADCentralAccessPolicy](powershell/module/activedirectory/set-adcentralaccesspolicy) | Modifies a central access policy in Active Directory. |
| [Set-ADCentralAccessRule](powershell/module/activedirectory/set-adcentralaccessrule) | Modifies a central access rule in Active Directory. |
| [Set-ADClaimTransformLink](powershell/module/activedirectory/set-adclaimtransformlink) | Applies a claims transformation to one or more cross-forest trust relationships in Active Directory. |
| [Set-ADClaimTransformPolicy](powershell/module/activedirectory/set-adclaimtransformpolicy) | Sets the properties of a claims transformation policy in Active Directory. |
| [Set-ADClaimType](powershell/module/activedirectory/set-adclaimtype) | Modify a claim type in Active Directory. |
| [Set-ADComputer](powershell/module/activedirectory/set-adcomputer) | Modifies an Active Directory computer object. |
| [Set-ADDefaultDomainPasswordPolicy](powershell/module/activedirectory/set-addefaultdomainpasswordpolicy) | Modifies the default password policy for an Active Directory domain. |
| [Set-ADDomain](powershell/module/activedirectory/set-addomain) | Modifies an Active Directory domain. |
| [Set-ADDomainMode](powershell/module/activedirectory/set-addomainmode) | Sets the domain mode for an Active Directory domain. |
| [Set-ADFineGrainedPasswordPolicy](powershell/module/activedirectory/set-adfinegrainedpasswordpolicy) | Modifies an Active Directory fine-grained password policy. |
| [Set-ADForest](powershell/module/activedirectory/set-adforest) | Modifies an Active Directory forest. |
| [Set-ADForestMode](powershell/module/activedirectory/set-adforestmode) | Sets the forest mode for an Active Directory forest. |
| [Set-ADGroup](powershell/module/activedirectory/set-adgroup) | Modifies an Active Directory group. |
| [Set-ADObject](powershell/module/activedirectory/set-adobject) | Modifies an Active Directory object. |
| [Set-ADOrganizationalUnit](powershell/module/activedirectory/set-adorganizationalunit) | Modifies an Active Directory organizational unit. |
| [Set-ADReplicationConnection](powershell/module/activedirectory/set-adreplicationconnection) | Sets properties on Active Directory replication connections. |
| [Set-ADReplicationSite](powershell/module/activedirectory/set-adreplicationsite) | Sets the replication properties for an Active Directory site. |
| [Set-ADReplicationSiteLink](powershell/module/activedirectory/set-adreplicationsitelink) | Sets the properties for an Active Directory site link. |
| [Set-ADReplicationSiteLinkBridge](powershell/module/activedirectory/set-adreplicationsitelinkbridge) | Sets the properties of a replication site link bridge in Active Directory. |
| [Set-ADReplicationSubnet](powershell/module/activedirectory/set-adreplicationsubnet) | Sets the properties of an Active Directory replication subnet object. |
| [Set-ADResourceProperty](powershell/module/activedirectory/set-adresourceproperty) | Modifies a resource property in Active Directory. |
| [Set-ADResourcePropertyList](powershell/module/activedirectory/set-adresourcepropertylist) | Modifies a resource property list in Active Directory. |
| [Set-ADServiceAccount](powershell/module/activedirectory/set-adserviceaccount) | Modifies an Active Directory managed service account or group managed service account object. |
| [Set-ADUser](powershell/module/activedirectory/set-aduser) | Modifies an Active Directory user. |
| [Show-ADAuthenticationPolicyExpression](powershell/module/activedirectory/show-adauthenticationpolicyexpression) | Displays the Edit Access Control Conditions window update or create security descriptor definition language (SDDL) security descriptors. |
| [Start-ADServiceAccountMigration](powershell/module/activedirectory/start-adserviceaccountmigration) | Starts the migration process by linking a normal user account to a delegated managed service account. |
| [Undo-ADServiceAccountMigration](powershell/module/activedirectory/undo-adserviceaccountmigration) | Reverts the previous migration phase of a migration to an delegated managed service account. If the migration process is currently in the start phase, the accounts will be unlinked from each other. If the migration is in the completed phase, it'll return back to the state in the start phase. |
| [Unlock-ADAccount](powershell/module/activedirectory/unlock-adaccount) | Unlocks an Active Directory account. |
