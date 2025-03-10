---
title: Duplicate Active Directory replication connections are created
description: Provides a solution to an issue where duplicate Active Directory replication connections are created for one or more domain controllers across one or more sites.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:active directory\active directory replication and topology
- pcy:WinComm Directory Services
---
# Duplicate Active Directory replication connections are created

This article provides a solution to an issue where duplicate Active Directory replication connections are created for one or more domain controllers across one or more sites.

_Original KB number:_ &nbsp; 3207569

## Symptoms

In Active Directory Sites and Services, duplicate Active Directory replication connections are created for one or more domain controllers across one or more sites.

## Cause

This issue is caused by either a lack of network connectivity or by another problem that disrupts replication on the Intersite Topology Generator (ISTG) in the site. If the ISTG can't reach other domain controllers, it tries to create new (duplicate) Active Directory replication connections for domain controllers in the same site.

> [!NOTE]
> If this is a transient condition, nothing will clean up the duplicate connection objects. If the connectivity and replication problem is no longer occurring on the ISTG, you must manually delete the duplicate connection objects and then rerun `repadmin /kcc` against the ISTG to make sure that the duplicates are not re-created.

### Data collection

To collect the relevant data for this issue, follow these steps.

> [!NOTE]
>
> - `Repadmin /kcc <DCNAME>` is the command to force KCC to run. However it won't create a new connection if the other one is still in place.
> - `Replace <DCNAME>` with the name of the domain controller that serves as the ISTG for the site.

1. Run `repadmin /showconn <DCNAME> >showconn.txt`.
2. Run `repadmin /failcache <DCNAME> >failcache.txt`.
3. Run [PortQRYUI ](https://download.microsoft.com/download/3/f/4/3f4c6a54-65f0-4164-bdec-a3411ba24d3a/PortQryUI.exe)on \<DCNAME\>, and target a remote domain controller that you have duplicate connections with, as follows:  
"Domains and Trusts test" File / Save Result
4. On \<DCNAME>, run `repadmin /bind RemoteDC` (from step 3). For example: `repadmin /bind RemoteDC1`
5. If `repadmin /bind` fails to connect, take a network trace by using netsh on both domain controllers, as follows:
      1. Run `netsh trace start capture=yes tracefile=c:\%computername%.etl`.
        1. Run `repadmin /bind <DCNAME>`.
        2. Connect by using the FQDN instead of the host name, if possible.
      2. Run `netsh trace stop`.
6. Run `repadmin /showrepl * /csv >showrepl.csv` or `repadmin /showrepl * /csv | convertfrom-csv | out-gridview` from elevated PowerShell windows to send the output to an interactive table in a separate window.

7. Run `repadmin /viewlist * >DCs.txt`.
8. Run `repadmin /istg >istg.txt`.

## Resolution

To resolve this issue, open ports in the site to allow the ISTG to connect to the domain controllers. After the connectivity issue is resolved, delete the duplicate connection objects, and then rerun KCC on the ISTG.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).

## More information

For more information about this issue, see [How Active Directory replication topology works](/previous-versions/windows/it-pro/windows-server-2003/cc755994(v=ws.10)). Particularly focus on the [KCC and topology generation](/previous-versions/windows/it-pro/windows-server-2003/cc755994(v=ws.10)#kcc-and-topology-generation) section and the "Excluded nonresponding servers" subtopic.
