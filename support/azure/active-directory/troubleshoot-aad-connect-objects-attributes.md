---
title: Troubleshoot Microsoft Entra Connect objects and attributes
description: Describes how to determine why an object is not syncing in Microsoft Entra ID.
ms.date: 02/03/2021
ms.reviewer: nualex
editor: v-jesits
ms.service: active-directory
ms.subservice: enterprise-users
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---

# End-to-end troubleshooting of Microsoft Entra Connect objects and attributes

This article is intended to establish a common practice for how to troubleshoot synchronization issues in Microsoft Entra ID. This method applies to situations in which an object or attribute doesn't synchronize to Azure Active AD and doesn't display any errors on the sync engine, in the Application viewer logs, or in the Microsoft Entra logs. It's easy to get lost in the details if there's no obvious error. However, by using best practices, you can isolate the issue and provide insights for Microsoft Support engineers.

As you apply this troubleshooting method to your environment, over time, you'll be able to do the following steps:

- Troubleshoot the sync engine logic from end to end.
- Resolve synchronization issues more efficiently.
- Identify issues more quickly by predicting the step in which they'll occur.
- Identify the starting point for reviewing data.
- Determine the optimal resolution.

:::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/aad-connect-flow-chart.png" alt-text="Screenshot of the Microsoft Entra Connect flow chart.":::

The steps that are provided here start at the local Active Directory level and progress toward Microsoft Entra ID. These steps are the most common direction of synchronization. However, the same principles apply to the inverse direction (for example, for attribute writeback).

## Prerequisites

For a better understanding of this article, first read the following prerequisite articles for a better understanding of how to search for an object in different sources (AD, AD CS, MV, and so on), and to understand how to check the connectors and lineage of an object.

- [Microsoft Entra Connect: Accounts and permissions](/azure/active-directory/hybrid/reference-connect-accounts-permissions)
- [Troubleshoot an object that is not synchronizing with Microsoft Entra ID](/azure/active-directory/hybrid/tshoot-connect-object-not-syncing)
- [Troubleshoot object synchronization with Microsoft Entra Connect Sync](/azure/active-directory/hybrid/tshoot-connect-objectsync)

## Bad troubleshooting practices

The DirSyncEnabled flag in Microsoft Entra ID controls whether the tenant is prepared to accept synchronization of objects from on-premises AD.
We've seen many customers fall into the habit of disabling DirSync on the tenant while troubleshooting object or attribute synchronization issues. It's easy to turn off directory synchronization by running the following PowerShell cmdlet:

``` PowerShell
Set-MsolDirSyncEnabled -EnableDirSync $false "Please DON'T and keep reading!"
```

[!INCLUDE [Azure AD PowerShell deprecation note](~/../support/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

However, this can be catastrophic because it triggers a complex and lengthy back-end operation to transfer SoA from local Active Directory to Microsoft Entra ID / Exchange Online for all the synced objects on the tenant. This operation is necessary to convert each object from DirSyncEnabled to cloud-only, and clean up all the shadow properties that are synced from on-premises AD (for example, ShadowUserPrincipalName and ShadowProxyAddresses). Depending on the size of the tenant, this operation can take more than 72 hours. Also, it's not possible to predict when the operation will finish. Never use this method to troubleshoot a sync issue because this will cause additional harm and won't fix the issue. You'll be blocked from enabling DirSync again until this disabling operation is complete. Also, after you re-enable DirSync, AADC must again match all the on-premises objects with existent Microsoft Entra objects. This process can be disruptive.

The only scenarios in which this command is supported to disable DirSync are as follows:

- You are decommissioning your on-premises synchronization server, and you want to continue managing your identities entirely from the cloud instead of from hybrid identities.
- You have some synced objects in the tenant that you want to keep as cloud-only in Microsoft Entra ID and remove from on-premises AD permanently.
- You are currently using a custom attribute as the SourceAnchor in AADC (for example, employeeId), and you are re-installing AADC to start using **ms-Ds-Consistency-Guid/ObjectGuid** as the new SourceAnchor attribute (or vice versa).
- You have some scenarios that involve risky mailbox and tenant migration strategies.

In some situations, you might have to temporarily stop synchronization or manually control AADC sync cycles. For example, you might have to stop synchronization to be able to run one sync step at a time. However, instead of disabling DirSync, you can stop only the sync scheduler by running the following cmdlet:

``` PowerShell
Set-ADSyncScheduler -SyncCycleEnabled $false
```

And when you're ready, manually start a sync cycle by running the following cmdlet:

``` PowerShell
Start-ADSyncSyncCycle
```

## Glossary

|Acronym/abbreviation|Name/description|
|---|---|
|AADC|Microsoft Entra Connect|
|AADCA|Microsoft Entra Connector Account|
|AADCS|Microsoft Entra Connector Space|
|AADCS:AttributeA |Attribute 'A' in Microsoft Entra Connector Space|
|ACLs|Access Control Lists (also known as ADDS permissions)|
|ADCA|AD Connector Account|
|ADCS|Active Directory Connector Space|
|ADCS:AttributeA |Attribute 'A' in Active Directory Connector Space|
|ADDS or AD |Active Directory Domain Services|
|CS|Connector Space|
|MV|Metaverse|
|MSOL Account|Automatically generated AD Connector Account (MSOL_########)|
|MV:AttributeA|Attribute 'A' in the Metaverse object|
|SoA|Source of Authority|

## Step 1: Synchronization between ADDS and ADCS

### Objective for Step 1

Determine whether the object or attribute is present and consistent in ADCS. If you can locate the object in ADCS, and all attributes have the expected values, go to [Step 2](#step-2-synchronization-between-adcs-and-mv).

:::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/adcs-ad-replication.png" alt-text="Screenshot of the A D Connector Space A D replication.":::

### Description for Step 1

Synchronization between ADDS and ADCS occurs at the import step, and is the moment when AADC reads from the source directory and stores data in the database. That is, when data is staged in the connector space. During a delta import from AD, AADC requests all the new changes that occurred after a given directory watermark. This call is initiated by AADC by using the Directory Services DirSync Control against the Active Directory Replication Service. This step provides the last watermark as the last successful AD import, and gives AD the point-in-time reference from when all the (delta) changes should be retrieved. A full import is different because AADC will import from AD all the data (in sync scope), and then mark as obsolete (and delete) all the objects that are still in ADCS but were not imported from AD. All the data between AD and AADC is transferred through LDAP and is encrypted by default.

:::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/aadc-connection-options.png" alt-text="Screenshot of the A A D C connection options dialog." border="false":::

If the connection with AD is successful, but the object or attribute is not present in ADCS (assuming the domain or object is in sync scope), the issue most likely involves ADDS permissions. The ADCA requires ay least read permissions on the object in AD in order to import data to ADCS. By default, the MSOL account has explicit read/write permissions for all user, group, and computer properties. However, this situation might still be problematic if the following conditions are true:

- AADC uses a custom ADCA, but it was not provided sufficient permissions in AD.
- A parent OU has blocked inheritance, which prevents propagation of permissions from the root of the domain.
- The object or attribute itself has blocked inheritance, which prevents propagation of permissions.
- The object or attribute has an explicit Deny permission that prevents ADCA from reading it.

### Troubleshooting Active Directory

#### Connectivity with AD

In the Synchronization Service Manager, the "Import from AD" step shows which domain controller is contacted under **Connection Status**. You will most likely see an error here when there is a connectivity issue that affects AD.

:::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/import-from-ad-connection-status.png" alt-text="Screenshot shows the Connection Status area in the Import from A D step.":::

If you have to further troubleshoot connectivity for AD, especially if no errors surfaced in Microsoft Entra Connect server or if you are still in the process of installing the product, start by using the [ADConnectivityTool](/azure/active-directory/hybrid/how-to-connect-adconnectivitytools#adconnectivitytool-during-installation).

Connection issues to ADDS have the following causes:

- Invalid AD credentials. For example, the ADCA has expired or the password has changed.
- A "failed-search" error, which occurs when DirSync Control doesn't communicate with the AD Replication Service, typically because of high-network packet fragmentation.
- A "no-start-ma" error, which occurs when there are name resolution issues (DNS) in AD.
- Other problems that can be caused by name resolution issues, network routing problems, blocked network ports, high network packet fragmentation, no writable DCs available, and so on. In such cases, you will likely have to involve the Directory Services or networking support teams to help troubleshoot.

Troubleshooting summary

- Identify which domain controller is used.
- Use preferred domain controllers to target the same domain controller.
- Correctly identify the ADCA.
- Use the ADConnectivityTool to identify the problem.
- Use the LDP tool to try to bind against the domain controller with the ADCA.
- Contact Directory Services or a networking support team to help you troubleshoot.

#### Run the Synchronization Troubleshooter

After you troubleshoot AD connectivity, run the [Troubleshoot Object Synchronization](/azure/active-directory/hybrid/tshoot-connect-objectsync) tool because this alone can detect the most obvious reasons for an object or attribute not to synchronize.

:::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/aadconnect-troubleshooting.png" alt-text="Screenshot of the Microsoft Entra Connect Troubleshooting screen.":::

### AD Permissions

A lack of AD permissions can affect both directions of the synchronization:

- When you import from ADDS to ADCS, a lack of permissions can cause AADC to skip objects or attributes so that AADC cannot get ADDS updates in the import stream. This error occurs because the ADCA does not have enough permissions to read the object.
- When you export from ADCS to ADDS, a lack of permissions generates a "permission-issue" export error.

To check permissions, open the **Properties** window of an AD object, select **Security** > **Advanced**, and then examine the object's allow/deny ACLs by selecting the **Disable Inheritance** button (if inheritance is enabled). You can sort the column contents by **Type** to locate all the "deny" permissions. AD permissions can vary widely. However, by default, you might only see one "Deny ACL" for "Exchange Trusted Subsystem." Most permissions will be marked as **Allow**.

The following default permissions are the most relevant:

- Authenticated Users

  :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/authenticated-users.png" alt-text="Screenshot shows the Authenticated users.":::

- Everyone

  :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/allow-everyone.png" alt-text="Screenshot shows the Allow option is set to Everyone.":::

- Custom ADCA or MSOL account

  :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/custom-adca-msol-account.png" alt-text="Screenshot shows the custom ADCA or MSOL account.":::

- Pre-Windows 2000 Compatible Access

  :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/pre-windows-2000-comp-access.png" alt-text="Screenshot shows the Pre-Windows 2000 Compatible Access.":::

- SELF

  :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/allow-self.png" alt-text="Screenshot shows the SELF permission is allowed.":::

The best way to troubleshoot permissions is to use the "Effective Access" feature in **AD Users and Computers** console. This feature checks the effective permissions for a given account (the ADCA) on the target object or attribute that you want to troubleshoot.

:::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/advanced-security-settings.png" alt-text="Screenshot shows information under the Effective Access tab in Advanced Security Settings window.":::

> [!important]
> Troubleshooting AD permissions can be tricky because a change in ACLs does not take immediate effect. Always consider that such changes are subject to AD replication.
>
> For example:

> - Make sure that you are making the necessary changes directly to the closest domain controller (see the "Connectivity with AD" section):
> - Wait for ADDS replications to occur.
> - If possible, restart ADSync service to clear the cache.

Troubleshooting summary

- Identify which domain controller is used.
- Use preferred domain controllers to target the same domain controller.
- Correctly identify the ADCA.
- Use the [Configure AD DS Connector Account Permissions](/azure/active-directory/hybrid/how-to-connect-configure-ad-ds-connector-account) tool.
- Use the "Effective Access" feature in AD Users and Computers.
- Use the LDP tool to bind against the domain controller that has the ADCA, and try to read the failing object or attribute.
- Temporarily add the ADCA to the Enterprise admins or Domain admins, and restart the ADSync service.

**Important:** Do not use this as a solution.

- After you verify the permissions issue, remove the ADCA from any highly privileged groups, and provide the required AD permissions directly to the ADCA.
- Engage Directory Services or a network support team to help you troubleshoot the situation.

#### AD replications

This issue is less likely to affect Microsoft Entra Connect because it causes greater problems. However, when Microsoft Entra Connect is importing data from a domain controller by using delayed replication, it will not import the latest information from AD, which causes sync issues in which an object or attribute that was recently created or changed in AD does not sync to Microsoft Entra ID because it was not replicated to the domain controller that Microsoft Entra Connect is contacting. To verify that this is the issue, check the domain controller that AADC uses for import (see "Connectivity to AD"), and use the **AD Users and Computers** console to directly connect to this server (see **Change Domain Controller** in the next image). Then, verify that the data on this server corresponds to the latest data, and whether it is consistent with the respective ADCS data. At this stage, AADC will generate a greater load on the domain controller and networking layer.

:::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/change-domain-controller.png" alt-text="Screenshot of the Change Domain Controller option of Active Directory.":::

Another approach is to use the RepAdmin tool to check the object's replication metadata on all domain controllers, get the value from all domain controllers, and check replication status between domain controllers:

- Attribute value from all domain controllers:

  `repadmin /showattr * "DC=contoso,DC=com" /subtree /filter:"sAMAccountName=User01" /attrs:pwdLastSet,UserPrincipalName`

  :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/repadmin-showattr.png" alt-text="Screenshot of the RepAdmin tool using showattr.":::

- Object metadata from all DCs:

  `repadmin /showobjmeta * "CN=username,DC=contoso,DC=com" > username-ObjMeta.txt`

  :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/repadmin-showobjmeta.png" alt-text="Screenshot of the RepAdmin tool with the showobjmeta command.":::

- AD Replication Summary

  `repadmin /replsummary`

  :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/repadmin-replsummary.png" alt-text="Screenshot of the RepAdmin tool using the replsummary command." border="false":::

Troubleshooting summary

- Identify which domain controller is used.
- Compare data between domain controllers.
- Analyze the RepAdmin results.
- Contact Directory Services or the network support team to help troubleshoot the issue.

#### Domain and OU changes, and object types or attributes filtered or excluded in ADDS Connector

- **Changing domain or OU filtering requires a full import**

  Keep in mind that even if the domain or OU filtering is confirmed, any changes to domain or OU filtering take effect only after running a full import step.

- **Attribute filtering with Microsoft Entra app and attribute filtering**

  An easy-to-miss scenario for attributes not synchronizing is when Microsoft Entra Connect is configured with the [Microsoft Entra app and attribute filtering](/azure/active-directory/hybrid/how-to-connect-install-custom#azure-ad-app-and-attribute-filtering) feature. To check whether the feature is enabled, and for which attributes, take a **General Diagnostics Report**.

- **Object type excluded in ADDS Connector configuration**

  This situation does not occur as commonly for users and groups. However, if all the objects of a specific object type are missing in ADCS, it might be useful to examine which object types enabled in ADDS Connector configuration.

  You can use the **Get-ADSyncConnector** cmdlet to retrieve the object types that are enabled on the Connector, as shown in the next image. The following are the object types that should be enabled by default:

  `(Get-ADSyncConnector | where Name -eq "Contoso.com").ObjectInclusionList`

  The following are the object types that should be enabled by default:

  :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/get-adsyncconnector-objects.png" alt-text="Screenshot show the Get-ADSyncConnector object types." border="false":::

  > [!NOTE]
  > The **publicFolder** object type is present only when the Mail Enabled Public Folder feature is enabled.

- **Attribute excluded in ADCS**

  In the same manner, if the attribute is missing for all objects, check whether the attribute is selected on the AD Connector.

  To check for enabled attributes in ADDS Connector, use the Synchronization Manager, as shown in the next image, or run the following PowerShell cmdlet:

  `(Get-ADSyncConnector | where Name -eq "Contoso.com").AttributeInclusionList`

  :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/ad-connector-sync-manager.png" alt-text="Screenshot of AD Connector Synchronization Manager.":::

  > [!NOTE]
  > Including or excluding object types or attributes in the Synchronization Service Manager is not supported.

Troubleshooting summary

- Check the [Microsoft Entra app and attribute filtering](/azure/active-directory/hybrid/how-to-connect-install-custom#azure-ad-app-and-attribute-filtering) feature
- Verify that the object type is included in ADCS.
- Verify that the attribute is included in ADCS.
- Run a full import.

#### Resources for Step 1

Main resources:

- Get-ADSyncConnectorAccount - Identify the correct Connector account used by AADC
- [ADConnectivityTool](/azure/active-directory/hybrid/how-to-connect-adconnectivitytools#adconnectivitytool-during-installation)

- Identify connectivity problems with ADDS
- Trace-ADSyncToolsADImport (ADSyncTools) - Trace data being imported from ADDS
- LDIFDE - Dump object from ADDS to compare data between ADDS and ADCS
- LDP - Test AD Bind connectivity and permissions to read object in the security context of ADCA
- DSACLS - Compare and evaluate ADDS permissions
- Set-ADSync< Feature >Permissions - Apply default AADC permissions in ADDS
- RepAdmin - Check AD object metadata and AD replication status

## Step 2: Synchronization between ADCS and MV

:::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/adcs-metaverse-flow-chart.png" alt-text="Screenshot shows the A D C S to MetaVerse flow chart.":::

### Objective for Step 2

This step checks whether the object or attribute flows from CS to MV (in other words, whether the object or attribute is projected to the MV). At this stage, make sure that the object is present, or that the attribute is correct in ADCS (covered in [Step 1](#step-1-synchronization-between-adds-and-adcs)), and then start looking at the synchronization rules and lineage of the object.

### Description for Step 2

The synchronization between ADCS and MV occurs on the delta/full synchronization step. At this point, AADC reads the staged data in ADCS, processes all sync rules, and updates the respective MV object. This MV object will contain CS links (or connectors) pointing to the CS objects that contribute to its properties and the lineage of sync rules that were applied in the synchronization step. During this stage, AADC generates more load on the SQL Server (or LocalDB) and networking layers.

### Troubleshooting ADCS > MV for objects

- **Check the inbound sync rules for provisioning**

  An object that is present in ADCS but missing in MV indicates that there were no scoping filters on any of the provisioning sync rules that applied to that object. Therefore, the object was not projected to MV. This issue might occur if there are disabled or customized sync rules.

  To get a list of inbound provisioning sync rules, run the following command:

  `Get-ADSyncRule | where {$_.Name -like "In From AD*" -and $_.LinkType -eq "Provision"} | select Name,Direction,LinkType,Precedence,Disabled | ft`

  :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/get-adsyncrule.png" alt-text="Screenshot shows the Get-ADSyncRule command is used to check inbound provisioning rules." border="false":::

- **Check the lineage of the ADCS object**

  You can retrieve the failing object from the ADCS by searching on "DN or Anchor" in "Search Connector Space." On the **Lineage** tab, you will probably see that the object is a **Disconnector** (no links to MV), and the lineage is empty. Also, check whether the object has any errors, in case there is a sync error tab.

  :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/connector-space-object-properties.png" alt-text="Screenshot of the Connector Space Object Properties in A D C S.":::

- **Run a preview on the ADCS object**

  Select **Preview** > **Generate Preview** > **Commit Preview** to see whether the object is projected to MV. If that's the case, then a full sync cycle should fix the issue for other objects in the same situation.

  :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/adcs-object-preview.png" alt-text="Screenshot of the A D C S object preview screen." border="false":::

  :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/adcs-source-object-details.png" alt-text="Screenshot of the Source Object Details screen in A D C S.":::

- **Export the object to XML**

  For a more detailed analysis (or for offline analysis), you can collect all the database data that's related to the object by using the **Export-ADSyncObject** cmdlet. This exported information will help determine which rule is filtering out the object. In other words, which Inbound Scoping Filter in the Provisioning Sync Rules is preventing the object from being projected to the MV.

  Here are some examples of **Export-ADsyncObject** syntax:

  - `Import-Module "C:\Program Files\Microsoft Azure Active Directory Connect\Tools\AdSyncTools.psm1"`
  - `Export-ADsyncObject -DistinguishedName 'CN=TestUser,OU=Sync,DC=Domain,DC=Contoso,DC=com' -ConnectorName 'Domain.Contoso.com'`
  - `Export-ADsyncObject -ObjectId '{46EBDE97-7220-E911-80CB-000D3A3614C0}' -Source Metaverse -Verbose`

#### Troubleshooting summary (objects)

- Check the scoping filters on the "In From AD" inbound provisioning rules.
- Create a preview of the object.
- Run a full sync cycle.
- Export the object data by using the **Export-ADSyncObject** script.

#### Troubleshooting ADCS > MV for attributes

1. **Identify the inbound sync rules and transformation rules of the attribute**

   Each attribute has its own set of transformations rules that are responsible for directing the value from ADCS to MV. The first step is to identify which sync rules contain the transformation rule for the attribute that you're troubleshooting.

   The best way to identify which sync rules have a transformation rule for a given attribute is to use the built-in filtering capabilities of the **Synchronization Rules Editor**.

   :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/sync-rules-editor.png" alt-text="Screenshot of Synchronization Rules Editor in A D C S.":::

2. **Check the Lineage of the ADCS Object**

   Each connector (or link) between the CS and MV will have a lineage that contains information about the sync rules that are applied to that CS object. The previous step will tell you which set of inbound sync rules (whether provisioning or joining sync rules) must be present in the object's lineage to flow the correct value from ADCS to MV. By examining the lineage on the ADCS object, you'll be able to determine whether that sync rule was applied to the object.

   :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/connector-space-object-properties-lineage.png" alt-text="Screenshot of the Connector Space Object Properties lineage screen.":::

   If there are multiple connectors (multiple AD forests) linked to the MV object, you might have to examine the **Metaverse Object Properties** to determine which connector is contributing the attribute value to the attribute that you're trying to troubleshoot. After you've identified the connector, examine the lineage of that ADCS object.

   :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/metaverse-object-properties.png" alt-text="Screenshot of the Metaverse Object Properties screen.":::

3. **Check the scoping filters on the inbound sync rule**

   If a sync rule is enabled but not present in the object's lineage, the object should be filtered out by the sync rule's scoping filter. By checking the sync rule's scoping filters, the data on the ADCS object, and whether the sync rule is enabled or disabled, you should be able to determine why that sync rule was not applied to the ADCS object.

   Here is an example of a common troublesome scoping filter from a sync rule responsible for synchronizing Exchange properties. If the object has a null value for **mailNickName**, then none of the Exchange attributes in the transformation rules will flow to Microsoft Entra ID.

   :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/inbound-sync-rules.png" alt-text="Screenshot of the View inbound synchronization rule screen.":::

4. **Run a preview on ADCS object**

   If you can't determine why the sync rule missing in the ADCS object's lineage, run a preview by using **Generate Preview** and **Commit Preview** for a full synchronization of the object. If the attribute is updated in the MV and has a preview, then a full sync cycle should fix the issue for other objects in the same situation.

5. **Export the object to XML**

   For a more detailed analysis or offline analysis, you can collect all the database data that's related to the object by using the **Export-ADSyncObject** script. This exported information can help you determine which sync rule or transformation rule missing on the object that's preventing the attribute from being projected to the MV (see the **Export-ADSyncObject** examples earlier in this article).

#### Troubleshooting summary (for attributes)

- Identify the correct sync rules and transformation rules responsible for flowing the attribute to the MV.
- Check the lineage of the object.
- Check whether sync rules have been enabled.
- Check the scoping filters of the sync rules that are missing in the object's lineage.

#### Advanced troubleshooting of the sync rule pipeline

If you have to further debug the ADSync engine (also known as the MiiServer) in terms of sync rule processing, you can enable ETW tracing on the .config file (C:\Program Files\Microsoft Azure AD Sync\Bin\miiserver.exe.config). This method generates an extensive verbose text file that shows all the processing of sync rules. However, it might be difficult to interpret all the information. Use this method as a last resort or if it's indicated by Microsoft Support.

#### Resources for Step 2

- Synchronization Service Manager UI
- Synchronization Rules Editor
- Export-ADsyncObject script
- Start-ADSyncSyncCycle -PolicyType Initial
- ETW tracing SyncRulesPipeline (miiserver.exe.config)

## Step 3: Synchronization between MV and AADCS

:::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/mv-aadcs-flow-chart.png" alt-text="Screenshot of the M V and A A D C S flow chart.":::

### Objective for Step 3

This step checks whether the object or attribute flows from MV to AADCS. At this point, make sure that the object is present, or that the attribute is correct in ADCS and MV (covered in Steps 1 and 2). Then, examine the synchronization rules and lineage of the object. This step is similar to [Step 2](#step-2-synchronization-between-adcs-and-mv), in which the inbound direction from ADCS to MV was examined, However, at this stage, we'll concentrate on the outbound sync rules and attribute that flows from MV to AADCS.

### Description for Step 3

The synchronization between MV and AADCS occurs in the delta/full synchronization step, when AADC reads the data in MV, processes all sync rules, and updates the respective AADCS object. This MV object will contain CS links (also known as connectors) that point to the CS objects that contribute to its properties and the lineage of the sync rules that were applied in the synchronization step. At this point, AADC generates more load on SQL Server (or localDB) and the networking layer.

#### Troubleshooting MV to AADCS for objects

1. **Check the outbound sync rules for provisioning**

   An object that is present in MV but missing in AADCS indicates that there were no scoping filters on any of the provisioning sync rules that applied to that object. For example, see the "Out to Microsoft Entra ID" sync rules shown in the next image. Therefore, the object was not provisioned in AADCS. This error can occur if there are disabled or customized sync rules.

   To get a list of inbound provisioning sync rules, run the following command:

   `Get-ADSyncRule | where {$_.Name -like "Out to AAD*" -and $_.LinkType -eq "Provision"} | select Name,Direction,LinkType,Precedence,Disabled | ft`

   :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/outbound-sync-rules.png" alt-text="Screenshot of Get-ADSyncRule used to check outbound sync rules." border="false":::

2. **Check the lineage of the ADCS object**

   To retrieve the failing object from the MV, use a **Metaverse Search**, and then examine the connectors tab. On this tab, you can determine whether the MV object is linked to an AADCS object. Also, check whether the object has any errors, in case a sync error tab is present.

   :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/metaverse-search.png" alt-text="Screenshot of the Metaverse Search screen.":::
  
   If no AADCS connector is present, the object is most likely set to **cloudFiltered=True**. You can verify whether the object is cloud-filtered by examining the MV attributes for which sync rule is contributing with the **cloudFiltered** value.

3. **Run a Preview on AADCS object**

   Select **Preview** > **Generate Preview** > **Commit a Preview** to determine whether the object connects to AADCS. If so, then a full sync cycle should fix the issue for other objects in the same situation.

4. **Export the object to XML**

   For a more detailed analysis or offline analysis, you can collect all the database data that's related to the object by using the **Export-ADSyncObject** script. This exported information, together with the (outbound) sync rules configuration, can help determine which rule is filtering out the object, and can determine which outbound scoping filter in the provisioning sync rules is preventing the object from connecting with the AADCS).

   Here are some examples of **Export-ADsyncObject** syntax:

   - `Import-Module "C:\Program Files\Microsoft Azure Active Directory Connect\Tools\AdSyncTools.psm1"`
   - `Export-ADsyncObject -ObjectId '{46EBDE97-7220-E911-80CB-000D3A3614C0}' -Source Metaverse -Verbose`
   - `Export-ADsyncObject -DistinguishedName 'CN={2B4B574735713744676B53504C39424D4C72785247513D3D}' -ConnectorName 'Contoso.onmicrosoft.com - AAD'`

#### Troubleshooting summary for objects

- Check the scoping filters on the "Out to Microsoft Entra ID" outbound provisioning rules.
- Create a preview of the object.
- Run a full sync cycle.
- Export the object data by using the **Export-ADSyncObject** script.

#### Troubleshooting MV to AADCS for attributes

1. **Identify the outbound sync rules and transformation rules of the attribute**

   Each attribute has its own set of transformation rules that are responsible to flow the value from MV to AADCS. Begin by identifying which sync rules contain the transformation rule for the attribute that you're troubleshooting.

   The best way to identify which sync rules have a transformation rule for a given attribute is to use the built-in filtering capabilities of the Synchronization Rules Editor.

   :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/view-manage-sync-rules.png" alt-text="Screenshot of the Synchronization Rules Editor.":::

2. **Check the lineage of the ADCS object**

   Each connector (or link) between the CS and MV will have a lineage that contains information about the sync rules applied to that CS object. The previous step will tell you which set of outbound sync rules (whether provisioning or joining sync rules) must be present in the object's lineage to flow the correct value from MV to AADCS. By examining the lineage on the AADCS object, you can determine whether that sync rule has been applied to the object.

   :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/connector-space-object-properties-run.png" alt-text="Screenshot shows the Lineage tab details on the A A D C S object.":::

3. **Check the scoping filters on the outbound sync rule**

   If a sync rule is enabled but not present in the object's lineage, it should be filtered out by the sync rule's scoping filter. By checking the presence of the sync rule's scoping filters, and the data on the MV object, and whether the sync rule is enabled or disabled, you should be able to determine why that sync rule wasn't applied to the AADCS object.

4. **Run a preview on AADCS object**

   If you determine why the sync rule is missing from the ADCS object's lineage, run a preview that uses **Generate Preview** and **Commit Preview** for a full synchronization of the object. If the attribute is updated in the MV by having a preview, then a full sync cycle should fix the issue for other objects in the same situation.

5. **Export the object to XML**

   For a more detailed analysis or offline analysis, you can collect all the database data that's related to the object by using the "Export-ADSyncObject" script. This exported information, together with the (outbound) sync rules configuration, can help you determine which sync rule or transformation rule is missing from the object that's preventing the attribute from flowing to AADCS (see the "Export-ADSyncObject" examples earlier).

#### Troubleshooting summary for attributes

- Identify the correct sync rules and transformation rules that are responsible to flow the attribute to AADCS.
- Check the lineage of the object.
- Check that the sync rules are enabled.
- Check the scoping filters of the sync rules that are missing in the object's lineage.

### Troubleshoot the sync rule pipeline

If you have to further debug the ADSync engine (also known as the MiiServer) in terms of sync rule processing, you can enable ETW tracing on the .config file (C:\Program Files\Microsoft Azure AD Sync\Bin\miiserver.exe.config). This method generates an extensive verbose text file that shows all the processing of sync rules. However, it might be difficult to interpret all the information. Use this method only as a last resort or if it's indicated by Microsoft Support.

### Resources

- Synchronization Service Manager UI
- Synchronization Rules Editor
- Export-ADsyncObject script
- Start-ADSyncSyncCycle -PolicyType Initial
- ETW tracing SyncRulesPipeline (miiserver.exe.config)

## Step 4: Synchronization between AADCS and AzureAD

:::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/sync-aadcs-azuread.png" alt-text="Screenshot of the Sync flow chart between A A D C S and Microsoft Entra ID.":::

### Objective for Step 4

This stage compares the AADCS object with the respective object that's provisioned in Microsoft Entra ID.

### Description for Step 4

Multiple components and processes that are involved in importing and exporting data to and from Microsoft Entra ID can cause the following issues:

- Connectivity to the internet
- Internal firewalls and ISP connectivity (for example, blocked network traffic)
- The Microsoft Entra Gateway in front of DirSync Webservice (also known as the AdminWebService endpoint)
- The DirSync Webservice API
- The Microsoft Entra Core directory service

Fortunately, the issues that affect these components usually generate an error in event logs that can be traced by Microsoft Support. Therefore, these issues are out of scope for this article. Nevertheless, there are still some "silent" issues that can be examined.

### Troubleshooting AADCS

- **Multiple Active AADC servers exporting to Microsoft Entra ID**

  In a common scenario in which objects in Microsoft Entra ID flip attribute values back and forth, there are more than one active Microsoft Entra Connect servers, and one of these servers loses contact with the local AD but is still connected to the internet and able to export data to Microsoft Entra ID. Therefore, every time that this "stale" server imports a change from Microsoft Entra ID on a synchronized object that's made by the other active server, the sync engine reverts that change based on the stale AD data that's in the ADCS. A typical symptom in this scenario is that you make a change in AD that's synced to Microsoft Entra ID, but the change reverts to the original value a few minutes later (up to 30 minutes). To quickly mitigate this issue, return to any old servers or virtual machines that have been decommissioned, and check whether the ADSync service is still running.

- **Mobile attribute with DirSyncOverrides**

  When the Admin uses MSOnline or AzureAD PowerShell module, or if the user goes to the Office Portal and updates the **Mobile** attribute, the updated phone number will be overwritten in AzureAD despite the object being synced from on-premises AD (also known as **DirSyncEnabled**).

  Together with this update, Microsoft Entra ID also sets a **DirSyncOverrides** on the object to flag that this user has the mobile phone number "overwritten" in Microsoft Entra ID. From this point on, any update to the mobile attribute that originates from on-premises will be ignored because this attribute will no longer be managed by on-premises AD.

  For more information about the BypassDirSyncOverrides feature and how to restore synchronization of Mobile and otherMobile attributes from Microsoft Entra ID to on-premises Active Directory, see [How to use the BypassDirSyncOverrides feature of a Microsoft Entra tenant](/azure/active-directory/hybrid/how-to-bypassdirsyncoverrides).

- **UserPrincipalName changes do not update in Microsoft Entra ID**

   If the **UserPrincipalName** attribute is not updated in Microsoft Entra ID, while other attributes sync as expected, it's possible that a feature that's named [SynchronizeUpnForManagedUsers](/azure/active-directory/hybrid/how-to-connect-syncservice-features#synchronize-userprincipalname-updates) is not enabled on the tenant. This scenario occurs frequently.

   Before this feature was added, any updates to the UPN that came from on-premises after the user was provisioned in Microsoft Entra ID and assigned a license were "silently" ignored. An admin would have to use MSOnline or Azure AD PowerShell to update the UPN directly in Microsoft Entra ID. After this feature is updated, any updates to UPN will flow to Microsoft Entra regardless of whether the user is licensed (managed).

   > [!NOTE]
   > After it's enabled, this feature cannot be disabled.

   **UserPrincipalName** updates will work if the user is NOT licensed. However, without the [SynchronizeUpnForManagedUsers](/azure/active-directory/hybrid/how-to-connect-syncservice-features#synchronize-userprincipalname-updates) feature, **UserPrincipalName** changes after the user is provisioned and is assigned a licensed that will NOT be updated in Microsoft Entra ID. Notice that Microsoft does not disable this feature on behalf of the customer.

- **Invalid characters and ProxyCalc internals**

   Issues that involve invalid characters that don't produce any sync error are more troublesome in **UserPrincipalName** and **ProxyAddresses** attributes because of the cascading effect in ProxyCalc processing that will **silently** discard the value synchronized from on-premises AD. This situation occurs as follows:

   1. The resulting **UserPrincipalName** in Microsoft Entra ID will be the **MailNickName** or **CommonName** @ (at) initial domain. For example, instead of John.Smith@Contoso.com, the **UserPrincipalName** in Microsoft Entra ID might become smithj@Contoso.onmicrosoft.com because there's an invisible character in the UPN value from on-premises AD.

   2. If a **ProxyAddress** contains a space character, **ProxyCalc** will discard it and autogenerate an email address based on **MailNickName** at Initial Domain. For example, "SMTP: John.Smith@Contoso.com" will not appear in Microsoft Entra ID because it contains a space character after the colon.

   3. Either a **UserPrincipalName** that includes a space character or a **ProxyAddress** that includes an invisible character will cause the same issue.

      To troubleshoot an invalid character in the **UserPrincipalName** or **ProxyAddress**, examine the value that's stored in the local AD from an LDIFDE or PowerShell exported to a file. An easy trick to detect an invisible character is to copy the contents of the exported file, and then paste it into a PowerShell window. The invisible character will be replaced by a question mark (?), as shown in the following example.

      :::image type="content" source="media/troubleshoot-aad-connect-objects-attributes/userprinciplename.png" alt-text="Screenshot shows an example to troubleshoot UserPrincipalName or ProxyAddress." border="false":::

- **ThumbnailPhoto attribute (KB4518417)**

    There is a general misconception that after you sync **ThumbnailPhoto** from AD for the first time, you can no longer update it, which is only partly true.

    Usually, the **ThumbnailPhoto** in Microsoft Entra ID is continually updated. However, an issue occurs if the updated picture is no longer retrieved from Microsoft Entra ID by the respective workload or partner (for example, EXO or SfBO). This issue causes the false impression that the picture was not synced from on-premises AD to Microsoft Entra ID.

    Basic steps to troubleshoot ThumbnailPhoto

   1. Make sure that the image is correctly stored in AD and doesn't exceed the size limit of 100 KB.

   2. Check the image in the Accounts Portal or use **Get-AzureADUserThumbnailPhoto** because these methods read the **ThumbnailPhoto** directly from Microsoft Entra ID.

   3. If the AD (or AzureAD) **thumbnailPhoto** has the correct image but is not correct on other online services, the following conditions might apply:

  - The user's mailbox contains an HD image and is not accepting low-resolution images from Microsoft Entra thumbnailPhoto. The solution is to directly update the user's mailbox image.
  - The user's mailbox image was updated correctly, but you're still seeing the original image. The solution is to wait at least six hours to see the updated image in the Office 365 User Portal or the Azure portal.

## Additional resources

- [Troubleshooting Errors during synchronization](/azure/active-directory/hybrid/tshoot-connect-sync-errors)
- [Troubleshoot object synchronization with Microsoft Entra Connect Sync](/azure/active-directory/hybrid/tshoot-connect-objectsync)
- [Troubleshoot an object that is not synchronizing with Microsoft Entra ID](/azure/active-directory/hybrid/tshoot-connect-object-not-syncing)
- [Microsoft Entra Connect Single Object Sync](/azure/active-directory/hybrid/how-to-connect-single-object-sync)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
