---
title: Can't sign in to Lync client in limited functionality mode
description: Troubleshooting sign-in issues in which users in a routing group cannot sign in to a Lync client or they sign in to the client in limited functionality mode in a Lync Server 2013 environment. These issues occur when Windows Fabric replicas are insufficient for the routing group.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: mahesha, miadkins, rdubois, premgan, landerl, bwilson, brandber, dahans
appliesto: 
  - Lync Server 2013
ms.date: 03/31/2022
---

# Can't sign in to a Lync client or signs in to the client in limited functionality mode in a Lync Server 2013 environment

## Symptoms

A user in a routing group may experience the following issues in a Microsoft Lync Server 2013 environment. These issues occur because the Windows Fabric replicas that are available for the routing group are insufficient or because of back-end server connectivity problems. 

### Issue 1

When a primary replica of the routing group is unavailable, the user cannot sign in to a Lync client. This may be because one or more servers in a pool shutdown or have connectivity problems.

### Issue 2

Assume that the primary replica is available, but a secondary replica and a Backup secondary replica are unavailable. In this situation, the user will sign in to a Lync client in limited functionality mode. 

This issue occurs because the operation data that requires Windows Fabric writes cannot be replicated to a secondary replica. 

This issue will also occur when the connection to the back-end server is not available or when a pool failover is in progress.

> [!NOTE]
> In limited functionality mode, the user cannot perform operations in the Lync client, such as adding contacts, changing presence status, or scheduling conferences. 

## Resolution

To resolve these issues, you must perform the following operations:

- Check if there are any servers that are unexpectedly shut down or have connectivity problems. If so, then you must start the servers.   
- Check if there are connectivity issues between front-end servers and the back-end server. If so, then try to resolve the issues.    

To resolve the sign-in and limited functionality mode issues that are caused by lack of replicas, you must obtain information on Windows Fabric replica instances for the routing group service. To do this, run the following command in Windows PowerShell:

```powershell
Get-CsPoolFabricState -PoolFqdn < FQDN > -Verbose -Type Routing 
```

This will output primary replica and secondary replicas that the routing groups lack. For example, the following information may be displayed:

```adoc
Service: (P) fabric:/lync/routing/E71E41AD8A345CCCA2493484208565C7 has no primaries.
Service: (P) fabric:/lync/routing/9B1B879D216B5D6C9035E86CEAAE1231 has no primaries.

VERBOSE: Service: (P) fabric:/lync/routing/F9E606A825395422B3BF7A01ECBB7B1F has insufficient secondary replicas (Expected: 2, Current: 0) 
```

If there are any issues causing the replicas to be missing on the front-end servers, try to resolve any issues that prevent the servers from starting, and then start the front-end servers. If the front-end servers do not start, then you can perform a quorum loss recovery reset by running the following command:

```powershell
Reset-CsPoolRegistrarState -PoolFqdn -ResetType QuorumLossRecovery
```

> [!NOTE]
> This command will finish within 30 minutes. After that, replicas will be put on available servers in the pool.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
