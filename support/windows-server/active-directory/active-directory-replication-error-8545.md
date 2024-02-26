---
title: Troubleshoot AD replication error 8545
description: Describes an issue that causes Active Directory replication to fail for one or more partitions and trigger error 8545. This issue occurs in Windows Server 2012 and earlier. A resolution is provided.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# Active Directory replication error 8545: "Replication update could not be applied"

This article provides a solution to an issue where Active Directory replication fails for one or more partitions with the error 8545.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3110029

> [!NOTE]
> **Home users:** This article is only intended for technical support agents and IT professionals. If you're looking for help with a problem, [ask the Microsoft Community](https://answers.microsoft.com/).

## Symptoms

In Windows Server 2012 and Windows Server 2008, Active Directory replication fails for one or more partitions and returns error 8545: "The replication update could not be applied because either the source or the destination has not yet received information regarding a recent cross-domain move operation."

Additionally, the following error is logged in the Directory Service log on the destination domain controller:

> Microsoft-Windows-ActiveDirectory_DomainService Event ID 1084Internal event: Active Directory Domain Services could not update the following object with changes received from the following source directory service. This is because an error occurred during the application of the changes to Active Directory Domain Services on the directory service.
>
> Object:
>
> CN=\<User>,OU=Users,OU=Boulder,DC=na,DC=contoso,DC=com  
Object GUID:  
33555323-8e42-42dd-ab95-51693b54281f
>
> Source directory service:  
1126750c-e8ac-4355-8412-ccb287e48c23._msdcs.contoso.com
>
> Synchronization of the directory service with the source directory service is blocked until this update problem is corrected.  
This operation will be tried again at the next scheduled replication.
>
> User Action  
Restart the local computer if this condition appears to be related to low system resources (for example, low physical or virtual memory).
>
> Additional Data  
Error value:  
8545 The replication update could not be applied because either the source or the destination has not yet received information regarding a recent cross-domain move operation.

> [!NOTE]
> For more information about how to apply the values that are referenced in event ID 1084, see the tables in the "More Information" section.

## Cause

This issue occurs if the object that's listed in event 1084 was migrated from one domain to another domain in the same forest. The destination domain controller doesn't learn of the object's new location (its partition). Therefore, the object is still present in the old partition on the destination domain controller.

The source domain controller knows of the object's migration and locates it in the object's new location.

Active Directory replication error 8545 is logged when the source domain controller tries to send changes for this recently migrated object when the destination domain controller finds the object present in a different partition.

## Resolution

As a preventive measure, consider installing Microsoft Knowledge Base article [2682997](https://support.microsoft.com/help/2682997) on all domain controllers that are still running Windows Server 2008 or Windows Server 2008 R2. To do this, follow these steps:

1. Determine the distinguished name (DN) of the naming context (NC) / partition where the object was migrated from. For more information about this, see the "More Information" section.
2. On the destination domain controller, follow these steps to unhost this partition:
    1. Run the following command line: Repadmin /unhost DestinationDC \<DNofObject'sOldLocation>

        For example, if the destination domain controller is DC1, and the DN for the partition where the object was migrated from is dc=corp,dc=contoso,dc=com, the command would be Repadmin /unhost DC1 dc=corp,dc=contoso,dc=com.

        > [!NOTE]
        > Monitor the Directory Service log on the domain controller for event ID 1660. Review the event text to make sure that it says the domain controller no longer hosts the CORP NC.
    2. Event ID 1659 indicates the status of the unhost operation. Do not readd the partition until after you successfully sync the other partition.
3. On the destination domain controller, trigger replication with the source domain controller (the one that was failing).
4. Rehost the partition from a domain controller that has a valid read/write copy of the partition. To do this, run the following command line:

    Repadmin /add DNobObject'sOldLocation DestinationDC GoodSourceDC /readonly

    For example, assume that the destination domain controller is DC1, the partition that you unhosted is dc=corp,dc=contoso,dc=com, and a domain controller that has a read/write copy of the Corp partition is `CorpDC1.corp.contoso.com`. In this situation, the command will be `Repadmin /add dc=corp,dc=contoso,dc=com dc1 CorpDC1.corp.contoso.com /readonly`.
    For more information about this specific scenario, see the "More Information" section.

## More information

The scenario that's described in the preceding sections can be confusing. Use the following table style to document all the points of data that you need to resolve this issue.

First, determine whether it's the source or destination domain controller that has a copy of the object in the old location (the location from where the object was migrated).

|Name|Details|
|---|---|
|Object DN|CN=JUSTINTU,OU=Users,OU=BOULDER,DC=na,DC=contoso,DC=com|
|ObjectGUID|33555323-8e42-42dd-ab95-51693b54281f|
|Parent Object DN|OU=Users,OU=BOULDER,DC=na,DC=contoso,DC=com|
|Old Source Domain (DN)|Which domain was the object in?<br/><br/>Dc=corp,dc=contoso,dc=com|
|Target domain (DN)|Which domain was the object migrated to?<br/><br/>Dc=na,dc=contoso,dc=com|
|Identify all DCs with object(s) (replication metadata)| Repadmin /showobjmeta *"<GUID=33555323-8e42-42dd-ab95-51693b54281f>" >JUSTINTUObjmeta.txt <br/><br/> Important: <br/><br/>For any DCs that you fail to obtain data from:<br/>1. Connect to each DC that you didn't obtain data from.<br/>2. Rerun the command, and substitute the DC name for the asterisk.<br/><br/>Example: repadmin /showobjmeta DC004 "<GUID=33555323-8e42-42dd-ab95-51693b54281f>" >LCTXDC004_JUSTINTUObjmeta.txt |
|Identify all DCs with object(s) (attribute values)| Repadmin /showattr *"<GUID=33555323-8e42-42dd-ab95-51693b54281f>" /gc >JUSTINTUattr.txt <br/><br/> Important: <br/><br/>For any DCs that you fail to obtain data from:<br/>1. Connect to each DC in question.<br/>2. Rerun the command, and substitute the DC name for the asterisk.<br/><br/>Example: repadmin /showobjattr LCTXDC004 "<GUID=33555323-8e42-42dd-ab95-51693b54281f>" /gc >LCTXDC004_JUSTINTUAttr.txt |
|Identify all DCs in forest| Repadmin /viewlist * >allDCs.txt |
|Identify the DSA_GUID for all DCs| Repadmin /showattr _DCNAME_ NCOBJ: Config: /filter:"(Objectclass=NTDSDSA)" /atts:objectGUID /subtree >ntdsa.txt <br/><br/>The preceding two commands.|
|DC in source domain without object in NA partition- name||
|DC in source domain without object in NA partition DSA_GUID||
|Replication status for forest| Repadmin /showrepl * /csv >showrepl.csv |
  
To identify the current location of the object in the database:

1. [Dump](https://support.microsoft.com/help/315098) the database of one of the destination DCs.
2. Open the database dump file, and then search for the objectGUID that's reported in event 1084.
3. Grab the DNT and PDNT, and [build the object hierarchy](https://blogs.technet.com/b/askpfeplat/archive/2012/07/23/mcm-core-active-directory-internals.aspx) by copying the pertinent values into a table, as follows:

| DNT| PDNT| RDN| ObjectGUID |
|---|---|---|---|
|61001|45020|Justintu|33555323-8e42-42dd-ab95-51693b54281f|
|45020|20005|LostAndFound||
|6931|1752|Corp||
|1751|20003|Contoso||
|1750|2|com||

By using the database dump file, you can see this object's current location in the database on this domain controller:

CN=LostAndFound,DC=Corp,DC=Contoso,DC=com

You can see that the object was present in the LostAndFound container on the `corp.contoso.com` NC. However, replication is blocked on this object except for the `NA.contoso.com` NC. Because this object is already present in the database (but in the old, incorrect NC), you must remove this partition from this domain controller in order to dispose of the old object.

Example scenario action plan

The Configuration object was migrated from the Corp partition to the NA partition. However, the NA partition fails to replicate from `NADC1.na.contoso.com` to `DC1.la.contoso.com`, and the attempt returns error 8545.

Destination DC: `DC1.la.contoso.com`

Source DC: `NADC1.na.contoso.com`

1. As a preventive measure, consider installing KB article [2682997](https://support.microsoft.com/help/2682997) on all domain controllers that are still running Windows Server 2008 or Windows Server 2008 R2. To do this, you will have to unhost the Corp partition on the domain controller, replicate the NA partition, and then readd the CORP partition from a known good source. To do this, follow these steps:
    1. Unhost the partition from the GC by running the following commands:

        Repadmin /options the DC +disable_ntdsconn_xlate

        Repadmin /unhost the DC dc=corp,dc=contoso,dc=com
    2. Monitor the Directory Service log on the domain controller for event ID 1660. Review the event text to verify that the domain controller no longer hosts the CORP NC.
2. Event ID 1659 indicates the status of the unhost operation. Do not readd the partition until after you sync the NA partition, as follows:
    1. Replicate the NA partition. After the partition is successfully removed from the database: Initiate replication from `CORPDC.na.contoso.com` by running the following command:

        ```console
    
        Repadmin /replicate the DC1.la.contoso.com NADC1.na.contoso.com DC=na,DC=bayer,DC=cnb
        ```

    2. Readd the CORP NC back to this domain controller by running the following repadmin /add commands:

        ```console
        Repadmin /add dc=corp,dc=contoso,dc=com DC1.la.contoso.com CorpDC1.corp.contoso.com /readonly 
        
        Repadmin /options the DC -disable_ntdsconn_xlate 
        ```

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
