---
title: Cluster validation test fails in a domain change scenario
description: The Active Directory configuration validation may fail in a domain change scenario. User and computer objects being on different domains, and changing computer objects between domains can generate an error.
ms.date: 11/12/2023
author: Stephen Kusen
ms.author: <needs to be added>
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, robsim, cpuckett
ms.custom: sap:errors-when-running-the-validation-wizard, csstroubleshoot
ms.technology: windows-server-high-availability
---
# Cluster validation test on Active Directory configuration fails in a domain change scenario

This article describes Active Directory configuration validation may fail in a domain change scenario.

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  

## Symptoms

Consider this configuration:

- You have an existing server node `computer1.contoso.com`
- You want to move node `computer1` to a new domain called `contoso2.com`
- You create a computer object named `computer1` in the new domain `contoso2.com`
- The computer object named `computer1` remains also in `contoso.com`
- The user account running the commands resides in the domain `contoso.com`
- You have an existing Windows Server Failover Cluster containing nodes `computer2.contoso2.com` and `computer3.contoso2.com`, and the cluster name is `cluster1.contosos2.com`
- You want to add `computer1.contoso2.com` to the Windows Server Failover Cluster `cluster1.contoso2.com`

When you open a Remote Desktop Connection session to `computer2.contoso2.com` (the new domain) under a user on the original domain, in this example `contoso`, such as `contoso\username`, and run a cluster validation test for node `computer1.contoso2.com`, specifically the `System Configuration` test, you receive the following error messages:

- Connectivity to a writable domain controller from node `computer1.contoso2.com` could not be determined because of this error: Could not get domain controller name from machine `computer1`. 
- Node(s) `computer1.contoso2.com` cannot reach a writable domain controller. Please check connectivity of these nodes to the domain controllers.

Resolution:

- Delete Active Directory computer object named `computer1` from the original `contoso.com` domain.
- Re-try the cluster validation `System Configuration` test

## More information

When you start a cluster validation test on a node, the node selects a domain controller to be used for the test. During the Active Directory configuration validation, all computers that are selected as part of the validation are pointed to use this domain controller.  When the user domain is different than the node's domain, the user's domain is used to find a computer object of the node's name, and if that is not found, the node's domain is searched for the computer object.  That computer object is then attempted to be used to be verified, resulting in Kerberos authentication error, found in a network trace as `KRB Error: KRB5KRB_AP_ERR_MODIFIED`. In this situation, the computer object in the user's domain cannot be used as the node does not reside in the user's domain. 

In this situation, the computer object `computer1` needs to exist only in the new domain, shown above as `contoso2.com`.
