---
title: Cluster validation test fails in a multi-site cluster scenario
description: The Active Directory configuration validation may fail in a multi-site cluster scenario. Ignore it if domain communication and DC replication are OK.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, robsim, cpuckett
ms.custom: sap:errors-when-running-the-validation-wizard, csstroubleshoot
---
# Cluster validation test on Active Directory configuration fails in a multi-site cluster scenario

This article describes Active Directory configuration validation may fail in a multi-site cluster scenario.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4025260

## Symptoms

When you run a cluster validation test for your multi-site failover cluster, the test may fail at validating the Active Directory configuration with one of the following error messages:

- Connectivity to a writable domain controller from node `Computer2.contoso.com` could not be determined because of this error: Could not get domain controller name from machine Computer2.
- The site name of node `Computer2.contoso.com` could not be determined because of this error: Could not get domain controller name from machine `Computer2.contoso.com`.

Regardless of the errors, the cluster nodes can successfully communicate with some domain controller and form a failover cluster.

## More information

When you start a cluster validation test on a node, the node selects a domain controller to be used for the test. During the Active Directory configuration validation, all computers that are selected as part of the validation are pointed to use this domain controller. In a multi-site cluster scenario, the network communications may be designed in way where computers are only allowed to communicate with domain controllers that are in their local site. Therefore, these computers are prevented from communications with remote domain controllers. In this scenario, computers in other sites are not able to communicate with the selected domain controller, which leads to the failure of the cluster validation test.

If the computers can communicate to a domain controller in the domain, and the domain controllers are successfully replicating, then the functionality of your failover cluster is not impacted.

In a multi-site cluster scenario, you can safely ignore the failed validation. Meanwhile, your failover cluster is still supported by Microsoft Technical Support.
