---
title: The default dynamic port range for TCP/IP has changed in Windows Vista and in Windows Server 2008
description: Describes the changes to the default dynamic port range for TCP/IP in Windows Vista and in Windows Server 2008. Also describes commands that you can use to modify or show the dynamic port range for TCP/IP ports.
ms.date: 12/04/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: dbansal
---
# The default dynamic port range for TCP/IP has changed since Windows Vista and in Windows Server 2008

_Original product version:_ &nbsp; Windows 10, version 2004, all editions, Windows Server, version 2004, all editions, Windows 10, version 1909, all editions, Windows 10, version 1903, all editions, Windows Server, version 1903, all editions, Windows 10, version 1809, all editions, Windows Server 2019, all editions, Windows 10, version 1803, all editions, Windows Server version 1803, Windows Server version 1709, Windows Server version 1803, Windows 10, version 1709, all editions, Windows 10, version 1703, all editions, Windows 10, version 1607, all editions, Windows 10, version 1511, all editions, Windows Server 2016, Windows 10, Windows Server 2012 R2 Datacenter, Windows Server 2012 R2 Standard, Windows Server 2012 R2 Essentials, Windows Server 2012 R2 Foundation, Windows 8.1 Enterprise, Windows 8.1 Pro, Windows 8.1, Windows Server 2012 Datacenter, Windows Server 2012 Standard, Windows Server 2012 Essentials, Windows Server 2012 Foundation, Windows 8 Enterprise, Windows 8 Pro, Windows 8, Windows Server 2008 R2 Datacenter, Windows Server 2008 R2 Enterprise, Windows Server 2008 R2 Standard, Windows Server 2008 R2 Foundation, Windows 7 Enterprise, Windows 7 Ultimate, Windows 7 Professional, Windows 7 Home Premium, Windows 7 Home Basic, Windows 7 Starter, Windows Server 2008 Datacenter, Windows Server 2008 Enterprise, Windows Server 2008 Standard, Windows Server 2008 Foundation, Windows Server 2008 Datacenter without Hyper-V, Windows Server 2008 Enterprise without Hyper-V, Windows Server 2008 for Itanium-Based Systems, Windows Server 2008 Standard without Hyper-V, Windows Server 2008 Web Edition, Windows Vista Enterprise, Windows Vista Ultimate, Windows Vista Business, Windows Vista Home Premium, Windows Vista Home Basic, Windows Vista Starter, Windows Vista Business 64-bit Edition  
_Original KB number:_ &nbsp; 929851

#### Support for Windows Vista without any service packs installed ended on April 13, 2010. To continue receiving security updates for Windows, make sure that you are running Windows Vista with Service Pack 2 (SP2). For more information, go to the following Microsoft website: [Support is ending for some versions of Windows](https://windows.microsoft.com/windows/help/end-support-windows-xp-sp2-windows-vista-without-service-packs) 

## INTRODUCTION

To comply with Internet Assigned Numbers Authority (IANA) recommendations, Microsoft has increased the dynamic client port range for outgoing connections in Windows Vista and Windows Server 2008. The new default start port is 49152, and the new default end port is 65535. This is a change from the configuration of earlier versions of Windows that used a default port range of 1025 through 5000.

## More Information

You can view the dynamic port range on a computer that is running Windows Vista or Windows Server 2008 by using the following netsh commands:


- netsh int ipv4 show dynamicport tcp
- netsh int ipv4 show dynamicport udp
- netsh int ipv6 show dynamicport tcp
- netsh int ipv6 show dynamicport udp> [!NOTE]
> The range is set separately for each transport (TCP or UDP). The port range is now truly a range that has a starting point and an ending point. Microsoft customers who deploy servers that are running Windows Server 2008 may have problems that affect RPC communication between servers if firewalls are used on the internal network. In these situations, we recommend that you reconfigure the firewalls to allow traffic between servers in the dynamic port range of 49152 through 65535. This range is in addition to well-known ports that are used by services and applications. Or, the port range that is used by the servers can be modified on each server. You adjust this range by using the netsh command, as follows: netsh int <ipv4|ipv6> set dynamic <tcp|udp> start= **number** num= **range**  
This command sets the dynamic port range for TCP. The start port is **number**, and the total number of ports is **range**. The following are sample commands:


- netsh int ipv4 set dynamicport tcp start=10000 num=1000
- netsh int ipv4 set dynamicport udp start=10000 num=1000
- netsh int ipv6 set dynamicport tcp start=10000 num=1000
- netsh int ipv6 set dynamicport udp start=10000 num=1000These sample commands set the dynamic port range to start at port 10000 and to end at port 10999 (1000 ports). The minimum range of ports that can be set is 255. The minimum start port that can be set is 1025. The maximum end port (based on the range being configured) cannot exceed 65535. To duplicate the default behavior of Windows Server 2003, use 1025 as the start port, and then use 3976 as the range for both TCP and UDP. This results in a start port of 1025 and an end port of 5000.

> [!NOTE]
> When you install Microsoft Exchange Server 2007 on a Windows Server 2008-based computer, the default port range is 1025 through 60000.

For more information about port usage and about how ports can be statically mapped in Exchange Server 2007, go to the following article in the Microsoft Knowledge Base:  

[270836](https://support.microsoft.com/help/270836) Exchange Server static port mappings

For more information about security in Microsoft Exchange 2007, go to the following Microsoft TechNet website: [Exchange 2007 Security Guide](https://technet.microsoft.com/library/bb691338%28v=exchg.80%29.aspx) 

## References

For more information about IANA port-assignment standards, go to the following IANA website: [http://www.iana.org/assignments/port-numbers](http://www.iana.org/assignments/port-numbers) 
 Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.
