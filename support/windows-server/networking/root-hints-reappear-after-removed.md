---
title: Root hints reappear after removed
description: When you delete the last root hint from a DNS server, one or more of the deleted root hints may reappear after about 15 minutes.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, Dpracht, v-tea
ms.custom: sap:dns, csstroubleshoot
---
# Root hints reappear after they are removed

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 818020

## Symptoms

When you use DNS Manager or the **dnscmd** command to delete the last root hint from a Microsoft DNS server, one or more of the deleted root hints may reappear after about 15 minutes. You do not receive a warning that the root hints are not deleted permanently.

> [!Note]
> Microsoft does not support the removal of all root hints from a Microsoft DNS server. A Microsoft DNS server must have at least one root hint. However, you can replace the existing root hints with new root hints. When you replace root hints, the change is permanent, and the old root hints do not reappear. If the DNS server if forwarding, click to select the **Do not use recursion for this domain** check box on the **Forwarders** tab in DNS Manager to make sure that the root hints will not be used.

## Cause

The root hints can be removed permanently and completely by removing the root hints from the DNS Manager, the CACHE.DNS file and from Active Directory. The root hints come back in this scenario is because the root hints still exist in the other two locations (CACHE.DNS file and Active Directory).

## Status

This behavior is by design.

## More information

When a DNS server is not a root server, you must specify root hints in the form of at least one name server (NS) resource record, and you must indicate a root DNS server and a corresponding host (A) resource record for that root DNS server. Otherwise, the DNS server cannot contact the root DNS server on startup and cannot answer queries for names outside its own authoritative zones.

Root hints are a list of the DNS servers on the Internet that your DNS servers can use to resolve queries for names that it does not know. When a DNS server cannot resolve a name query by using its local data, it uses its root hints to send the query to a DNS server. DNS servers that try to locate and to find other DNS servers must have these hints.

To update root hints on the DNS server, follow these steps:

1. Click **Start**, click **Administrative Tools**, and then click **DNS**.
2. In the console tree, click the applicable DNS server.
3. On the **Action** menu, click **Properties**.
4. Click the **Root Hints** tab.
5. Use any of the following methods to modify server root hints:

   - To add a root server to the list, click **Add**, and then specify the name and the IP address of the server that you want to add to the list.
   - To modify a root server in the list, click **Edit**, and then specify the name and the IP address of the server that you want to modify in the list.
   - To remove a root server from the list, select it in the list, and then click **Remove**.
   - To copy root hints from a DNS server, click **Copy from server**, and then specify the IP address of the appropriate DNS server that you want to copy for a list of root servers to use in resolving queries. These root hints will not overwrite any existing root hints.
