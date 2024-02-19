---
title: How to create and apply a custom application directory partition on an Active Directory integrated DNS zone
description: Describes how to create a custom application directory partition by using the DnsCmd.exe command.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: rolandw, v-jomcc, kaushika
ms.custom: sap:dns, csstroubleshoot
---
# How to create and apply a custom application directory partition on an Active Directory integrated DNS zone

This article describes how to create a custom application directory partition by using the DnsCmd.exe command.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 884116

## Introduction

This article describes how to create and apply a custom application directory partition on an Active Directory directory service-integrated Domain Name System (DNS) zone.

You can create a custom Active Directory partition by using the DnsCmd command. The steps in this article create an example custom application directory partition that is named CustomDNSPartition. This application directory partition is located in the example domain `Contoso.com`. These steps configure the example application directory partition to be hosted on the following two example domain controllers:  

- `DC-1.contoso.com`
- `DC-2.contoso.com`

> [!NOTE]
> DnsCmd.exe is included in the Microsoft Windows Server 2003 Support Tools. To install the Windows Server 2003 Support Tools, double-click Suptools.msi in the Support\Tools folder on the Microsoft Windows Server 2003 CD.

### Create an application directory partition by using the DnsCmd command

Use the DnsCmd command to create an application directory partition. To do this, use the following syntax:

DnsCmd **ServerName** /CreateDirectoryPartition **FQDN of partition**  

To create an application directory partition that is named CustomDNSPartition on a domain controller that is named DC-1, follow these steps:

1. Click **Start**, click **Run**, type cmd, and then click **OK**.
2. Type the following command, and then press ENTER:

    ```console
    dnscmd DC-1 /createdirectorypartition CustomDNSPartition.contoso.com  
    ```

When the application directory partition has been successfully created, the following information appears:

> DNS Server DC-1 created directory partition: CustomDNSPartition.contoso.com Command completed successfully.

### Configure an additional domain controller DNS server to host the application directory partition

Configure an additional domain controller that is acting as a DNS server to host the new application directory partition that you created. To do this, use the following syntax with the DnsCmd command:

DnsCmd **ServerName** /EnlistDirectoryPartition **FQDN of partition**  

To configure the example domain controller that is named DC-2 to host this custom application directory partition, follow these steps:

1. Click **Start**, click **Run**, type cmd, and then click **OK**.
2. Type the following command, and then press ENTER:

    ```console
    dnscmd DC-2 /enlistdirectorypartition CustomDNSPartition.contoso.com  
    ```

The following information appears:

> DNS Server DC-2 enlisted directory partition: CustomDNSPartition.contoso.com Command completed successfully.

### Verify that the application directory partition was created successfully

Enumerate the directory partitions to verify that your application directory partition was created successfully. To do this, use the following syntax with the DnsCmd command:

DnsCmd /EnumDirectoryPartitions

To enumerate your directory partitions, follow these steps:

1. Click **Start**, click **Run**, type cmd, and then click **OK**.
2. Type the following command, and then press ENTER:  

    ```console
    dnscmd /enumdirectorypartitions  
    ```

    The following information appears:

    > Enumerated directory partition list:  
    >
    > Directory partition count = 3  
    >
    > CustomDNSPartition.contoso.comEnlisted  
     DomainDnsZones.contoso.comEnlisted Auto Domain  
     ForestDnsZones.contoso.comEnlisted Auto Forest  
    >
    > Command completed successfully.

3. Type the following command, and then press ENTER:

    ```console
    dnscmd DC-1 /directorypartitioninfo CustomDNSPartition.contoso.com /detail
    ```

    The following information is displayed to indicate that this application directory partition has a replica on DC-1 and on DC-2:

    > Directory partition info:  
     DNS root: CustomDNSPartition.contoso.com  
     Flags: 0x10 Enlisted  
     State: 0  
     Zone count: 0  
     DP head: DC=CustomDNSPartition,DC=contoso,DC=com  
     Crossref: CN=<44788e4b-4da1-494e-a6ed-24931c1c6268>,CN=Partitions,CN=Configuration,DC=contoso,DC=com  
     Replicas: 2  
     CN=NTDS Settings,CN=DC-2,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=contoso,DC=com  
     CN=NTDS Settings,CN=DC-1,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=contoso,DC=com  
    Command completed successfully.  
  
### Trigger the Knowledge Consistency Checker to create a connection object

Trigger the Knowledge Consistency Checker (KCC) two times to create a connection object between the domain controllers. This action creates the required replication link for the new application directory partition that you created. To do this use the Repadmin command together with the /kcc option.

> [!NOTE]
> You must have network connectivity between the domain controllers for this command to succeed. To trigger the KCC for DC-1, follow these steps:  
>
> 1. Click **Start**, click **Run**, type cmd , and then click **OK**.
> 2. Type the following command, and then press ENTER: `repadmin /kcc DC-1`.  

The following information appears:

> Consistency check on DC-1 successful.

### Verify Active Directory replication over the new replica link that you created

Verify Active Directory replication over the new replica link for the following naming context:DC=CustomDNSPartition,DC=contoso,DC=com

To do this, use the Repadmin command together with the /showrepl option. To do this, follow these steps:

1. Click **Start**, click **Run**, type cmd, and then click **OK**.
2. Type the following command, and then press ENTER:

    ```console
    repadmin /showrepl DC-1  
    ```

Information that is similar to the following appears:

> Default-First-Site-Name\DC-1
>
> \==== INBOUND NEIGHBORS ======================================  
> ...  
> DC=CustomDNSPartition,DC=contoso,DC=com  
 Default-First-Site-Name\DC-2 via RPC  
 DC object GUID: c2c38539-a5d0-4666-a133-8b1b58bc4b0c  
 Last attempt @ \<date> \<time> was successful.  

If the new naming context that you created doesn't appear in the Repadmin output, you can verify the state of this naming context by using the Ntdsutil command. To do this, follow these steps:

1. Click **Start**, click **Run**, type cmd, and then click **OK**.
2. Type ntdsutil, and then press ENTER.
3. Type do ma, and then press ENTER.
4. Type co, and then press ENTER.
5. Type connect to server DC-1, and then press ENTER. The following information appears:
    > Binding to DC-1 ...  
    >
    > Connected to DC-1 using credentials of locally logged on user.  
    >
    > server connections:  

6. Type q, and then press ENTER to return to the domain management prompt.
7. Type li nc rep dc=customdnspartition,dc-contoso,dc=com, and then press ENTER.

Information that is similar to the following may appear:

> The application directory partition dc=customdnspartition,dc=contoso,dc=com's Replicas are:  
CN=NTDS Settings,CN=DC-2,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=contoso,DC=com *  
CN=NTDS Settings,CN=DC-1,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=contoso,DC=com  
The \*'ed items are currently uninstantiated replicas.

This scenario may occur if the following conditions are true:

- The KCC configures a temporary naming context head until the next Active Directory directory service replication cycle occurs.

    > [!NOTE]
    > When this replication cycle occurs, the actual data is replicated.

- Active Directory directory service replication hasn't yet occurred.

This behavior occurs because of replication latency, especially if replication occurs between sites.

### Configure the replication scope of your DNS zones to that of the new application directory partition

Use the DNS management tool, Dnsmgmt.msc, to configure the replication scope of your Active Directory integrated DNS zones to that of the new application directory partition CustomDNSPartition. To do this, follow these steps:

1. On one of the domain controllers that hosts the new application directory partition that you created, start the DNS management tool. For example, on DC-1, click **Start**, click **Run**, type dnsmgmt.msc, and then click **OK**.
2. Under **DNS**, expand **DC-1**, expand **Forward Lookup Zones**, and then click your Active Directory integrated DNS zone.
3. On the **Action** menu, click **Properties**.
4. Click the **Change** button that corresponds to **Replication**.
5. Click **To all domain controllers specified in the scope of the following application directory partition**, click **CustomDNSPartition.contoso.com** in the **Application directory partition name** list, and then click **OK**.

    > [!NOTE]
    > This new application directory partition is also available when you create a new Active Directory integrated DNS zone.

6. Click **Apply**, and then click **OK**.  

After you configure the DNS zone replication scope to use this new custom application directory partition, other domain controllers that host this custom application directory partition automatically receive the new replication scope that you configured in step 5. To manually force this change, you can reload the DNS zone. To do this, right-click the DNS zone that you want to reload, and then click **Reload**.
