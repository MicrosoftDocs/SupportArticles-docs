---
title: Error when you demote a domain controller
description: Resolves an issue where demoting a domain controller by using the Active Directory Installation wizard (Dcpromo.exe) fails.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dcpromo-and-the-installation-of-domain-controllers, csstroubleshoot
---
# Error message occurs when you demote a domain controller

This article provides a solution to an issue where demoting a domain controller by using the Active Directory Installation wizard (Dcpromo.exe) fails.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 282272

## Symptoms

When you demote a Windows domain controller by using the Dcpromo.exe, you may receive the following error message:

> This domain controller holds the last replica of the following application directory partitions:  
> DC=MSTAPI,DC= **yourdomain**,DC=com

## Cause

This behavior can occur if you installed the domain controller by using the **Configure Your Server** wizard. When you use this wizard, it automatically creates a program partition or a non-domain naming context called DC=MSTAPI,DC= **yourdomain**,DC=com.

## Resolution

If you created the partition by using the **Configure Your Server** wizard, and you used the default name of Mstapi, if this name is not in use, use the Tapicfg.exe tool to remove this name. To do so, run the following command, where <your_domain.com> is your domain DNS name:

```console
tapicfg remove /directory:mstapi.<your_domain.com>
```

If the partition was created manually, or if it was created by using another program, you can remove it by using the Ntdsutil utility:

1. Open a command prompt, and then type *ntdsutil*.
2. From the Ntdsutil prompt, type `partition management`.
3. In the **Domain Management** window, type `connections`.
4. Type `connect to server <yourservername>`.

    After the binding message appears, you will have a successful connection to your server.
5. In the **Server Connections** window, type `quit`.
6. In the **Domain Management** window, type `list`. A list of the naming contexts on this server appears.
7. To remove the application directory partition replica, type `remove nc replica <ApplicationDirectoryPartition> <DomainController>`.
8. At the Ntdsutil prompt, type `Q`, and then press ENTER until you are returned to the CMD command prompt. You can now successfully demote this domain controller. You may have to restart this domain controller before you start the Active Directory Installation wizard again.

## More information

Windows supports program naming contexts, also referred to as non-domain naming contexts. This feature allows the Microsoft Active Directory directory service to host dynamic data without impacting network performance by enabling you to control the scope of replication and placement of replicas. With Active Directory services, you can create a new type of naming context or partition, referred to as the application partition. This naming context can contain a hierarchy of any type of object except security principals (users, groups, and computers), and it can be configured to replicate to any set of domain controllers in the forest that are not necessarily all in the same domain.
