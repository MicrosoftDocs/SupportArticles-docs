---
title: The LsaLookupSids function may return the old user name instead of the new user name if the user name has changed
description: Describes a cache update delay in Windows.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Active Directory\User, computer, group, and object management, csstroubleshoot
---
# The LsaLookupSids function may return the old user name instead of the new user name if the user name has changed

This article describes a cache update delay in Windows.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 946358

## Symptoms

Consider the following scenario:  

- On the domain member computer, an application calls the **LsaLookupSids** function to translate a security identifier (SID) to a user name.
- The user name has been changed on a domain controller.

In this scenario, the **LsaLookupSids** function may return the old user name instead of the new user name. This behavior may prevent the application from working correctly.

## Cause

The local security authority (LSA) caches the mapping between the SID and the user name in a local cache on the domain member computer. The cached user name isn't synchronized with domain controllers. The LSA on the domain member computer first queries the local SID cache. If an existing mapping is already in the local SID cache, the LSA returns the cached user name information instead of querying the domain controllers. This behavior is intended to improve performance.

The cache entries do time out, however chances are that recurring queries by applications keep the existing cache entry alive for the maximum lifetime of the cache entry.

## Workaround

To work around this issue, disable the local SID cache on the domain member computer. To do this, follow these steps:

1. Open Registry Editor.

   To do this in Windows XP or in Windows Server 2003, click **Start**, click **Run**, type *regedit*, and then click **OK**.

   To do this in Windows Vista and newer, Click **Start**, type *regedit* in the **Start Search** box, and then press ENTER.

2. Locate and then right-click the following registry subkey:  
   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa`
3. Point to **New**, and then click **DWORD Value**.
4. Type LsaLookupCacheMaxSize, and then press ENTER.
5. Right-click **LsaLookupCacheMaxSize**, and then click **Modify**.
6. In the **Value data** box, type 0, and then click **OK**.
7. Exit Registry Editor.

> [!NOTE]
> The LsaLookupCacheMaxSize registry entry sets the maximum number of cached mappings that can be saved in the local SID cache. The default maximum number is 128. When the LsaLookupCacheMaxSize registry entry is set to 0, the local SID cache is disabled.

## Status

The behavior is by design.

## More information

The LSA maintains a SID cache on domain member computers. This cache stores mappings between SIDs and user names. If the SID information exists in the local cache, the LSA returns the cached user name information instead of checking whether the user name has changed.

The local SID cache helps reduce domain controller workload and network traffic. However, inconsistency may occur between the local cache and the domain controllers.

## References

TechNet has an article that covers Sid-Name resolution approaches, including a detailed description of this cache:

[How SIDs and Account Names Can Be Mapped in Windows](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff428139(v=ws.10))  

For more information about the **LsaLookupSids** function, visit the following Microsoft Web site:

[LsaLookupSids function](/windows/win32/api/ntsecapi/nf-ntsecapi-lsalookupsids)
