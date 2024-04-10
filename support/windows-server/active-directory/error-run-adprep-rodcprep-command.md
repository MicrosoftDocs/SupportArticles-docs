---
title: Error when running the Adprep /rodcprep command in Windows Server 2008
description: The Adprep /rodcprep command isn't completed successfully. The reason is that the infrastructure master for one or more active directory Non-Domain Naming Contexts (NDNCs) isn't reachable. A resolution is provided.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Active Directory\Domain or forest functional level updates, failures and Advisory, csstroubleshoot
---
# Error when you run the `Adprep /rodcprep` command in Windows Server 2008: Adprep could not contact a replica for partition DC=DomainDnsZones,DC=Contoso,DC=com

This article solves a problem that the `Adprep /rodcprep` command isn't completed successfully because the infrastructure master for one or more active directory NDNCs isn't reachable.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 949257

## Symptoms

When you run the `Adprep /rodcprep` command on Windows Server 2008, you receive the following error message:

> Adprep could not contact a replica for partition DC=DomainDnsZones,DC=Contoso,DC=com
>
> Adprep failed the operation on partition DC=DomainDnsZones,DC=Contoso,DC=com Skipping to next partition.
>
> Adprep could not contact a replica for partition DC=ForestDnsZones,DC=Contoso,DC=com
>
> Adprep encountered an LDAP error. Error code: 0x0. Server extended error code: 0x0, Server error message: (null).
>
> Adprep failed the operation on partition DC=ForestDnsZones,DC=Contoso,DC=com Skipping to next partition.
>
> Adprep completed with errors. Not all partitions are updated.

## Cause

This problem occurs when the `Adprep /rodcprep` command tries to contact the infrastructure master for each application partition in the forest. The command does it to set the permissions that are required for Read-Only Domain Controller (RODC) replication. The `Adprep /rodcprep` command fails if one of the following conditions is true:

- The partition or the partitions that are referenced in the error message no longer exist.
- The infrastructure master for the referenced partition or partitions has been forcefully demoted or is offline.

## Resolution

To resolve this problem if the partition no longer exists, do a metadata cleanup for the orphaned partition using the "remove nc" parameter of the Dsmgmt tool. For more information, visit the following Microsoft Web site:

[partition management](https://technet.microsoft.com/library/cc730970%28ws.10%29.aspx)

If the specified partition exists, specify an infrastructure role owner that is online for the partition. You can do it by manually modifying the **fSMORoleOwner** attribute on the object, as described in the "More information" section.

## More information

The following script sample modifies the **fSMORoleOwner** attribute on the infrastructure object of the specified Non-Domain Naming Context (NDNC) to an active, or contactable, server. The NDNC in this sample is the **DomainDnsZones,DC=contoso,DC=com NDNC** naming context. The script uses the following command:

```vb
cscript fixfsmo.vbs DC=DomainDnsZones,DC=contoso,DC=com
```

```vb
'-------fixfsmo.vbs------------------
const ADS_NAME_INITTYPE_GC = 3
const ADS_NAME_TYPE_1779 = 1
const ADS_NAME_TYPE_CANONICAL = 2

set inArgs = WScript.Arguments

if (inArgs.Count = 1) then
    ' Assume the command line argument is the NDNC (in DN form) to use.
    NdncDN = inArgs(0)
Else
    Wscript.StdOut.Write "usage: cscript fixfsmo.vbs NdncDN"
End if

if (NdncDN <> "") then

    ' Convert the DN form of the NDNC into DNS dotted form.
    Set objTranslator = CreateObject("NameTranslate")
    objTranslator.Init ADS_NAME_INITTYPE_GC, ""
    objTranslator.Set ADS_NAME_TYPE_1779, NdncDN
    strDomainDNS = objTranslator.Get(ADS_NAME_TYPE_CANONICAL)
    strDomainDNS = Left(strDomainDNS, len(strDomainDNS)-1)

    Wscript.Echo "DNS name: " & strDomainDNS

    ' Find a domain controller that hosts this NDNC and that is online.
    set objRootDSE = GetObject("LDAP://" & strDomainDNS & "/RootDSE")
    strDnsHostName = objRootDSE.Get("dnsHostName")
    strDsServiceName = objRootDSE.Get("dsServiceName")
    Wscript.Echo "Using DC " & strDnsHostName

    ' Get the current infrastructure fsmo.
    strInfraDN = "CN=Infrastructure," & NdncDN
    set objInfra = GetObject("LDAP://" & strInfraDN)
    Wscript.Echo "infra fsmo is " & objInfra.fsmoroleowner

    ' If the current fsmo holder is deleted, set the fsmo holder to this domain controller.

    if (InStr(objInfra.fsmoroleowner, "\0ADEL:") > 0) then

        ' Set the fsmo holder to this domain controller.
        objInfra.Put "fSMORoleOwner",  strDsServiceName
        objInfra.SetInfo

        ' Read the fsmo holder back.
        set objInfra = GetObject("LDAP://" & strInfraDN)
        Wscript.Echo "infra fsmo changed to:" & objInfra.fsmoroleowner

    End if

End if
```

To determine the infrastructure master for a partition, query the **fSMORoleOwner** attribute on the infrastructure object under the naming context root in question. For example, query the **fSMORoleOwner** attribute on the **CN=Infrastructure,DC=DomainDnsZones,DC=contoso,DC=com** naming context root to determine the infrastructure master for the **DC=DomainDnsZones,DC=contoso,DC=com** partition. Similarly, query the **fSMORoleOwner** attribute on the **CN=Infrastructure,DC=ForestDnsZones,DC=contoso,DC=com** naming context root to determine the infrastructure master for the D**C=ForestDnsZones,DC=contoso,DC=com** partition.

You can use tools such as the LDP tool, the Active Directory Service Interfaces (ADSI) Edit tool, and the ldifde tool to do these queries. For example, the following query uses the Idifde tool:

ldifde -f Infra_DomainDNSZones.ldf -d "CN=Infrastructure,DC=DomainDnsZones,DC=contoso,DC=com" -l fSMORoleOwner

This query returns the infrastructure master role owner for the **DC=DomainDnsZones,DC=contoso,DC=com** partition to the Infra_DomainDNSZones.ldf file.

> [!NOTE]
> You can run the `Adprep /rodcprep` command multiple times without harming the forest. Operations that were completed in earlier executions of the rodcprep command aren't repeated.

If you try to run the `rodcprep` command in an isolated environment, the infrastructure master for each domain and for each application directory partition must be available within the environment for the operation to succeed.
