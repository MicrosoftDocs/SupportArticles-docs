---
title: LDAP Paged Queries with subordinate referrals are not chased properly
description: Provides some approaches to avoid the problem that LDAP Paged Queries with subordinate referrals are not chased properly
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:ldap-configuration-and-interoperability, csstroubleshoot
---
# LDAP Paged Queries with subordinate referrals are not chased properly

This article provides some approaches to avoid the problem that LDAP Paged Queries with subordinate referrals are not chased properly.

_Applies to:_ &nbsp; Windows 8  
_Original KB number:_ &nbsp; 2561166

## Symptoms

You have an application that searches the Active Directory with paged searches using ldap_search_ext or ldap_search_ext_s, and it is set to chase referrals. When it searches off the root of a domain NC, the paged searches end prematurely after the first page.  

In the application, the paged cookie it receives is empty and thus the application ends the query. In a network trace, you can verify that the paged query does return a non-empty cookie along with one or more referrals. Most queries will see no result set when chasing the referral, as often the objects searched for in the domain NC do not exist in the subordinate NCs, unless they are also domain NCs.  

The application may also receive an "operational error" after the first page.  

A Domain Controller returns subordinate referrals for the following naming contexts:  

1. When Searching the Forest root: Configuration NC (followed by a referral for the Schema NC)
2. When Searching the Forest root: ForestDnsZones NC
3. DomainDnsZones NC
4. All child domains. And recursively all grand-child domains down the whole domain tree.

## Cause

There are multiple problems when chasing referrals during a paged query:

1. When chasing naming contexts that are located on the same server (see 1., and maybe 2. and 3. above), the chasing is happening on the same LDAP session, wiping the paged cookie returned in the primary query in the client LDAP runtime.
2. When the last referral chased also exceeds the page size, the referral cookie received from the last NC chased is used to continue the primary search. This causes the LDAP search to fail with an "operational error" as the cookie does not fit the server knowledge about the index and index position of the search.
3. When the primary search is done using a simple bind without SSL, the chasing of the referrals fails with "operational error", because the LDAP client is designed to not send the clear-text credentials when chasing referrals.

## Resolution

There is currently no resolution for the problem.

You can use the following approaches in your application to avoid the problems:

1. Use a base DN that avoids that the server returns subordinate referrals, for example, search an OU under the domain root object.
2. Search the Global Catalog instead of the forest root domain NC. You need to ensure all attributes you want are present in the GC, and that you really want the whole forest instead of the domain tree you searched previously.
3. If you don't want the referrals to be chased automatically: As referrals are chased by default, use ldap_set_option with flag LDAP_OPT_REFERRALS to turn off referral chasing. You can always chase the referrals manually after completing the primary query.  
4. Use the control LDAP_SERVER_DOMAIN_SCOPE_OID when searching, it turns off continuation referrals when searching domain roots.
