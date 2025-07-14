---
title: Storage tests on a failover cluster might not discover all shared LUNs
description: Provides a resolution for an issue in which the Validate a Configuration Wizard doesn't discover all shared LUNs for a cluster.
ms.date: 01/15/2025
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-tappelgate
ms.custom:
- sap:clustering and high availability\errors when running the validation wizard
- pcy:WinComm Storage High Avail
keywords: Windows failover cluster, SAN, shared LUNs, Validate a Configuration Wizard
---

# Storage tests on a failover cluster might not discover all shared LUNs

This article discusses how to resolve an issue in which the Validate a Configuration Wizard doesn't discover all of the shared LUNs that a cluster uses.

_Applies to:_&nbsp;Windows Server, all versions  
_Original KB number_:&nbsp;2914974  

## Symptoms

Consider the following scenario:

- You have a Windows Server multi-site failover cluster that has nodes in site A and site B.
- A multi-site storage area network (SAN) uses storage arrays in each site for site-to-site mirroring.
- You use the Validate a Configuration Wizard to run a set of validation tests on the failover cluster. 

In this scenario, storage tests might not detect all logical unit numbers (LUNs) as shared LUNs.

## Cause

The storage validation tests that the wizard runs select only shared LUNs. For a shared LUN, the disk signatures, device identification number (page 0x83), and storage array serial number are the same on all cluster nodes. When you use site-to-site mirroring, a LUN in one site (site A) has a mirrored LUN in another site (site B). These LUNs have the same disk signatures and device identification numbers (page 0x83). However, the storage array serial numbers are different. Because of the difference, the wizard doesn't recognize that the LUNs are shared.

## Resolution

To resolve the issue, run all the cluster validation tests before you configure the site-to-site mirroring.

> [!NOTE]  
> If you have to run the validation tests after you configure mirroring, LUNs that you don't select for the storage validation tests are supported by Microsoft and the storage vendor as valid shared LUNs.
