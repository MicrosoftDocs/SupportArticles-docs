---
title: Troubleshoot AD replication error 1396
description: Provides help to troubleshoot Active Directory replication error 1396.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, Justinha
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# Active Directory replication error 1396: Logon Failure: The target account name is incorrect

This article describes the symptoms, cause, and resolution for resolving Active Directory replication failing with Win32 error 1396.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2183411

## Symptoms

This article describes the symptoms, cause, and resolution for resolving Active Directory replication failing with Win32 error 1396:

> Logon failure: The target account name is incorrect.

1. DCDIAG reports that the Active Directory Replications has failed with error 1396:

    > Logon failure: The target account name is incorrect.

    > Testing server: \<Site name>\<DC Name>  
          Starting test: Replications  
             [Replications Check,\<DC Name>] A recent replication attempt failed:  
                From \<source DC> to \<destination DC>  
                Naming Context: CN=\<DN path of naming context>  
                The replication generated an error (1396):  
                Logon Failure: The target account name is incorrect.  
                The failure occurred at \<date> \<time>.  
                The last success occurred at \<date> \<time>.  
                XX failures have occurred since the last success

2. REPADMIN.EXE reports that replication attempt has failed with status 1396.

    REPADMIN commands that commonly cite the 1396 status include but are not limited to:

    - `REPADMIN /ADD`
    - `REPADMIN /REPLSUM*`
    - `REPADMIN /REHOST`
    - `REPADMIN /SHOWVECTOR /LATENCY`
    - `REPADMIN /SHOWREPS`
    - `REPADMIN /SHOWREPL`
    - `REPADMIN /SYNCALL`

    Sample output from `REPADMIN /SHOWREPS` depicting inbound replication from CONTOSO-DC2 to CONTOSO-DC1 failing with the **Logon Failure: The target account name is incorrect** error is shown below:

    > Default-First-Site-Name\CONTOSO-DC1  
    DSA Options: IS_GC  
    Site Options: (none)  
    DSA object GUID: \<GUID>  
    DSA invocationID: \<invocationID>  
    >
    > ==== INBOUND NEIGHBORS ======================================  
    >
    > DC=contoso,DC=com  
    Default-First-Site-Name\CONTOSO-DC2 via RPC  
    DSA object GUID: \<GUID>  
    Last attempt @ \<date> \<time> failed, result 1396 (0x574):  
     Logon Failure: The target account name is incorrect.  
    <#> consecutive failure(s).  
    Last success @ \<date> \<time>.

3. The **replicate now** command in Active Directory Sites and Services returns **Logon Failure: The target account name is incorrect**.

    Right-clicking on the connection object from a source DC and choosing **replicate now** fails with **Logon Failure: The target account name is incorrect**. The on-screen error message is shown below:

    Dialog title text: Replicate Now

    Dialog message text: The following error occurred during the attempt to synchronize naming context \<partition DNS path> from domain controller \<source DC> to domain controller \<destination DC>:

    Logon Failure: The target account name is incorrect.  
    This operation will not continue.

    Buttons in Dialog: OK

4. NTDS KCC, NTDS General or Microsoft-Windows-ActiveDirectory_DomainService events with the 1396 status are logged in the directory service event log.

    Active Directory events that commonly cite the 1396 status include but are not limited to:

    |Event Source|Event ID|Event String|
    |---|---|---|
    |Microsoft-Windows-ActiveDirectory_DomainService|1125|The Active Directory Domain Services Installation Wizard (Dcpromo) was unable to establish connection with the following domain controller.|
    |NTDS Replication (This event lists the 3-part SPN)|1645|Active Directory did not perform an authenticated remote procedure call (RPC) to another domain controller because the desired service principal name (SPN) for the destination domain controller is not registered on the Key Distribution Center (KDC) domain controller that resolves the SPN.|
    |Microsoft-Windows-ActiveDirectory_DomainService|1655|Active Directory Domain Services attempted to communicate with the following global catalog and the attempts were unsuccessful. |
    |Microsoft-Windows-ActiveDirectory_DomainService|2847|The Knowledge Consistency Checker located a replication connection for the local read-only directory service and attempted to update it remotely on the following directory service instance.  The operation failed.  It will be retried.|
    |NTDS KCC|1925|The attempt to establish a replication link for the following writable directory partition failed.|
    |NTDS KCC|1926|The attempt to establish a replication link to a read-only directory partition with the following parameters failed.|
    |NETLOGON|5781|Server cannot register its name in DNS|

5. Dcpromo fails with an onscreen error:

    > Active Directory Installation Failed
    >
    > The operation failed because:  
    The Directory Service failed to create the server object for CN=NTDS Settings,CN=ServerBeingPromoted,CN=Servers,CN=Site,CN=Sites,CN=Configuration,DC=contoso,DC=com on server ReplicationSourceDC.contoso.com. Please ensure
    the network credentials provided have sufficient access to add a replica.  
    "Logon Failure: The target account name is incorrect."
    >
    > OK  

    In this case, Event ID 1645, 1168, and 1125 are logged on the server that is being promoted.

6. Map a drive using `net use`

    ```console
    C:\>net use z: \\<server_name>\c$
    ```

    > System error 1396 has occurred.  
    Logon Failure: The target account name is incorrect.

    In this case, the server was also logging Event ID 333 in the system event log and using SQL Server was using a high amount of virtual memory.

7. The DC time is incorrect.

8. The KDC will not start on an RODC after a restore of the krbtgt account for the RODC, which had been deleted. After the restore using third-party restore tools, error 1396 appears.

    > Event ID 1645 is logged on the RODC.  
    Dcdiag also reports an error that it cannot update the RODC krbtgt account.

## Cause

Multiple root causes exist. Known root causes include:

1. The SPN does not exist on the global catalog searched by the KDC on behalf of the client attempting to authenticate using Kerberos.

    In the context of Active Directory replication, the Kerberos client is the destination DC, the KDC performing the SPN lookup is likely the destination DC itself but could be a remote DC.

2. The user or service account that should contain the service principal name being looked up does not exist on the global catalog searched by the KDC on behalf of destination DC attempting to replicate.

    In the context of Active Directory replication, the source DC computer account does not exist on the global catalog searched by the DC on behalf of the destination DC performing inbound replication.

3. The destination DC lacks an LSA secret for the source DCs domain.

4. The SPN being looked up exists on a different computer account than the source DC.
5. For issues where replication is failing to an RODC, the RODC-specific KRBTGT account may have been deleted.

## Resolution

1. Check the Directory Service event log on the destination DC for NTDS Replication event 1645 and note the following:

    > The name of the destination DC  
    The SPN being looked up (E3514235-4B06-11D1-AB04-00C04FC2DCD2/\<object guid for source DCs NTDS Settings object>/\<target domain>.\<tld>@\<target domain>.\<tld>  
    The KDC being used by the destination DC

2. From the console of the KDC identified in step 1, type `nltest /dsgetdc:<forest root DNS domain name > /gc`.

    Run the NLTEST locator test immediately following a replication attempt that fails with the 1396 error on the destination DC.

    This should identify that GC that the KDC is performing SPN lookups against.

    The GC being searched by the KDC may also be captued in Microsoft-Windows-ActiveDirectory_DomainService event 1655.

3. Search for the SPN discovered in step 1 on the the global catalog discovered in step 2.

    ```console
    C:\>repadmin /showattrServer_NameDC=corp,DC=contoso,dc=com <GC used by KDC> <DN path of forest root domain> /filter:"(serviceprincipalname=<SPN cited in the NTDS Replication event 1645>)" /gc /subtree /atts:cn,serviceprincipalname
    ```

    Or

    ```console
    C:\>dsquery * forestroot -scope subtree -filter "(serviceprincipalname=E3514235-4B06-11D1-AB04-00C04FC2DCD2/65cead9f-4949-46a3-a49a-f1fbfe13d2b3*)" -attr * -sServer_Name.europe.corp.microsoft.com
    ```

    Verify that the host object for the SPN exists.

    Verify the DN path for the host object including whether the object is CNF/conflict mangled or resides in the lost and found container.

    Verify that the source DCs AD Replication SPN is registered only on the source DCs computer account.

    If the replication SPN is missing, determine if the source DC has registered its SPN with itself,  and whether the SPN is missing on the GC used by the KDC due to simple replication latency or a replication failure

4. Check the secure channel health and trust health.

This table lists other symptoms, causes, and resolutions:

|Symptom|Cause|Resolution|
|---|---|---|
|The DC is not functioning and logs Event ID 1925 and 1411 on Windows Server 2008 domain controllers and Windows Server 2003 domain controllers in the same domain that have been authoritatively restored.|These problems occur because the version number of the KRBTGT account increases when you perform an authoritative restoration. The KRBTGT account is a service account that is used by the Kerberos Key Distribution Center (KDC) service.|In this case, you might need to apply the hotfix in KB939820.|
|Map a drive using net use<br/>C:\Documents and Settings\wschong>net use z: \\<server_name>\c$ System error 1396 has occurred.<br/>Logon Failure: The target account name is incorrect.<br/>In this case, the server was logging Event ID 333 and using high memory, with SQL Server using highest.|If the error appears while mapping a drive using net use, the cause could be that the Non Paged Memory or the Paged Pool Memory is temporarily insufficient. The system keeps recording such events until the computer is restarted, or the related hive is unloaded, even though the temporary memory insufficiency stops. For more information about SQL Server performance problems, see [Troubleshooting Performance Problems in SQL Server 2005](/previous-versions/sql/sql-server-2005/administrator/cc966540(v=technet.10)).|To prevent the system logging the event 333 continually in future, please apply the hotfix 970054 on the server and set the following registry value to 1:<ul><li>Location: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager`</li><li>Name: RegistryFlushErrorSubside</li><li>Type: REG_DWORD</li><li>Value: 1 or 2</li></ul>|
|The DC time is incorrect.|The DC is a virtual machine that was set to sync time with the VMware host, caused events 1925, 1645.|unchecked the option to sync time for virtual DC from VMWare host, so that it can sync time with the PDC.|
|Dcpromo fails with an onscreen error: Active Directory Installation Failed. The operation failed because:<br/>The Directory Service failed to create the server object for CN=NTDS Settings,CN=ServerBeingPromoted, CN=Servers,CN=Site, CN=Sites,CN=Configuration,DC=contoso, DC=com on server ReplicationSourceDC.contoso.com. Ensure the network credentials provided have sufficient access to add a replica.<br/>Logon Failure: The target account name is incorrect.<br/><br/>In this case, Event ID 1645, 1168, and 1125 are logged on the server that is being promoted.|During dcpromo, the SPN on the helper DC (the replication source DC) is not valid.|For dcpromo error where helper DC SPN is not valid, use SetSPN to create new SPN on helper DC, in format GC/serverName.contoso.com|
  
## More information

Other causes include:

1. Event ID 1925 can occur on Windows Server 2008 domain controllers and Windows Server 2003 domain controllers in the same domain that have been authoritatively restored. In this case, you might need to apply the hotfix 939820.

2. During dcpromo, the SPN on the helper DC (the replication source DC) is not valid.

3. If the error appears while mapping a drive using net use, the cause could be that the Non Paged Memory or the Paged Pool Memory is temporarily insufficient. The system keeps recording such events until the computer is restarted, or the related hive is unloaded, even though the temporary memory insufficiency stops. For more information about SQL Server performance problems, see [Troubleshooting Performance Problems in SQL Server 2005](/previous-versions/sql/sql-server-2005/administrator/cc966540(v=technet.10)).

4. The DC is a virtual machine that was set to sync time with the VMware host, caused events 1925, 1645.

5. For the RODC specific scenario where the KRBTGT account is deleted: authoritatively restore the KRBTGT_##### account using NTDSUTIL and then import the LDIFDE file to correct backlinks.  At minimum, the msDS-KrbTgtLink attribute on the RODC's computer object will need to be updated to point to the DN of the restored account.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
