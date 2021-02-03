---
title: Troubleshoot Azure AD Connect objects and attributes
description: Describes how to determine why an object is not syncing in Azure AD.
ms.date: 2/3/2021
ms.prod-support-area-path: 
ms.reviewer: nualex
---

# End-to-end troubleshooting of Azure AD Connect objects and attributes

The intention of this article is to establish a common practice for troubleshooting synchronization issues where an object or attribute is not synchronizing to Azure Active Directory (AD) and doesn’t display any errors on the Sync Engine, in the Application Event Viewer logs, or in the Azure AD logs. It’s easy to get lost in the details when there’s no obvious error that surfaces, but with the practice outlined below you can isolate the issue and provide the best insights for a Microsoft Support Engineer to help you resolve the problem. 

Following the instructions in this article will allow you to:

- Troubleshoot the sync engine logic end-to-end
- Help you be more self-sufficient
- Resolve synchronization issues more efficiently

Over time, as you apply this troubleshooting method to your environment, you’ll be able to:

- Identify the issues more quickly because you will predict the step in which the issue will occur
- Determine where the starting point might be to review the data
- Determine the optimal resolution

:::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/aad-connect-flow-chart.png" alt-text="AAD Connect flow chart.":::

For learning purposes, the steps presented here start on local Active Directory (AD) and move all the way up to Azure AD, the most common direction of synchronization. However, the same principals apply to the inverse direction (with attribute writeback, for instance).


## Prerequisites

For a better understanding of this article, read the following prerequisite articles first as you will need to understand how to search for an object in the different sources (AD, AD CS, MV, etc.), and you will also need to know how to check the Connectors and Lineage of an object.

- [Azure AD Connect: Accounts and permissions](https://docs.microsoft.com/azure/active-directory/hybrid/reference-connect-accounts-permissions)
- [Troubleshoot an object that is not synchronizing with Azure Active Directory](https://docs.microsoft.com/azure/active-directory/hybrid/tshoot-connect-object-not-syncing) 
- [Troubleshoot object synchronization with Azure AD Connect sync](https://docs.microsoft.com/azure/active-directory/hybrid/tshoot-connect-objectsync)

## Bad Troubleshooting Practice

There is a flag in Azure AD called DirSyncEnabled that controls whether the tenant is prepared to accept synchronization of objects from on-premises AD.
Based on Microsoft Support experience, we have seen many Customers falling into the urge of disabling DirSync on the tenant while troubleshooting object or attribute synchronization issues. Turn off directory synchronization with a PowerShell cmdlet:

``` PowerShell
Set-MsolDirSyncEnabled -EnableDirSync $false "Please DON'T and keep reading!"
```

However, this command can cause serious issues, as it triggers a complex and lengthy backend operation to transfer SoA from local AD to Azure AD/Exchange Online for all the synced objects on the tenant. This operation is necessary to convert each object from DirSyncEnabled to cloud-only and clean up all the shadow properties synced from on-premises AD (for example, ShadowUserPrincipalName, ShadowProxyAddresses, etc.) Depending on the size of the tenant, this operation can take more than 72 hours and it’s not possible to predict when it’s done. Never use this method to troubleshoot a sync issue, will cause more harm, and does not fix anything. You will be blocked from enabling DirSync again until this disabling operation is complete and, after re-enabling DirSync, AADC will have to rematch all the on-premises objects with existent Azure AD objects, which can be disruptive.

The only scenarios where it’s supported to disable DirSync are:

-	You are decommissioning your on-premises synchronization server and you want to continue managing your identities entirely from the cloud. Meaning, moving from hybrid identities to cloud-only.
-	You have some synced objects in the tenant that you want to keep as cloud-only in Azure AD and remove them from on-premises AD permanently.
-	You are currently using a custom attribute as the SourceAnchor in AADC (such as employeeId) and you are re-installing AADC to start using ms-Ds-Consistency-Guid/ObjectGuid as the new SourceAnchor attribute (or vice-versa).
-	Some scenarios involving risky mailbox/tenant migration strategies.

You might need in some situations to temporarily stop synchronization or manually control AADC sync cycles, for instance, to run one sync step at a time. But instead of disabling DirSync, you can just stop the sync scheduler with the following cmdlet:

``` PowerShell
Set-ADSyncScheduler -SyncCycleEnabled $false
```

And when you’re ready, manually start a sync cycle with the following cmdlet:

``` PowerShell
Start-ADSyncSyncCycle
```

## Glossary

| Name	| Acronym |
|---|---|
| AADC | Azure AD Connect |
| AADCA | AAD Connector Account |
| AADCS | Azure AD Connector Space | 
| AADCS:AttributeA | Attribute 'A' in Azure AD Connector Space | 
| ACLs | Access Control Lists (also known as ADDS permissions) | 
| ADCA | AD Connector Account | 
| ADCS | Active Directory Connector Space | 
| ADCS:AttributeA | Attribute 'A' in Active Directory Connector Space  |
| ADDS or AD | Active Directory Domain Services |
| CS | Connector Space |
| MV |Metaverse |
| MSOL Account | Automatically generated AD Connector Account (MSOL_########) | 
| MV:AttributeA | Attribute 'A' in the Metaverse object	| 
| SoA | Source of Authority |

## Step 1: Synchronization between ADDS and ADCS

### Objective

This first step is to check if the object or attribute is present and consistent in ADCS. If you are able to locate the object in ADCS and all attributes have the expected values, go to [Step 2](#step-2-synchronization-between-adcs-and-mv).

:::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/adcs-ad-replication.png" alt-text="ADCS AD replication.":::

### Description

Synchronization between ADDS and ADCS occurs at the import step, which is the moment when AADC reads from the source directory and stores data in the DB. This step marks when the data is staged in the connector space. During a delta import from AD, AADC will request all the new changes that occurred after a given directory watermark. This call is initiated by AADC using Directory Services’ DirSync Control against Active Directory’s Replication Service, providing the last watermark since the last successful AD Import, which gives AD the point-in-time reference from when all the (delta) changes should be retrieved. A full import is different because AADC will import from AD all the data (in sync scope), and then will mark as obsolete (and delete) all the objects that are still present in ADCS but were not imported from AD. All the data between AD and AADC is transferred with LDAP and is encrypted by default.

:::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/aadc-connection-options.png" alt-text="AADC connection options.":::

If the connection with AD is successful, but the object or attribute is not present in ADCS (assuming the domain or object is in sync scope), then it is most likely an ADDS permission issue. The ADCA must have, at minimum, read permissions over the object in AD in order to import data to ADCS. By default, the MSOL account has explicit read/write permissions for all user, group, and computer properties, but this situation might still be a problem if:

- AADC is using a custom ADCA but was not provided with enough permissions in AD
- A parent OU has blocked inheritance, which prevents propagation of permissions from the root of the domain
- The object or attribute itself has blocked inheritance, which prevents propagation of permissions
- The object or attribute has an explicit Deny permission that prevents ADCA from reading it

### Troubleshooting

#### 1. Connectivity with AD

In the Synchronization Service Manager, the “Import from AD” step shows, which DC is contacted under **Connection Status**. You will most likely see an error here when there is a connectivity issue with AD.

:::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/import-from-ad-connection-status.png" alt-text="Import from AD connection status screen.":::
 
If you need to further troubleshoot connectivity with AD, especially if no errors surfaced in AADConnect server or if you are still in the process of installing the product, always start with the [ADConnectivityTool](https://docs.microsoft.com/azure/active-directory/hybrid/how-to-connect-adconnectivitytools#adconnectivitytool-during-installation).

Connection issues to ADDS can be caused by:

- Invalid AD credentials, for instance, if the ADCA has expired or the password has changed.
- A “failed-search” error occurs when DirSync Control fails to communicate with AD Replication Service, which is normally caused by high-network packet fragmentation.
- A “no-start-ma” error occurs when there are name resolution issues (DNS) in AD
- Many other problems can be caused by name resolution issues, network routing problems, blocked network ports, high network packet fragmentation, no writable DCs available, etc. So in such cases, it is necessary to have Directory Services or Networking support teams involved to help troubleshooting the issue.

**Troubleshooting Summary**

- Identify, which DC is being used
- Use preferred DCs to target the same DC
- Correctly identify the ADCA
- Use the ADConnectivityTool to identify the problem
- Using the LDP tool, try to bind against the DC with the ADCA
- Engage Directory Services or a network support team to help you troubleshoot the situation

#### 2. Run the Synchronization Troubleshooter

The [Troubleshoot Object Synchronization](https://docs.microsoft.com/azure/active-directory/hybrid/tshoot-connect-objectsync) tool should be the first thing to do, since this step alone can detect the most obvious reasons for an object or attribute failing to synchronize.

:::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/aadconnect-troubleshooting.png" alt-text="AADConnect Troubleshooting screen.":::

### 3. AD Permissions

Lack of AD permissions can affect both directions of the synchronization:

- When importing from ADDS to ADCS, lack of permissions can cause AADC to skip  objects or attributes where AADC cannot get ADDS updates in the import stream, because the ADCA does not have enough permissions to read the object.
- When exporting from ADCS to ADDS, lack of permissions in AD will generate a "permission-issue" export error.

When you open the properties of an AD object and go to **Security** > **Advanced**, you can look at the object's allow/deny ACLs and check the **Disable Inheritance** button (if inheritance is enabled). Ordering the column by **Type** will help identify all the “deny” permissions. AD permissions can vary widely, but by default you might only see one “Deny ACL” for “Exchange Trusted Subsystem”. Most permissions will be marked as “Allow”. 

The most relevant default permissions are:

- Authenticated Users

    :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/authenticated-users.png" alt-text="Authenticated users.":::

 
- Everyone

    :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/allow-everyone.png" alt-text="Allow Everyone.":::
 
- Custom ADCA or MSOL account

    :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/custom-adca-msol-account.png" alt-text="Custom ADCA or MSOL account.":::
 
- Pre-Windows 2000 Compatible Access

    :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/pre-windows-2000-comp-access.png" alt-text="Pre-Windows 2000 Compatible Access.":::
 
- SELF

    :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/allow-self.png" alt-text="Allow SELF.":::
 
The best way to troubleshoot permissions is to use the "Effective Access" feature in **AD Users and Computers** console, which will check the effective permissions for a given account (such as the ADCA) that has over the target object or attribute that you want to troubleshoot:

:::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/advanced-security-settings.png" alt-text="Advanced Security Settings.":::

> [!important]
> Troubleshooting AD permissions can be tricky because a change in ACLs does not take immediate effect. Always take into consideration that such changes are subject to AD replication. 
> 
> For instance:
> - Make sure that you are doing the necessary changes directly to the closest DC (see "[Connectivity with AD](#1-connectivity-with-ad)” above)
> - Wait for ADDS replications to occur
> - Restart ADSync service if possible, to clear the cache

**Troubleshooting summary**

- Identify, which DC is being used
- Use preferred DCs to target the same DC
- Correctly identify the ADCA
- Use the [Configure AD DS Connector Account Permissions](https://docs.microsoft.com/azure/active-directory/hybrid/how-to-connect-configure-ad-ds-connector-account) tool
- Use the "Effective Access" feature in AD Users and Computers
- Using the LDP tool, bind against the DC with the ADCA and try to read the failing object or attribute
- Temporarily add the ADCA to the Enterprise Admins or Domain Admins and restart ADSync service - **But don't use this addition as a solution**. After confirming the permissions issue, remove the ADCA from any highly privileged groups and provide the required AD permissions directly to the ADCA
- Engage Directory Services or a network support team to help you troubleshoot the situation


#### 4. AD replications

AD replications are likely to affect AADConnect (since it causes larger problems). However, when AADConnect is importing data from a DC with delayed replication, it will not import the latest information from AD. This lack of importation causes sync issues where an object or attribute recently created or changed in AD does not sync to AAD because it was not replicated to the DC that AADConnect is contacting. To confirm if the lack of imported data is the issue, check, which DC that AADC using for import (see “Connectivity to AD”) and use the **AD Users and Computers** console to directly connect to this server (see **Change Domain Controller** in the image below), then confirm that the data on this server corresponds to the latest data, and whether it is consistent with the respective ADCS data. At this stage, AADC will generate a greater load on the DC and networking layer.

:::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/change-domain-controller.png" alt-text="Active Directory Change Domain Controller option.":::
 
Another approach is using the RepAdmin tool to check the object's replication metadata on all DCs, get the value from all DCs, and check replication status between DCs:

1.	Attribute value from all DCs:<br />
    `repadmin /showattr \* \"DC=contoso,DC=com\" /subtree /filter:\"sAMAccountName=User01\" /attrs:pwdLastSet,UserPrincipalName`

    :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/repadmin-showattr.png" alt-text="RepAdmin tool using showattr.":::

1.	Object metadata from all DCs:<br />
    `repadmin /showobjmeta \* \"CN=username,DC=contoso,DC=com\" \> username-ObjMeta.txt`

    :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/repadmin-showobjmeta.png" alt-text="RepAdmin tool with showobjmeta command.":::
 
1.	AD Replication Summary<br />
    `repadmin /replsummary`

    :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/repadmin-replsummary.png" alt-text="RepAdmin tool using replsummary command.":::

**Troubleshooting summary**

- Identify, which DC is being used
- Compare data between DCs
- Analyze RepAdmin results
- Engage Directory Services or Network support team to help troubleshoot the issue

#### 5. Domain and OU changes, and object types or attributes filtered or excluded in ADDS Connector

1.	**Changing domain or OU filtering requires a full import**

    Keep in mind that even if the domain or OU filtering is confirmed, any changes to domain or OU filtering only take effect after running a full import step.

1.	**Attribute filtering with Azure AD app and attribute filtering**

    An easy-to-miss scenario for attributes not synchronizing is when Azure AD Connect is configured with the [Azure AD app and attribute filtering](https://docs.microsoft.com/azure/active-directory/hybrid/how-to-connect-install-custom#azure-ad-app-and-attribute-filtering) feature. You can check to see whether feature is enabled and for, which attributes by taking a **General Diagnostics Report**.

1.	**Object type excluded in ADDS Connector configuration**

    This situation does not occur as common with users and groups, but if all the objects of a specific object type are missing in ADCS then it might be useful to examine, which object types enabled in ADDS Connector configuration.

    You can use the **Get-ADSyncConnector** cmdlet to retrieve the object types enabled on the Connector as shown in the image below. Listed below are the object types that should be enabled by default:

    `(Get-ADSyncConnector \| where Name -eq \"Contoso.com\").ObjectInclusionList` 

    Several of the following object types should be enabled by default:

    :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/get-adsyncconnector-objects.png" alt-text="Get-ADSyncConnector object types.":::

    > [!note]
    > The **publicFolder** object type is only present when Mail Enabled Public Folder feature is enabled.

1.	**Attribute excluded in ADCS**

    In the same way, if the attribute is missing for all objects, check to see whether the attribute is selected on the AD Connector.

    To check for enabled attributes in ADDS Connector, use the Synchronization Manager as shown in the image below, or type the following PowerShell cmdlet:

    `(Get-ADSyncConnector \| where Name -eq \"Contoso.com\").AttributeInclusionList`

    :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/ad-connector-sync-manager.png" alt-text="AD Connector Synchronization Manager.":::

    > [!note]
    > Including or excluding object types or attributes in the Synchronization Service Manager is not supported.

**Troubleshooting Summary**

- Check the [Azure AD app and attribute filtering](https://docs.microsoft.com/azure/active-directory/hybrid/how-to-connect-install-custom#azure-ad-app-and-attribute-filtering) feature
- Confirm that the object type is included in ADCS
- Confirm that the attribute is included in ADCS
- Run a full import

#### Tools

- Get-ADSyncConnectorAccount - Identify the correct Connector account used by AADC
- [ADConnectivityTool](https://docs.microsoft.com/azure/active-directory/hybrid/how-to-connect-adconnectivitytools#adconnectivitytool-during-installation)  - Identify connectivity problems with ADDS
- Trace-ADSyncToolsADImport (ADSyncTools) - Trace data being imported from ADDS
- LDIFDE - Dump object from ADDS to compare data between ADDS and ADCS
- LDP - Test AD Bind connectivity and permissions to read object in the security context of ADCA
- DSACLS - Compare and evaluate ADDS permissions
- Set-ADSync<Feature>Permissions - Apply default AADC permissions in ADDS
- RepAdmin - Check AD object metadata and AD replication status

Not so useful tools:

- Network trace of a delta or full import step (since LDAP traffic is encrypted)
- Fiddler trace (there's no HTTP/S traffic)

## Step 2: Synchronization between ADCS and MV

:::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/adcs-metaverse-flow-chart.png" alt-text="ADCS to MetaVerse flow chart.":::
 
### Objective

This step checks whether the object or attribute flows from CS to MV (in other words, whether the object or attribute is projected to the MV). At this stage, make sure that the object is present, or that the attribute is correct in ADCS (covered in [Step 1](#step-1-synchronization-between-adds-and-adcs)), and then start looking at the synchronization rules and lineage of the object.

### Description

The synchronization between ADCS and MV occurs on the delta/full synchronization step. At this point AADC reads the staged data in ADCS, processes all sync rules, and updates the respective MV object. This MV object will contain CS links (or connectors) pointing to the CS objects that contribute to its properties and the lineage of sync rules, which were applied in the synchronization step. During this stage, AADC will generate more load on the SQL Server (or LocalDB) and networking layer.

### Troubleshooting ADCS > MV for objects


1. **Check the inbound sync rules for provisioning**

    An object that is present in ADCS but missing in MV indicates that there were no scoping filters on any of the provisioning sync rules that applied to that object (for example, the “In from AD” sync rules shown in the image below), and therefore the object was not projected to MV. This situation may occur when there are disabled or customized sync rules.
    
    To get a list of inbound provisioning sync rules, type the following command:

    `Get-ADSyncRule \| where {\$\_.Name -like \"In From AD\*\" -and \$\_.LinkType -eq \"Provision\"} \| select Name,Direction,LinkType,Precedence,Disabled \| ft`

    :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/get-adsyncrule.png" alt-text="Get-ADSyncRule to check inbound provisioning rules."::: 

2. **Check the lineage of the ADCS object**

    You can retrieve the failing object from the ADCS by searching for "DN or Anchor" in "Search Connector Space"). In the **Lineage** tab, you will probably see that the object is a **Disconnector** (no links to MV) and the lineage is empty. Also check to see whether the object has any errors, in case there is a sync error tab.

    :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/connector-space-object-properties.png" alt-text="Connector Space Object Properties in ADCS.":::

3. **Run a preview on the ADCS object**

    Go to **Preview...** , select **Generate Preview**, and then **Commit Preview** to see if the object is projected to MV. If that is the case, then a full sync cycle should fix the issue for other objects in the same situation.

    :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/adcs-object-preview.png" alt-text="ADCS object preview screen.":::

    :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/adcs-source-object-details.png" alt-text="Source Object Details screen in ADCS.":::

4. **Export the object to XML**

    For a more detailed analysis (or for offline analysis), you can collect all the database data related to the object by using the **Export-ADSyncObject** cmdlet. This exported information will help determine, which rule is filtering out the object. In other words, which Inbound Scoping Filter in the Provisioning Sync Rules is preventing the object from being projected to the MV.

    Here are some examples of **Export-ADsyncObject** syntax:

    - `Import-Module .\\Export-ADsyncObject.psm1`
    - `Export-ADsyncObject -DistinguishedName \'CN=TestUser,OU=Sync,DC=Domain,DC=Contoso,DC=com\' -ConnectorName \'Domain.Contoso.com\'`
    - `Export-ADsyncObject -ObjectId \'{46EBDE97-7220-E911-80CB-000D3A3614C0}\' -Source Metaverse -Verbose`

**Troubleshooting summary (objects)**

- Check the scoping filters on the inbound provisioning rules "In From AD"
- Create a preview of the object
- Run a full sync cycle
- Export the object data with **Export-ADSyncObject** script


### Troubleshooting ADCS > MV for attributes

1. **Identify the inbound sync rules and transformation rules of the attribute**

    Each attribute has its own set of transformations rules responsible to direct the value from ADCS to MV. The first step is to identify, which sync rule(s) contain the transformation rule for the attribute you're troubleshooting.

    The best way to identify, which sync rules have a transformation rule for a given attribute is to use the built-in filtering capabilities of the **Synchronization Rules Editor**.

    :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/sync-rules-editor.png" alt-text="Synchronization Rules Editor in ADCS.":::

2. **Check the Lineage of the ADCS Object**

    Each connector (or link) between the CS and MV will have a lineage that contains information about the sync rules applied to that CS object. The previous step will tell you, which set of inbound sync rules (whether provisioning or joining sync rules) must be present in the object's lineage to flow the correct value from ADCS to MV. By examining the lineage on the ADCS object, you will be able to confirm if that sync rule has been applied to the object or not.

    :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/connector-space-object-properties-lineage.png" alt-text="Connector Space Object Properties lineage screen.":::
 
    In case there are multiple connectors (such as multiple AD forests) linked to the MV object, you may have to examine the **Metaverse Object Properties** to determine, which connector is contributing with the attribute you are trying to troubleshoot. (See the example in the image below with two AD connectors.) After you’ve identified the connector, examine the lineage of that ADCS object.

    :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/metaverse-object-properties.png" alt-text="Metaverse Object Properties screen.":::

3. **Check the scoping filters on the inbound sync rule**

    If a sync rule is enabled but not present in the object's lineage, then the object should be filtered out by the sync rule's scoping filter. By checking whether the sync rule is enabled or disabled, the sync rule's scoping filter(s), and the data on the ADCS object, you should be able to determine why that sync rule was not applied to the ADCS object.
    
    Here is an example of a common troublesome scoping filter from a sync rule responsible for synchronizing Exchange properties. If the object has a null value for **mailNickName**, then none of the Exchange attributes in the transformation rules will flow to Azure AD.

    :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/inbound-sync-rules.png" alt-text="Inbound synchronization rule screen.":::

4. **Run a preview on ADCS object**

    If you cannot find a reason for the sync rule missing in the ADCS object's lineage, then run a preview by using **Generate Preview** and **Commit Preview** for a full synchronization of the object. If the attribute is updated in the MV with a preview, then a full sync cycle should fix the issue for other objects in the same situation.

5. **Export the object to XML**

    For a more detailed analysis (or for offline analysis), you can collect all the database data related to the object by using the **Export-ADSyncObject** script. This exported information helps determine what is sync rule or transformation rule missing is on the object that is preventing the attribute from being projected to the MV (see **Export-ADSyncObject** examples above).


**Troubleshooting summary (for attributes)**

- Identify the correct sync rules and transformation rules responsible to flow the attribute to the MV
- Check the lineage of the object
- Check to see if sync rules have been enabled
- Check the scoping filters of the sync rules missing in the object's lineage


#### Advanced troubleshooting of the sync rule pipeline

If you need to further debug the ADSync engine (also known as the MiiServer) in terms of sync rule processing, you can enable ETW tracing on the config file (C:\Program Files\Microsoft Azure AD Sync\Bin\miiserver.exe.config). This method will generate an extensive verbose text file showing all the processing of sync rules, but it may be difficult to interpret all the information. Use this method as a last resort or if indicated by Microsoft Support.

#### Tools

- Synchronization Service Manager UI
- Synchronization Rules Editor
- Export-ADsyncObject script
- Start-ADSyncSyncCycle -PolicyType Initial
- ETW tracing SyncRulesPipeline (miiserver.exe.config)

## Step 3: Synchronization between MV and AADCS

:::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/mv-aadcs-flow-chart.png" alt-text="MV and AADCS flow chart.":::
 
#### Objective

This step checks to see if the object or attribute flows from MV to AADCS. At this point, make sure that the object is present, or that the attribute is correct in ADCS and MV (covered in Steps 1-2). Then start looking at the synchronization rules and lineage of the object. This step is similar to [Step 2](#step-2-synchronization-between-adcs-and-mv) where the inbound direction from ADCS to MV was examined, however, at this stage we are going to concentrate on the outbound sync rules and attribute that flows from MV to AADCS.

#### Description

The synchronization between MV and AADCS occurs on the delta/full synchronization step, which is when AADC reads the data in MV, processes all sync rules, and updates the respective AADCS object. This MV object will contain CS links (also known as connectors) pointing to the CS objects that contribute to its properties and the lineage of the sync rules that were applied in the synchronization step. At this point, AADC will generate more load on SQL Server (or localDB) and the networking layer.

#### Troubleshooting MV to AADCS for objects

1. **Check the outbound sync rules for provisioning**

    An object that is present in MV but missing in AADCS indicates that there were no scoping filters on any of the provisioning sync rules that applied to that object (for example, the “Out to AAD” sync rules shown in the image below), and therefore the object was not provisioned in AADCS. This situation can occur if there are disabled or customized sync rules.

    To get a list of inbound provisioning sync rules, type the following command:

    `Get-ADSyncRule \| where {\$\_.Name -like \"Out to AAD\*\" -and \$\_.LinkType -eq \"Provision\"} \| select Name,Direction,LinkType,Precedence,Disabled \| ft`

    :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/outbound-sync-rules.png" alt-text="Get-ADSyncRule to check outbound sync rules.":::

2. **Check the lineage of the ADCS object**

    You can retrieve the failing object from the MV using a **Metaverse Search** and examine the connectors tab. From this tab, you will be able to determine if the MV object is linked (also known as connected) to an AADCS object. Check whether the object has any errors, in case a sync error tab is present.

    :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/metaverse-search.png" alt-text="Metaverse Search screen.":::
  
    If no AADCS connector is present, then the object is most likely set to **cloudFiltered=True**. You can confirm whether the object is cloudFiltered by examining the MV attributes to check, which sync rule is contributing with the CloudFiltered value.


3. Run a Preview on AADCS object

    Go to **Preview...** and then **Generate Preview** and **Commit a Preview** to see if the object connects to AADCS. If so, then a full sync cycle should fix the issue for other objects in the same situation.


4. Export the object to XML

    For a more detailed analysis (or for offline analysis), you can collect all the database data related to the object by using the **Export-ADSyncObject** script. This exported information, together with the (outbound) sync rules configuration, will help determine which rule is filtering out the object. As an example, which outbound scoping filter in the provisioning sync rules is preventing the object from connecting with the AADCS.

    Here are some examples of **Export-ADsyncObject** syntax:

    - `Import-Module .\\Export-ADsyncObject.psm1`
    - `Export-ADsyncObject -ObjectId \'{46EBDE97-7220-E911-80CB-000D3A3614C0}\' -Source Metaverse -Verbose`
    - `Export-ADsyncObject -DistinguishedName \'CN={2B4B574735713744676B53504C39424D4C72785247513D3D}\' -ConnectorName \'Contoso.onmicrosoft.com - AAD\'`


**Troubleshooting summary for objects**

- Check the scoping filters on the outbound provisioning rules "Out to AAD"
- Create a preview of the object
- Run a full sync cycle
- Export the object data with the **Export-ADSyncObject** script

### Troubleshooting MV to AADCS for attributes

1. **Identify the outbound sync rules and transformation rules of the attribute**

    Each attribute has its own set of transformation rules responsible to flow the value from MV to AADCS. The first thing to do is to identify, which sync rule(s) contain the transformation rule for the attribute you're troubleshooting.

    The best way to identity, which sync rules have a transformation rule for a given attribute is to use the built-in filtering capabilities of the Synchronization Rules Editor.

    :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/view-manage-sync-rules.png" alt-text="Synchronization Rules Editor.":::

2. **Check the lineage of the ADCS object**

    Each connector (or link) between the CS and MV will have a lineage that contains information about the sync rules applied to that CS object. The previous step will tell you, which set of outbound sync rules (whether provisioning or joining sync rules) must be present in the object's lineage to flow the correct value from MV to AADCS. By examining the lineage on the AADCS object, you will be able to confirm whether that sync rule has been applied to the object or not.

    :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/connector-space-object-properties-run.png" alt-text="Examine the lineage on the AADCS object.":::

 3. **Check the scoping filters on the outbound sync rule**

    If a sync rule is enabled but not present in the object's lineage, then it should be filtered out by the sync rule's scoping filter. By checking whether the sync rule is enabled or disabled, the presence of the sync rule's scoping filter(s), and the data on the MV object, you should be able to determine why that sync rule wasn’t applied to the AADCS object.


4. **Run a preview on AADCS object**

    If you cannot find a reason for the sync rule missing from the ADCS object's lineage, then run a preview with **Generate Preview** and **Commit Preview** for a full synchronization of the object. If the attribute is updated in the MV with a preview, then a full sync cycle should fix the issue for other objects in the same situation.


5. **Export the object to XML**

    For a more detailed analysis (or for offline analysis), you can collect all the database data related to the object by using the Export-ADSyncObject script. This exported information, together with the (outbound) sync rules configuration, will help determine what sync rule or transformation rule missing from the object is preventing the attribute from flowing to AADCS (see Export-ADSyncObject examples above).

### Troubleshooting summary for attributes

- Identify the correct sync rules and transformation rules responsible to flow the attribute to AADCS
- Check the lineage of the object
- Check that the sync rules are enabled
- Check the scoping filters of the sync rules missing in the object's lineage


### Advanced troubleshooting of the sync rule pipeline

If you need to further debug the ADSync engine (also known as the MiiServer) in terms of sync rule processing, you can enable ETW tracing on the config file (C:\Program Files\Microsoft Azure AD Sync\Bin\miiserver.exe.config). This method will generate an extensive verbose text file showing all the processing of sync rules, but it may be difficult to interpret all of the information. Use it as a last resort or if indicated by Microsoft Support.

### Tools
- Synchronization Service Manager UI
- Synchronization Rules Editor
- Export-ADsyncObject script
- Start-ADSyncSyncCycle -PolicyType Initial
- ETW tracing SyncRulesPipeline (miiserver.exe.config)

## Step 4: Synchronization between AADCS and AzureAD

:::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/sync-aadcs-azuread.png" alt-text="Sync flow chart between AADCS and AzureAD.":::
 
### Objective

This stage compares the AADCS object with the respective object provisioned in Azure AD.

### Description

There are multiple components involved in the process of importing or exporting data to and from Azure AD, which can cause issues, including:
- Issues with connectivity to the internet
- Internal firewalls and ISP connectivity problems (for example, blocked network traffic)
- The Azure AD Gateway in front of DirSync Webservice (also known as, the AdminWebService endpoint)
- The DirSync Webservice API itself
- The Azure AD Core directory service

Fortunately, the issues related to these components will most certainly generate an error in application event logs that can be traced by Microsoft Support so it is out of scope for this document. Nevertheless, there are still some "silent" issues that can be examined.

### Troubleshooting

- **Multiple Active AADC servers exporting to AAD**

    A typical cause for objects in Azure AD flipping attribute values back and forth is when there's more than one active AADConnect server, and one of these servers lost contact with the local AD but is still connected to the internet and able to export data to Azure AD. Therefore, every time this "stale" server imports a change from AAD on a synchronized object made by the other active server, the sync engine will revert that change based on the stale AD data present in the ADCS. A typical symptom in this scenario occurs when you make a change in AD that is synced to Azure AD but a few minutes later (up to 30 minutes) the change is reverted back to the original value. To quickly mitigate this problem, go back to any old servers or virtual machines that have been decommissioned and check if the ADSync service is still running.


- **Mobile attribute with DirSyncOverrides**

    When the Admin uses MsOnline or AzureAD PowerShell module, or if the user goes to Office Portal and updates the **Mobile** attribute, then the updated phone number will be overwritten in AzureAD regardless of the object being synced from on-premises AD (also known as **DirSyncEnabled**). 

    Along with this update, Azure AD also sets a **DirSyncOverrides** on the object to flag that this user has the mobile phone number "overridden" in Azure AD. From this point on, any update to the mobile attribute originating from on-premises will be ignored, as this attribute will no longer be managed by on-premises AD. 

    A support engineer can raise an internal escalation request to revert the mobile SoA to on-premises by providing the **objectId(s)** of the target user(s). However, this method is not recommended, as the issue can happen again if a user or admin updates the **Mobile** attribute in Office Portal or via PowerShell. 

3. **ThumbnailPhoto attribute (KB4518417)**

    There is a general misconception that once you sync **ThumbnailPhoto** from AD for the first time, it's no longer possible to update it. This situation is not entirely true. 

    Normally, the **ThumbnailPhoto** in Azure AD is continually updated, but the issue occurs when the updated picture is no longer retrieved from Azure AD by the respective workload or partner (such as EXO or SfBO), which causes the false impression that the picture was not synced from on-prem AD to Azure AD.

    The basic steps to troubleshoot ThumbnailPhoto are:
    
    1. Use a tool like [AD Photo Edit](http://www.cjwdev.com/Software/ADPhotoEdit/Info.html)  or similar to guarantee that the image is correctly stored in AD and is not exceeding the size limit of 100 KB.
    2. Check the image in the Accounts Portal or use **Get-AzureADUserThumbnailPhoto**, as these methods will read the **ThumbnailPhoto** directly from Azure AD.
    3.	If the AD (or AzureAD) **thumbnailPhoto** has the correct image but is not correct on other online services, then:
        - The user's mailbox might contain an HD image and is not accepting low-resolution images from Azure AD thumbnailPhoto. The solution is to directly update the user's mailbox image.
        - The user's mailbox image has been updated correctly but you are still seeing the original image. The solution is to wait at least six hours to see the updated image in the Office 365 User Portal or Azure portal.

4. **UserPrincipalName changes do not update in Azure AD**

    If the **UserPrincipalName** attribute is not updated in Azure AD, while other attributes will sync normally, there's a chance that a feature called [SynchronizeUpnForManagedUsers](https://docs.microsoft.com/azure/active-directory/hybrid/how-to-connect-syncservice-features#synchronize-userprincipalname-updates)  is not enabled on the tenant. This "by design" feature often generates new support tickets, some of which are escalated to EEE team due to total lack of knowledge.

    Before this feature was added, any updates to the UPN coming from on-premises after the user was provisioned in Azure AD and assigned a license were “silently” ignored. An admin would have to use MsOnline or Azure AD PowerShell to update the UPN directly in Azure AD. After enabling this feature, any updates to UPN will flow to Azure AD regardless of whether the user is licensed (managed) or not. 

    > [!Note]
    > Once enabled, this feature cannot be disabled.

    **UserPrincipalName** updates will work if the user is NOT licensed, but without the [SynchronizeUpnForManagedUsers](https://docs.microsoft.com/azure/active-directory/hybrid/how-to-connect-syncservice-features#synchronize-userprincipalname-updates) feature, **UserPrincipalName** changes after the user is provisioned and is assigned a licensed will NOT be updated in AAD. Microsoft does not disable this feature on behalf of the customer.


5. **Invisible characters & ProxyCalc internals**

    Issues with invalid characters that don't produce any sync error are more troublesome in **UserPrincipalName** and **ProxyAddresses** attributes due to the cascading effect in ProxyCalc processing, which will “silently” discard the value coming from on-premises AD, as follows:

    1.	The resulting **UserPrincipalName** in Azure AD will be the **MailNickName** or **CommonName** @ (at) initial domain. For instance, instead of John.Smith@Contoso.com, the **UserPrincipalName** in AAD might become smithj@Contoso.onmicrosoft.com because there's an invisible character in the UPN value coming from on-premises AD.
    2.	If a **ProxyAddress** contains a space character, **ProxyCalc** will discard it and autogenerate an email address based on **MailNickName** at Initial Domain. For instance, “SMTP: John.Smith@Contoso.com” will not show up in AAD because it contains a space character between “SMTP:” and the email address.
    3.	Either a **UserPrincipalName** with a space character or a **ProxyAddress** with an invisible character will cause the same issue.

    To troubleshoot a space character in the **UserPrincipalName** or **ProxyAddress**, examine the value stored in the local AD from an LDIFDE or PowerShell exported to a file. An easy trick is to take the exported file and copy/paste the contents into a PowerShell window. The invisible character will be replaced with a question mark (“?”), as shown in the example below.

    :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/userprinciplename.png" alt-text="Troubleshoot UserPrincipalName or ProxyAddress.":::
 
### Tools

- Get-AzureADUser -ObjectId \<UserPrincipalName> | Out-File
- [AD Photo Edit tool](http://www.cjwdev.com/Software/ADPhotoEdit/Info.html) 
- [Get-AzureADUserThumbnailPhoto](https://docs.microsoft.com/powershell/module/azuread/get-azureaduserthumbnailphoto) 
- LDIFDE
- Get-ADUser -Identity \<username> | Out-File
- AADConnector PowerShell Module (Decode AAD DN)
