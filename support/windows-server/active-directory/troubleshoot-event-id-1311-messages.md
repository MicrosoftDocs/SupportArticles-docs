---
title: Troubleshoot Event ID 1311 messages
description: Describes how to troubleshoot event ID 1311 messages in the Directory Service event.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, arrenc, LARRYGA
ms.custom:
- sap:active directory\active directory replication and topology
- pcy:WinComm Directory Services
---
# How to troubleshoot Event ID 1311 messages on a Windows domain

This article describes how to troubleshoot event ID 1311 messages in the Directory Service event log on a Windows domain.

_Original KB number:_ &nbsp; 307593

**Applies to: All supported versions of Windows Server**

## Symptoms

The Knowledge Consistency Checker (KCC) constructs and maintains the replication topology for Active Directory. To do this, the KCC examines the sum of all naming contexts that reside in the forest and all administrator-defined constraints for site, site link, and link cost.

If an Active Directory domain, a schema, a configuration, an application partition, or the global catalog naming contexts can't be replicated between domain controllers or sites, an event ID 1311 message similar to the following is logged in the Directory Service event log:

> Event Type: Error  
Event Source: NTDS KCC  
Event Category: Knowledge Consistency Checker  
Event ID: 1311  
Date: MM/DD/YYYY  
Time: HH:MM:SS AM|PM  
User: N/A  
Computer: \<domain_controller_name>  
Description:  
The Directory Service consistency checker has determined that either (a) there is not enough physical connectivity published via the Active Directory Sites and Services Manager to create a spanning tree connecting all the sites containing the Partition CN=\<partition name>,DC=\<root domain of forest>,DC=com, or (b) replication cannot be performed with one or more critical servers in order for changes to propagate across all sites (most often because of the servers being unreachable).

## Cause

This behavior occurs if one or more of the following conditions are true:

- Site link bridging is enabled on a network that doesn't support physical network connectivity between two domain controllers in different sites that are connected by a KCC link.
- One or more sites aren't contained in site links.

- Site links contain all sites, but the site links aren't interconnected. This condition is known as disjoint site links.
- One or more domain controllers are offline.
- Bridgehead domain controllers are online, but errors occur when they try to replicate a required naming context between Active Directory sites.
- Administrator-defined preferred bridgeheads are online, but they don't host the required naming contexts.
- Preferred bridgeheads are defined correctly by the administrator, but they're currently offline.
- The bridgehead server is overloaded either because the server is undersized, too many branch sites are trying to replicate changes from the same hub domain controller, or the site link schedules are too frequent.
- KCC has built a different path around a site-to-site connection failure, but it retries the failing connection every 15 minutes because it is in *connection keeping mode*.

The common causes of event ID 1311 messages fall into two categories: improper logical configuration and infrastructure failure. Event ID 1311 messages are logged when an improper logical configuration or a replication error occurs.

- Improper logical configuration

    A logical configuration is improperly configured when information in the Configuration naming context (NC) (visible in the Sites and Services snap-in) doesn't match the physical topology of the network that hosts the Active Directory forest. For example, a site may not be properly defined, sites that are missing from site links may be included, site links may not be interconnected, or incorrect bridgeheads may be selected by the administrator.

- Infrastructure failure

  An infrastructure failure occurs because of one of more of the following events:

  - A wide area network (WAN) link fails.
  - A domain controller that hosts a necessary naming context is offline.
  - A replication failure occurs for one or more naming contexts.
  - The inbound partner for the replication has disabled outbound replication.

## Resolution

To troubleshoot event ID 1311 messages, use the following methods.

- Determine if the event ID 1311 messages are site-specific or forest-wide.
- Determine if site link bridging is turned on and if the network is fully routed.
- Verify that all sites are defined in site links.

- Detect and remove preferred bridgeheads.
- Resolve Active Directory replication failures in the forest.
- Determine if source servers are overloaded.
- Determine if site links are disjointed.
- Delete connections if KCC is in "Connection Keeping" mode.

### Determine if the Event ID 1311 messages are site-specific or forest-wide

Determine if event ID 1311 messages are logged on all inter-site topology generator (ISTG) domain controllers in the forest or only on site-specific ISTG domain controllers. To locate ISTG domain controllers, use the Ldp.exe tool to search for the following attributes:

- Base DN: CN=Sites,CN=Configuration,DC=RootDomainName,DC=Com  
- Filter: (cn=NTDS Site Settings)  
- Scope: Subtree  
- Attributes: interSiteTopologyGenerator

To determine the scope of the event, use one of the following methods:

- Examine the Directory Service event logs of an appropriate number of ISTG domain controllers in the forest.

- Use the Eventcombmt.exe tool (available from Microsoft Product Support Services) to search for event ID 1311 messages on an appropriate number of ISTG domain controllers in the forest.

### Determine if site link bridging is turned on and if the network is fully routed

When you enable site link bridging in the Active Directory Sites and Services snap-in, you must make sure that any site defined in Active Directory has a fully routed network connection to any other site that is defined by the administrator. If KCC builds a connection link between two unconnected sites in which site link bridging is enabled, event ID 1311 messages may be logged.

Site link bridging is enabled in Active Directory if the following conditions are true:

- The **Bridge all site links** check box is selected for the IP protocol and the SMTP protocol in the Active Directory Sites and Services snap-in.
- The Options attribute for the IP protocol and the SMTP protocol is NULL or set to 0 (zero) for the following Domain Name (DN) paths:

  - CN=IP,CN=Inter-Site Transports,CN=Sites,CN=Configuration,DC= **root domain of forest**  
  - CN=SMTP,CN=Inter-Site Transports,CN=Sites,CN=Configuration,DC= **root domain of forest**

To determine if a fully routed network connection exists between two sites, contact your NOS administrator, network administrator, or Active Directory architect.

If site link bridging is enabled in a non-routed environment, either make the network fully routed, or disable site link bridging and then create the site links and site link bridges that you must use. Wait for two times the longest replication interval in the forest. If event ID 1311 messages continue to be logged or if site link bridging is enabled in a fully routed network, continue to the "Verify That All Sites Are Defined in Site Links" method.

By default, site link bridging is turned on. Additionally, the best practice guidelines recommend that you keep site link bridging turned on.

The following diagram uses plus signs (+) and minus signs (-) to illustrate physical network connections between Active Directory sites. Site AZ is listed in site link WEST and site GA is listed in site link EAST, but sites AZ and GA don't have fully routed network connections to sites WA and NY in an Active Directory configuration where site link bridging is enabled.

```output
                  WA <-- Site Link WANY --> NY  
                  +-                        +-
                 +  -                      +  -  
                +    -                    +    -
               +      -                  +      -
             CA + + + AZ               IL + + + GA

            Site Link WEST           Site Link EAST
```

### Verify that all sites are defined in site links

Every site defined in Active Directory must be hosted or reside in a site link. For example if sites WA, CA, AZ, NY, IL, and GA are defined, and site links WEST, EAST and WANY are defined, event ID 1311 messages are logged if any one site (for example, AZ or GA) isn't listed in a site link where the sites are physically connected. Sites are orphaned when sites in a deleted site link aren't added to an appropriate existing site link.

```output
                  WA -- Site Link WANY -- NY  
                 /                        /
                /                        /
               /                        /
              CA    (AZ)               IL    (GA)

            Site Link WEST           Site Link EAST
```

Because sites AZ and GA are not listed in any site links, they are orphaned and the KCC does not consider them when it constructs the replication topology for Active Directory.

The `repadmin /showism` command is useful for locating improperly configured sites. Output from the `repadmin /showism` command appears similar to the following example from a forest named *corp*:

> ==== TRANSPORT CN=IP,CN=Inter-Site Transports,CN=Sites,CN=Configuration,DC=corp,DC=com CONNECTIVITY INFORMATION FOR 3 SITES: ====  
> 0,    1,    2  
> ( 0) CN=US-NC,CN=Sites,CN=Configuration,DC=corp,DC=com  0:0:0, 100:15:0, 200:15:0  
> ( 1) CN=US-TX,CN=Sites,CN=Configuration,DC=corp,DC=com  100:15:0, 0:0:0, 100:15:0  
> ( 2) CN=US-WA,CN=Sites,CN=Configuration,DC=corp,DC=com  200:15:0, 100:15:0, 0:0:0

> [!NOTE]
> Unlike other arguments for the repadmin command, you cannot run the `repadmin /showism` command from a remote computer. You must run the `repadmin /showism` command from the console of the domain controller that you want to examine (in most cases, this is the ISTG domain controller).

For each site that is configured for IP-based replication or for SMTP-based replication (not shown), the `repadmin /showism` command returns a site matrix that represents the connections to all the sites in the forest. Each entry in the site matrix contains three numbers delimited by colons (:) that represent the cost, replication interval, and options for each replication link to another site in the Active Directory forest. The numbers in an entry appear in the following order:  
**Cost** : **Replication interval** : **Options**  

- The **Cost** value indicates the preference for a network link for replicating directory information between sites. The administrator uses the Active Directory Sites and Services snap-in to define the **Cost** value for each site link.

- The **Replication interval** value indicates the replication frequency of the link in minutes.
- The **Options** value indicates the options for the site link, including site link notification.

    > [!NOTE]
    > When you troubleshoot event ID 1311 messages, you can ignore the
    **Options** value.

In the example from the `corp.com` forest, site link bridging is enabled, and the forest contains three Active Directory sites:

- Site 0: US-NC, an uncovered site that uses the TX<->NC link to connect to Site 1 (US-TX).
- Site 1: US-TX, which hosts two domain controllers.
- Site 2: US-WA, a covered site that uses the TX<->WA link to connect to Site 1 (US-TX).

Each site matrix contains one 0:0:0 entry that refers to itself. An entry that contains positive numbers for the cost value and replication interval value (for example, 200:15:0 or 100:15:0) indicates that the site connection is good. A -1:0:0 entry indicates that the site connection isn't working. Which occurs if one or more of the following conditions is true:

- The replication protocol isn't used. For example, if SMTP replication isn't configured, the entries in the SMTP portion of the `/SHOWISM` matrix all appear as -1:0:0.
- The site doesn't host any domain controllers (this is known as an *uncovered* site).
- The site isn't included in a site link.

If site link bridging is enabled and the repadmin /showism command returns -1:0:0 entries for one or more covered Active Directory sites, make sure that the affected sites are listed in a site link.

A site with a full complement of -1:0:0 entries and one 0:0:0 entry is orphaned unless the site is uncovered (no domain controllers reside in that site). When you troubleshoot event ID 1311 messages, record the names of all orphaned sites, but don't record the names of uncovered sites.

If site link bridging is disabled, -1:0:0 entries are less meaningful. If it's the case, you must manually determine if each site is included in a site link. To do so, write down the list of sites and site links, and manually map each site to a site link.

> [!NOTE]
> The `repadmin /showism` command always returns -1:0:0 entries for an uncovered site.

In the following `repadmin /showism` example, site link bridging is enabled in the `corp.com` forest, and site link TX<->WA was deleted. Site 2 (US-WA) is orphaned from all other sites in the forest and must be added to an appropriate site link.

> ==== TRANSPORT CN=IP,CN=Inter-Site Transports,CN=Sites,CN=Configuration,DC=corp,DC=com CONNECTIVITY INFORMATION FOR 3 SITES: ====  
> 0,    1,    2
> ( 0) CN=US-NC,CN=Sites,CN=Configuration,DC=corp,DC=com 0:0:0, 100:15:0, -1:0:0  
> ( 1) CN=US-TX,CN=Sites,CN=Configuration,DC=corp,DC=com 100:15:0, 0:0:0, -1:0:0  
> ( 2) CN=US-WA,CN=Sites,CN=Configuration,DC=corp,DC=com -1:0:0, -1:0:0, 0:0:0

### Detect and remove preferred bridgeheads

Because correct bridgehead selection is difficult in multi-domain forests, and because DCs have good fail-over logic in case a KCC-selected bridgehead goes offline, Microsoft strongly recommends that you don't define preferred bridgehead servers.

To search for preferred bridgehead servers:

1. Use the Ldp.exe command-line tool to do an LDAP search for the following criteria:  
    DN Path: cn=sites,cn=configuration,dc=\<root domain of forest>  
    ObjectClass: server  
    Attributes: bridgeheadTransportList

2. Use the FINDSTR command against an LDIFDE export file from the CN=Sites,CN=Configuration container:  
      LDIFDE CN=SITES,CN=CONFIGURATION,DC=\<Root domain in forest> SITEDUMP.LDF  
      FINDSTR /i "bridgeheadTransportList" SITEDUMP.LDF

    If the search returns any results, note the name of server in the Domain Name path in which the bridgeheadTransportList attribute is populated.

    If you find any preferred bridgehead servers, use the **Site and Services** snap-in to remove them:

    1. Navigate to the site where the domain controller reside.
    2. Right-click on the **Domain Controller** and click on **Properties**.
    3. On the lower section of the **General** tab, remove the IP/SMTP from the list of the **The server is a preferred bridgehead server for the following transports** box.  
    4. Select **OK**.
    5. Wait two times the maximum replication interval in the forest. If event ID 1311 messages continue to be logged, continue to the next method.

### Resolve Active Directory replication failures in the forest

Active Directory replication requires the transitive replication of all naming contexts in the forest to all domain controllers that replicate a common partition.

Resolve replication failures for online domain controllers as quickly as possible, especially those that host one-of-a-kind naming contexts in a forest (for example, the only domain controller for a particular domain in the forest). As a last resort, if you can't make a domain controller replicate, remove it from the forest.

If a domain controller is offline for fewer days than the tombstone lifetime number (by default 60), bring the domain controller online and force it to replicate, or as a last resort, remove it from the forest.

If a domain controller is offline or does not replicate inbound changes for more days than the tombstone lifetime number, do not resuscitate it. Instead, immediately remove it from the forest.

For more information about the TombstoneLifetime value, click the following article numbers to view the articles in the Microsoft Knowledge Base:

- [216993](https://support.microsoft.com/help/216993) Useful shelf life of a system-state backup of Active Directory
- [314282](https://support.microsoft.com/help/314282) Lingering objects may remain after you bring an out-of-date Global Catalog server back online  

When you want to discover and troubleshoot replication failures, the following tools can be useful:

- `repadmin /failcache`: Run this command from the console of each ISTG domain controller in the forest to discover replication failures for bridgeheads in the site for that ISTG.

    > [!NOTE]
    > You can also run this command remotely against other ISTG domain controllers in the forest.

- `repadmin /showreps`: Run this command from the console of each ISTG domain controller in the forest to analyze replication of specific domain controllers that are exposed by the `repadmin /failcache` command.
- `dcdiag /test:intersite /e /q`: This command tests inter-site connectivity for bridgehead domain controllers in the forest. The result set is limited to domain controllers that experience errors with the `/q` switch.
- `dcdiag /test:connectivity /e /q`: This command tests name resolution and ldap / rpc connectivity to all domain controllers in the forest. The result set is limited to domain controllers that experience errors with the `/q` switch.
- Examine the Directory Service Event log on ISTG domain controllers and Bridgehead servers, using the following settings for the NTDS Diagnostic levels:

  - One Knowledge Consistency Checker: 3
  - Five Replication Events: 3
  - Internal Processing: 1

The `repadmin /failcache` command lists replication failures that KCC knows about. The output from the `repadmin /failcache` command is divided into two sections:

The KCC Link Failures cache lists errors for existing connection links. The ISTG domain controller imports showreps (repsfroms) data for every bridgehead server in its site. However, the ISTG domain controller does not list errors. The link failure cache is emptied at the beginning of every KCC run and refilled during the course of the current run.

The KCC Connection Failures cache lists unsuccessful attempts to build connection objects between domain controllers (reps from or reps to). When you run the `repadmin /failcache` command from the ISTG domain controller, it lists entries that are imported from bridgeheads in the site. At the beginning of each KCC run, the KCC examines each entry in the connection failure cache and tries to DsBind to the failing server. If the bind succeeds, the entry is removed.

The `repadmin /failcache` command differs from the `repadmin /showreps` command in two ways:

- The `repadmin /showreps` command shows the naming context that is failing. The `repadmin /failcache` command doesn't.
- Data from the `repadmin /failcache` command isn't replicated between domain controllers.

The following example shows sample output from the `repadmin /failcache` command.

```console
Z:\>repadmin /failcache
==== KCC CONNECTION FAILURES > ============================  
(none)  

==== KCC LINK FAILURES > ==================================  
USA-WA-24\C-24-DC03
      DC object GUID: 134244cd-26be-4944-82a7-ac3eb74fc02f
      No Failures.
  USA-WA-24\B-24-DC02
      DC object GUID: 21b050d6-33b5-424d-aa9b-060fe209233d
      No Failures.
  USA-WA-24\Z-24-DC-05
      DC object GUID: bfb3b008-3849-4e5d-81d8-53dbb76d587a
      No Failures.
```

### Determine if source servers are overloaded

A domain controller that is overloaded with a large number of direct replication partners or a replication schedule that is overly aggressive can create a backlog in which some partners never receive changes from a hub domain controller. In the output from the `repadmin /showreps` command, partner domain controllers of overloaded source domain controllers appear with the *at never* status.

To resolve this issue, resize hardware, reconfigure site links and reconfigure site link or connection schedules as necessary to reduce the load on overloaded domain controllers.

### Determine if site links are disjointed

*Disjoint site links* is an Active Directory configuration in which the topology is broken into two parts or in which some sites don't replicate because site definitions and site link definitions are incorrect. For example, the following diagram shows a configuration in which Sitelink_ABC contains sites A, B, and C and Sitelink_DEF contains sites D, E, and F, but no site link connects any of the sites in Sitelink_ABC to any of the sites in Sitelink_DEF. To resolve the disjoint site links condition, a new site link must connect at least one site in Sitelink_ABC with at least one site in Sitelink_DEF (for example, a new site link between site A and site D).

```output
                  A                        D  
                 / \                      / \
                /   \                    /   \
               /     \                  /     \
              B       C                E       F

            Sitelink_ABC              Sitelink_DEF
```

The following diagram shows another possible a disjoint site links configuration. In this case, a new site link must join any site in Sitelink_ABDC with at least one site in Sitelink_FG (for example, a new site link between site A and site F) to resolve the disjoint site links condition.

```output
                  A                  F  
                 / \                  \
                /   \                  \
               /     \                  \
              B       C                  \
               \     /                    \
                \   /                      \
                 \ /                        \
                  D                          G

            Sitelink_ABDC            Sitelink_FG
```

Disjoint site links are the most difficult improper configuration to troubleshoot. Look for disjoint site links only after you rule out all other known causes. Use a pencil and paper to graph site topology and locate orphaned sites.

### Delete connections if KCC is in Keep Connection mode

If KCC builds a different path around a site-to-site connection failure, but it retries the failing connection every 15 minutes because it is in *connection keeping mode*, delete all broken connections and let KCC rebuild them. Wait two times the longest replication schedule in the forest.

## Terminology and concepts

- Bridgehead server: Any domain controller in an Active Directory site that replicates an Active Directory partition (for example, schema, configuration, domain, application partition, or global catalog) to a domain controller in another Active Directory site.

    A bridgehead is selected for each unique directory partition, domain, or application partition in an Active Directory site, so a site that hosts three different domains has three in-site bridgehead servers.

    Domain controllers replicate all naming contexts that are held in common with their direct replication partners, so a domain controller in the "corp.com" domain replicates CN=SCHEMA and CN=CONFIGURATION in addition to the "corp.com" domain naming context with its inter-site bridgehead partner.

- Inter-site topology generator (ISTG): For each Active Directory site, a single server, known as the ISTG, is nominated to build the inter-site replication topology.  

- Uncovered Site: An Active Directory site defined in the Sites and Services snap-in that does not currently contain any domain controllers. An uncovered site may be waiting for its domain controller to arrive from a staging site. Additionally, a site may be defined as uncovered to provide site preference for client operations.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
