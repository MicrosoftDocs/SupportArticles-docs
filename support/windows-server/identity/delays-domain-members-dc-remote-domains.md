---
title: Delays when domain members are required to communicate to DCs on remote domains
description: Discusses a problem that causes delays when domain members try to access domain controllers in other domains.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:schema-update-failure-or-conflict, csstroubleshoot
ms.subservice: active-directory
---
# Delays when domain members are required to communicate to DCs on remote domains

This article provides help to solve the delays that occur when domain members are required to communicate to DCs on remote domains.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4550655

## Symptoms

Assume that you have an Active Directory environment that has one or more forests, and each forest has one or more domain trees. In this environment, a domain tree is a DNS name root that is independent of the forest root.  

You have member computers in all the domains of all the forests. You also have a network security policy that limits the communication from your computers to the servers and peers that are required for the business function of your computers and also to the users who work with that business function.  

In this scenario, you notice that domain members access domain controllers (DCs) in domains other than the domain that they are a member of. They may access servers that are different from the server that users log on to. This communication may be restricted by the firewall rules that you have set.  

This activity causes frequent delays and errors when the member computer tries unsuccessfully to access the server ports of the other domain DCs.  

When this problem occurs, you receive an error message that's based on the protocol that's used, as follows:  

- RPC: error code 1722 (RPC_S_SERVER_UNAVAILABLE)
- LDAP: error code 85 (LDAP_TIMEOUT)
- WinSock: error code 10060 (WSAETIMEDOUT)

## Analysis and cause

Typically, you would expect the computer and users to primarily use DCs from the same domain that they are a member of. They may also connect to Global Catalogs for forest-wide searches in their own forest or in remote forests.  

However, domain members sometimes reach outside their own domain. They may do this based on their configuration. They may also do this after they discover the overall forest structure and then send requests to all domains that they discovered.  

Examples of such communication requirements:  

- The configuration can be Group Policy settings that are linked to the scope of policy settings for the domain members. Or, it can be policy settings on the Active Directory site that the computer is in.

- There may be applications that want to search or synchronize objects from all the domains that they find. For example, the SharePoint topology discovery.  

There is also the group of applications that search a domain root object by using LDAP searches and that allow and receive continuation referrals. This means that they redirect referrals to all child NCs (application partitions and child domains). Therefore, they require access to child domain DCs.  

The delays that you experience depend on the number of domains, the DCs that are referenced, and the number of retries that are made by an application. The delay can take many minutes. Some applications also eventually time out before all the DCs and domains have returned errors frequently enough. In your analysis, you may see the original LDAP query marked as successful because they received results from the domain in which the query was started. However, the query is still delayed because it is waiting for the referrals to be completed.

## Recommendations

Microsoft does not have documentation about how to determine which DCs of any domain in any forest in the scope of the enterprise are used based on a particular configuration. There are also no rules to control which DCs can be accessed. This applies to Windows and all Microsoft applications.  

You must expect any domain member to reach out to all DCs of all forests. If you want to restrict the domain members, you have to use a trial and error approach. If you find that delays occur because additional DCs are contacted, you have to adopt firewall rules that allow access to those DCs.  

If you are not sure which ports are available or blocked by the firewall, use the PortQry tool to test the settings. For more information, see [New features and functionality in PortQry version 2.0](../networking/portqry-command-line-port-scanner-v2.md).

## References

- [ADConnection Overview](/openspecs/windows_protocols/ms-adts/f460470c-8923-4836-95e3-cc09ef00a1a4)  
- [LDAP Referrals](/openspecs/windows_protocols/ms-adts/5cf1457f-b812-4e8c-afb4-e48505e19ca2)  
- [Handling and following referrals](/openspecs/windows_protocols/ms-adts/b2edefdd-16f9-413d-88c5-a2f5c137bafe)  
- [Service overview and network port requirements for Windows](../networking/service-overview-and-network-port-requirements.md)
