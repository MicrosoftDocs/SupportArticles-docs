---
title: Host AD DCs in virtual hosting environments
description: Discusses the issues that affect a DC that runs as a guest operating system (OS) in virtual hosting environments in Windows Server.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:virtualized-domain-controller-errors-and-questions, csstroubleshoot
---
# Things to consider when you host Active Directory domain controllers in virtual hosting environments

This article describes the issues that affect a Windows Server-based domain controller (DC) running as a guest OS in virtual hosting environments. It also discusses things to consider when a DC runs in a virtual hosting environment.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 888794

## Summary

A virtual hosting environment lets you run multiple guest operating systems on a single host computer at the same time. Host software virtualizes the following resources:

- CPU
- Memory
- Disk
- Network
- Local devices

By virtualizing these resources on a physical computer, host software lets you use fewer computers to deploy operating systems for testing and development, and in production roles. Certain restrictions apply to an Active Directory DC that runs in a virtual hosting environment. These restrictions don't apply to a DC that runs on a physical computer.

This article discusses the things to consider when a Windows Server-based DC runs in a virtual hosting environment. Virtual hosting environments include:

- Windows Server Virtualization with Hyper-V.
- VMware family of virtualization products.
- Novell family of virtualization products.
- Citrix family of virtualization products.
- Any product on the hypervisor list in the [Server Virtualization Validation Program](https://www.windowsservercatalog.com/svvp.aspx) (SVVP).

For more information about the current status of system robustness and security for virtualized DCs, see the following article:

[Virtualizing Domain Controllers using Hyper-V](/windows-server/identity/ad-ds/get-started/virtual-dc/virtualized-domain-controllers-hyper-v). 

The Virtualizing Domain Controllers article provides general recommendations that apply to all configurations. Many of the considerations that are described in that article also apply to third-party virtualization hosts. It might include recommendations and settings that are specific to the hypervisor that you are using, including:

- How to configure time synchronization for DCs.
- How to manage disk volumes for data integrity.
- How to take advantage of Generation ID support in restoration or migration scenarios.
- How to manage allocation and performance of RAM and processor cores on the virtual machine host.

> [!NOTE]
> If you are using third-party virtualization hosts, consult the virtualization host documentation for specific guidance and recommendations.

This article supplements the Virtualizing Domain Controllers article by providing more hints and considerations that weren't in scope for the Virtualizing Domain Controllers article.

## Things to consider when you host DC roles in a virtual hosting environment

When you deploy an Active Directory DC on a physical computer, certain requirements must be satisfied throughout the DC's lifecycle. The deployment of a DC in a virtual hosting environment adds certain requirements and considerations, including:

- The Active Directory service helps preserve the integrity of the Active Directory database if a power loss or other failure occurs. To do so, the service runs unbuffered writes, and tries to disable the disk write cache on the volumes that host the Active Directory database and log files. Active Directory also tries to work in this manner if it's installed in a virtual hosting environment.

   If the virtual hosting environment software correctly supports a SCSI-emulation mode that supports forced unit access (FUA), unbuffered writes performed by Active Directory in this environment are passed to the host OS. If FUA isn't supported, you must manually disable the write cache on all volumes of the guest OS that host:

  - the Active Directory database
  - the logs
  - the checkpoint file

   > [!NOTE]
   >
   > - You must disable the write cache for all components that use Extensible Storage Engine (ESE) as their database format. These components include Active Directory, the File Replication Service (FRS), Windows Internet Name Service (WINS), and Dynamic Host Configuration Protocol (DHCP).
   > - As a best practice, consider installing uninterruptable power supplies on virtual machine hosts.

- An Active Directory DC is intended to run Active Directory mode continuously as soon as it's installed. Don't stop or pause the virtual machine for an extended time. When the DC starts, replication of Active Directory must occur. Ensure that all the DCs do inbound replication on all locally held Active Directory partitions according to the schedule that's defined on site links and connection objects. It's especially true for the number of days that's specified by the tombstone lifetime attribute.

   If the replication doesn't occur, you might experience inconsistent content of Active Directory databases on DCs in the forest. The inconsistency occurs because knowledge of deletions persists for the number of days that's defined by the tombstone lifetime. When DCs don't transitively complete inbound replication of Active Directory changes within this number of days, objects will linger in Active Directory. Cleaning up lingering objects can be time-consuming, especially in multi-domain forests that include many DCs.

- To recover from various problems, an Active Directory DC requires regular system state backups. The default useful life of a system state backup is 60 or 180 days. It depends on the OS version and the service pack revision that's in effect during the installation. This useful life is controlled by the tombstone lifetime attribute in Active Directory. At least one DC in every domain in the forest should be backed up on a regular cycle, per the number of days that's specified in the tombstone lifetime.

    In a production environment, you should make daily system state backups from two different DCs.

    > [!NOTE]
    > When the virtual machine host takes a snapshot of a virtual machine, the guest OS doesn't detect this snapshot as a backup. When the host supports the Hyper-V Generation ID, this ID would be changed when the image is started from a snapshot or replica. By default, the DC would consider itself to be restored from a backup.

## Things to consider when you host DC roles on clustered hosts or when you use Active Directory as a backend in a virtual hosting environment

- When your DCs run on clustered host servers, you would expect that they are fault tolerant. The same expectation applies to virtual server deployments that aren't from Microsoft. However, there's one problem in this assumption: In order for the nodes, disks and other resources on a clustered host computer to autostart, authentication requests from the computer must be serviced by a DC in the computer's domain. Alternatively, part of the configuration of the clustered host must be stored in Active Directory.

    To ensure that such DCs can be accessed during cluster system startup, deploy at least two DCs in the computer's domain on an independent hosting solution outside this cluster deployment. You can use physical hardware or another virtual hosting solution that doesn't have an Active Directory dependency. For more information about this scenario, see [Avoid creating single points of failure](/windows-server/identity/ad-ds/get-started/virtual-dc/virtualized-domain-controllers-hyper-v#avoid-creating-single-points-of-failure).

- These DCs on separate platforms should be kept online and be network-accessible (in DNS and in all required ports and protocols) to the clustered hosts. In some cases, the only DCs that can service authentication requests during cluster startup are on a clustered host computer that's being restarted. In this situation, authentication requests fail, and you must manually recover the cluster.

    > [!NOTE]
    > Do not assume that this situation applies to Hyper-V only. Third-party virtualization solutions can also use Active Directory as a configuration store or for authentication during certain steps of VM startup or configuration changes.

## Support for Active Directory DCs in virtual hosting environments

For more information, see [Support policy for Microsoft software that runs on non-Microsoft hardware virtualization software](https://support.microsoft.com/help/897615/support-policy-for-microsoft-software-that-runs-on-non-microsoft-hardw).
