---
title: Guidelines of troubleshooting DirectAccess issues
description: Introduces general guide troubleshoot scenarios related to DirectAccess.
ms.date: 03/03/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:directaccess, csstroubleshoot
ms.technology: networking
---
# DirectAccess issues troubleshooting guidelines

This guide provides troubleshooting information for DirectAccess in the Windows operating systems. It's designed to help you identify and resolve problems that are related to DirectAccess.

## Troubleshooting checklist

### Up-to-date

Keep DirectAccess servers and DirectAccess client devices updated. You have to regularly update Windows, drivers, firmware, Hyper-V Integrations Components, and VMware tools. If applicable, you would also have to update the hypervisor that's running the virtual machines.

### OS version

Use a current operating system version: at least Windows Server 2016 or Windows Server 2019 for the DirectAccess Servers. DirectAccess clients should run a recent version of Windows 10.

### Monitor

Use monitoring for the DirectAccess servers. Monitor at least the following metrics:

- CPU usage
- Memory usage
- Disk performance
- Free disk space
- Network adapter availability
- Network adapter throughput and NetNat ports.  

Also, keep a history of performance reporting. The reporting can be helpful when you troubleshoot performance-related issues.

### Infrastructure components

DirectAccess relies on perimeter or internal firewalls, load balancers, routers, switches, and so on. These should also be monitored. For example, if a load balancer is at capacity, this will affect DirectAccess. However, from a DirectAccess perspective, there isn't much that you can do to mitigate this situation.

### Backup

DirectAccess stores all settings in Group Policies. It's essential that you maintain a current and valid backup of all DirectAccess Group Policy settings.

## Best practices

### Sizing and capacity planning

The best troubleshooting approach is the "incremental ramp, test, and monitor" method. The number of DirectAccess servers is very much dependent on what users are doing. This would include using client or server applications, browsing internal websites, and working on or copying large files (such as CAD files).

A good starting point is to use at least four CPUs and more than eight gigabyte (GB) of RAM. A better choice would be eight CPUs, more than 12 GB of RAM, and more than 80 GB of disk space. There is no programmatic preference for physical or virtual servers. Either would work well if correctly sized.

For more information, see [DirectAccess Capacity Planning](/windows-server/remote/remote-access/directaccess/directaccess-capacity-planning).

### Limit

There is no known limit to how many connections a DirectAccess server can accept, apart from resource constraints (CPU, memory, disk space, network throughput, and so on) and NetNat (NAT64) ports.

NetNat (NAT64) is being used on the DirectAccess servers to translate between IPv6 and IPv4. By default, there are 40,999 (6001-49000) NetNat ports available when you use a single IP address on the internal network adapter.

> [!Note]
> The number of DirectAccess active connections does not necessarily relate to the number of NetNat ports that are being used. A small number of DirectAccess client could exhaust all NetNat ports, depending on what users are doing and how many ports are being used by a DirectAccess client.

The NetNat configuration can be viewed by running the `Get-NetNatTransitionConfiguration` command.

## Common issues and solutions

Troubleshoot DirectAccess server console issues:

- [6to4](/troubleshoot/windows-server/networking/troubleshoot-directaccess-server-console-6to4)
- [DNS](/troubleshoot/windows-server/networking/troubleshoot-directaccess-server-console-dns)
- [Domain controller and Kerberos](/troubleshoot/windows-server/networking/troubleshoot-directaccess-server-console-dc-kerberos)
- [IP-HTTPS and IPSec](/troubleshoot/windows-server/networking/troubleshoot-directaccess-server-console-ip-https-ipsec)
- [Network and high availability](/troubleshoot/windows-server/networking/troubleshoot-directaccess-server-console-networking)

## Reference

- [DirectAccess Unsupported Configurations](/windows-server/remote/remote-access/directaccess/directaccess-unsupported-configurations)
- [Problems with the DirectAccess Setup Wizard](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/ee844200%28v=ws.10%29)
- [Problems with DirectAccess Connections](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/ee844125%28v=ws.10%29)
- [Fixing Issues with Network Location Detection](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/ee844116%28v=ws.10%29)
- [DirectAccess Offline Domain Join](/windows-server/remote/remote-access/directaccess/directaccess-offline-domain-join)
- [Deploy a Single DirectAccess Server Using the Getting Started Wizard](/windows-server/remote/remote-access/directaccess/single-server-wizard/deploy-a-single-directaccess-server-using-the-getting-started-wizard)
- [Deploy a Single DirectAccess Server with Advanced Settings](/windows-server/remote/remote-access/directaccess/single-server-advanced/deploy-a-single-directaccess-server-with-advanced-settings)
