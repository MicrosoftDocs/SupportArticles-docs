---
title: Microsoft Exchange compatibility with Single Label Domains, Disjointed Namespaces, and Discontiguous Namespaces
description: Describes compatibility of Microsoft products with Single Label Domains, Disjoint Namespaces, and Discontiguous Namespaces.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: jarrettr, kaushika
ms.custom: sap:dns, csstroubleshoot
---
# Microsoft Exchange compatibility with Single Label Domains, Disjointed Namespaces, and Discontiguous Namespaces

This article describes the compatibility of Microsoft Exchange with Single Label Domains, Disjoint Namespaces, and Discontiguous Namespaces.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2269838

## Single Label Domains

For a description of Single Label Domains, see the Single Label Domains topic in the [Microsoft DNS Namespace Planning Solution Center.](dns-namespace-design.md)

## Disjoint Namespaces

For a description of Disjoint Namespaces, see the Disjoint Namespaces topic in the [Microsoft DNS Namespace Planning Solution Center.](dns-namespace-design.md)

## Discontiguous Namespaces

For a description of Discontiguous Namespaces, also known as a non-contiguous namespaces, see the Discontiguous Namespaces topic in the [Microsoft DNS Namespace Planning Solution Center.](dns-namespace-design.md)

## Exchange Server

In response to customer feedback, the Exchange team has updated its testing matrix and has determined that Exchange Server 2010 will be supported on SLDs, Disjoint Namespaces, and Discontiguous Namespaces. This page contains a brief description of each of these scenarios and special considerations.

> [!NOTE]
> For information about disjoint namespace scenarios in Microsoft Exchange Server 2013, visit the following TechNet website:

[Disjoint namespace scenarios](/exchange/disjoint-namespace-scenarios-exchange-2013-help)

In adding support for these types of topologies, there's an underlying requirement for DNS to be correctly installed and configured. Before users continue with any deployment that is defined here, clients and servers must be able to reliably resolve DNS queries for a given resource in the appropriate namespace.

### Single Label Domains

Although Exchange 2010 is supported with SLDs, the Exchange product team's view is that SLDs aren't a recommended configuration and may not be supported by future Exchange versions. Other Microsoft or third-party applications that you want to run in your environment may not be supported on an SLD. This could have an adverse effect on your environment. Although we'll allow the installation of Exchange 2010 in an SLD, we strongly recommend that you take steps to move your organization out of this configuration.

### Disjoint Namespaces

In Microsoft Exchange 2010, there are three supported scenarios for deploying Exchange in a domain that has a disjoint namespace. The supported scenarios are as follows:

- Scenario 1: The primary DNS suffix of the domain controller isn't the same as the DNS domain name. Computers that are members of the domain can be either disjoint or not disjoint.
- Scenario 2: A member computer in an Active Directory domain is disjoint even though the domain controller isn't disjoint.
- Scenario 3: The NetBIOS domain name of the domain controller isn't the same as the subdomain of the DNS domain name of that domain controller.

For more information about Exchange 2010 and disjoint namespaces, see [Understanding Disjoint Namespace Scenarios](/previous-versions/exchange-server/exchange-140/bb676377(v=exchg.140)).

#### Special considerations

- In Exchange 2010, you may have to configure the DNS suffix search list to include multiple DNS suffixes if you have a disjoint namespace. For more information, see [Configure the DNS Suffix Search List for a Disjoint Namespace](/previous-versions/exchange-server/exchange-140/bb847901(v=exchg.140)).
- `Msds-allowedDNSSuffixes` must be configured within the Active Directory environment for all namespaces that are used within the forest. For information about how to configure this, see [The computer's primary DNS suffix does not match the FQDN of the domain where it resides](/previous-versions/office/exchange-server-analyzer/aa998420(v=exchg.80)).

### Discontiguous (noncontiguous) namespaces

For discontiguous namespaces, DNS must be configured so that Exchange servers can resolve all domain names in the environment. It's also a requirement that msds-allowedDNSSuffixes are configured within the Active Directory environment for all namespaces that are used within the forest.

For information about how to configure this, see [Understanding DNS Client Settings](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754152(v=ws.11)).

#### Affected Exchange products

- Exchange Server 2013

    For more information about Exchange 2013 system requirements, see [Exchange 2013 System Requirements](/exchange/exchange-2013-system-requirements-exchange-2013-help?).
- Exchange Server 2010

    For more information about Exchange 2010 system requirements, see the [Exchange 2010 System Requirements](/previous-versions/exchange-server/exchange-140/aa996719(v=exchg.140)) article.
- Exchange Server 2007

    Microsoft has changed the Setup prerequisite rule for SLDs from an Error to a Warning. This change lets the Service Pack 1 installation continue in SLD environments.

- [Exchange Server 2003](/previous-versions/tn-archive/bb123872(v=exchg.65))

## References

[Product Compatibility page on the DNS Namespace Planning Solution Center](dns-namespace-design.md)
