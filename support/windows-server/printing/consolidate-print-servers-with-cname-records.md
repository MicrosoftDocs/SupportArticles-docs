---
title: Consolidate print servers by using CNAME records
description: Describes how to consolidate print servers in Windows Server 2003 with minimal effect on clients by using DNS Alias (CNAME) records. You can use this method if clients use DNS as a name resolution method.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:management-and-configuration:-general-issues, csstroubleshoot
---
# Consolidate print servers by using DNS alias (CNAME) records

This article describes how to consolidate print servers that run in a Microsoft Windows Server 2003 environment.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 870911

## Introduction

When you consolidate print servers in an organization, one of the primary hurdles is how to accomplish the consolidation with a minimal effect on the connected clients.

If clients use a Domain Name System (DNS) name resolution method to connect to the print server, you can use DNS alias (CNAME) records to consolidate print servers. When you use this method, you do not have to remap printer shares on each client. To use this method, you must create DNS alias records for the print servers that you remove during the consolidation. When you create the alias records, you must specify as the target host the print server that you want to consolidate the print queues to.

> [!Note]
>
> - To use alias records for print server consolidation in a Windows 2000 Server environment, your Windows 2000-based servers must be running on either:  
> - Windows 2000 Service Pack 4 or later versions.
>
> - To use CNAME records, you may have to modify the DisableStrictNameChecking registry entry.  

## More information

To permit clients to continue to resolve the names of the print servers that you want to remove during the consolidation, follow these steps:  

1. Back up all print queues and print shares from the servers that you want to consolidate, and then restore the print queues and print shares to the server that will handle the merged printing load. To do this, you can use a utility such as Microsoft Print Migrator.  

2. Take the print servers that you want to remove offline, remove their associated resource records from DNS, and remove their associated accounts in the Active Directory.
3. Create an alias (CNAME) record for each print server that you remove during the consolidation. When you create an alias record, you must specify the target host. Select as the target host the server that you restored the print queues to in step 1. To do this, follow these steps:

### Selecting a target host in Windows Server 2003

1. Click **Start**, point to **Administrative Tools**, and then click **DNS**.
2. Expand **Servername**, and then expand **Forward Lookup Zones**.

    > [!NOTE]
    > **Servername** is the name of your server.

3. Right-click the appropriate zone, and then click **New Alias (CNAME)**.

4. In the **Alias name (uses parent domain if left blank)** box, type the alias name. The alias name must match the name of the print server that you removed.
5. In the **Fully qualified domain name (FQDN) for target host** box, type the fully qualified domain name of the print server that you want to consolidate the print queues to. Alternatively, you can click **Browse** to locate the target host.
6. Click **OK**.

### Selecting a target host in Windows 2000 Server

1. Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **DNS**.
2. Expand ****Servername****, and then expand **Forward Lookup Zones**.
3. Right-click the appropriate zone, and then click **New Alias**.
4. In the **Alias name (uses parent domain if left blank)** box, type the alias name. The alias name must match the name of the print server that you removed.
5. In the **Fully qualified domain name for target host** box, type the fully qualified domain name of the print server that you want to consolidate the print queues to. Alternatively, you can click **Browse** to locate the target host.
6. Click **OK**. After you consolidate the print servers, network traffic increases slightly. The increased traffic occurs because the clients must establish and validate their settings with the new print server. The amount of increased traffic depends on the number of clients in your environment and the number of settings that must be passed during the negotiation. If a different version of the driver is installed on the print server than is installed on the client, the traffic may also include driver downloads.

To predict the network load, the recommended method is to trace the network traffic for representative clients in your environment. This method helps you better evaluate whether the increased load will be a problem.

### Additional things to consider before you use this solution

- The solution in the More Information section works only if clients use DNS or another name resolution method that incorporates DNS when they connect to the print server. Clients cannot take advantage of this solution if they:
  - Are connected directly by Internet Protocol (IP) to the print servers.
  - Use only network basic input/output system (NetBIOS).
  - Use Windows Internet Name Service (WINS) but do not use WINS reverse lookup.
- If some clients use WINS, permit those clients to correctly resolve the print server names. To do this, remove from the WINS database the names of the print servers that were removed during consolidation.
- The particular node type that you use for name resolution can also affect the outcome of this solution. You must use a node type that uses DNS for name resolution. We recommend the hybrid node type (h-node).  

### Register the Kerberos service principal names (SPNs)

You must register the Kerberos service principal names (SPNs), the host name, and the fully qualified domain name (FQDN) for all the new DNS alias (CNAME) records. If you do not do this, a Kerberos ticket request for a DNS alias (CNAME) record may fail and return the `KDC_ERR_S_SPRINCIPAL_UNKNOWN` error code.

To view the Kerberos SPNs for the new DNS alias records, use the `Setspn` command-line tool (Setspn.exe). To do this, type the following command at the command prompt:

```console
setspn -L computername
```

To register the SPN for the DNS alias (CNAME) records, use the `Setspn` tool with the following syntax:

```console
setspn -A host/ your_ALIAS_name computername
```

```console
setspn -A host/ your_ALIAS_name.company.com computername
```

> [!NOTE]
> The Setspn tool is included in Windows Server 2003 Support Tools. You can install Windows Server 2003 Support Tools from the `Support\Tools` folder of the Windows Server 2003 startup disk. To download and install the latest version of the Setspn tool, visit the following Web site: [Setspn](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc731241(v=ws.11))  

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
