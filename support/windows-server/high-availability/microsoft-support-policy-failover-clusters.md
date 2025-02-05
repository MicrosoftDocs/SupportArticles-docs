---
title: The Microsoft support policy for Windows Server failover clusters
description: This article describes Microsoft support policy for Windows Server failover clusters.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, stevenek, jeffhugh
ms.custom: sap:Clustering and High Availability\Setup and configuration of clustered services and applications, csstroubleshoot
---
# Microsoft support policy for Windows Server failover clusters

This article describes Microsoft support policy for Windows Server 2016, Windows Server 2019, or Windows Server 2022 failover clusters implementation.

_Original KB number:_ &nbsp; 2775067

## Introduction

Microsoft Customer Service and Support supports Windows Server failover clusters that meet the following criteria:

- All hardware and software components in the failover cluster meet the qualifications to receive at least one of the following Windows Server 2016, Windows Server 2019, or Windows Server 2022 logos:
  - Certified for Windows Server 2016, Windows Server 2019, or Windows Server 2022 devices  

    This logo is designed for line-of-business and mission-critical hardware and software and demonstrates that a hardware or software component meets the highest technical bar for Windows fundamentals and platform compatibility that is set by Microsoft.
  - Certified Windows Server 2016, Windows Server 2019, or Windows Server 2022 systems  

    This logo is designed for cloud and infrastructure hardware and software. The Certified for Windows Server logo demonstrates that a server system meets the security, reliability, and manageability requirements of Microsoft products. Additionally, the logo demonstrates that a server system supports all the roles, features, and interfaces that Windows Server supports.

- The fully configured failover cluster passes all required failover cluster validation tests. To validate a failover cluster, run the Validate a Configuration Wizard in the Failover Cluster Manager snap-in, or run the Windows PowerShell cmdlet `Test-Cluster`.

## Validation tests

Before you create a cluster, run a failover cluster validation test on fully configured hardware that is running Windows Server. The failover cluster validation test identifies potential hardware and software configuration issues. Run the failover cluster validation test on hardware and software that is certified under the Windows Server Logo Program for Windows Server.

To configure a failover cluster in Windows Server, the failover cluster must pass the required failover cluster validation tests. The failover cluster validation tests perform the following functions on the collection of servers that you intended to use as a cluster:

- Hardware and Software inventory
- Network analysis
- Storage tests
- System configuration

By default, if the failover cluster validation tests recognize that one or more nodes already exist in a cluster, the cluster configuration function is performed. Also, if the failover cluster validation tests recognize that one or more nodes have the Hyper-V role installed, the Hyper-V configuration function is performed.

For a more information about how to validate hardware for a Windows Server failover cluster, see [Validate Hardware for a Failover Cluster](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134244(v=ws.11)).

> [!NOTE]
> All reports that the Validate a Configuration Wizard in the Failover Cluster Manager snap-in generates are stored in the %systemroot%\\cluster\\Reports folder.

Run the failover cluster validation tests on a fully configured failover cluster before you install the Failover Clustering feature. The failover cluster is valid if it receives one of the following indicators for each test in the Summary Report:

- A green check mark (passed)
- A yellow yield sign (warning)

    > [!NOTE]
    > The yellow yield sign indicates that the aspect of the proposed failover cluster that is being tested is not in alignment with Microsoft best practices. Investigate this aspect to make sure that the configuration of the cluster is acceptable for the environment of the cluster, for the requirements of the cluster, and for the roles that the cluster hosts.

- A red circle with single bar (canceled)

If a failover cluster receives a red "X" (fail) in one of the tests, you cannot use the part of the failover cluster that failed in a Windows Server failover cluster. Additionally, if a test fails, all other tests do not run, and you must resolve the issue before you install the failover cluster.

Run the validation tests when a major component of the cluster is changed or updated. For example, run the validation tests when you make the following configuration changes to the failover cluster:

- Add a node to the cluster
- Upgrade or replace the storage hardware
- Upgrade the firmware or the driver for host bus adapters (HBAs)
- Update the multipathing software or the version of the device specific module (DSM)
- Change or update a network adapter  

Microsoft Support may also request that you run the validation tests against a production cluster. When you do this, the failover cluster validation tests perform a hardware and software inventory, test the network, validate the system configuration, and perform other relevant tests. In some scenarios, you can run only a subset of the tests. For example, when troubleshooting a problem with networking, Microsoft Support may request that you run only the hardware and the software inventory and the networking test against the production cluster.

When an underlying storage configuration change or problem causes a cluster storage failure, Microsoft Support may also request that you run the validation tests on production clusters. The relevant disk resources and the resources on which the disks depend are taken offline during the test. Therefore, run the validation tests when the production environment is not being used. The validation has the ability to specify one or more disks to be included in the failover cluster validation tests.

For more information about advanced failover cluster validation scenarios, see [Validate Hardware for a Failover Cluster](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134244(v=ws.11)).

## More information

Microsoft supports the failover clusters that are listed under Cluster Solutions on the Windows Server Catalog for the following versions of Windows Server:

- Windows Server 2016 Standard
- Windows Server 2016 Datacenter
- Microsoft Hyper-V Server 2016
- Windows Server 2019 Standard
- Windows Server 2019 Datacenter
- Microsoft Hyper-V Server 2019
- Windows Server 2022 Standard
- Windows Server 2022 Datacenter 

For more information about the Windows Server Catalog, see [Windows Server Catalog](http://www.windowsservercatalog.com/).

For more information about failover clustering, see [Failover Clustering Overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831579(v=ws.11)).

For more information about the Microsoft support policy for earlier operating systems, see:

- [309395](https://support.microsoft.com/help/309395) The Microsoft support policy for server clusters, the Hardware Compatibility List, and the Windows Server Catalog

- [943984](https://support.microsoft.com/help/943984) The Microsoft Support Policy for Windows Server 2008 or Windows Server 2008 R2 Failover Clusters
