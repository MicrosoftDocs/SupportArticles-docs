---
title: Reduced performance after SMB Encryption or SMB Signing is enabled
description: Describes an issue in which networking performance is reduced after you enable SMB Encryption or SMB Signing in Windows Server 2016 and Windows Server 2019. Provides a solution to this issue.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# Reduced networking performance after you enable SMB Encryption or SMB Signing in Windows Server 2016 and Windows Server 2019

This article provides a solution to an issue where networking performance is reduced after you enable Server Message Block (SMB) Encryption or SMB Signing in Windows Server 2016 and Windows Server 2019. Windows Server 2022 improves network performance for this scenario.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2019, Windows Server 2022  
_Original KB number:_ &nbsp; 4458042

## Symptoms

You use a network adapter that has remote direct memory access (RDMA) enabled. After you enable SMB Signing or SMB Encryption, the network performance of SMB Direct together with the network adapter is significantly reduced.

In addition, one or more of the following Event IDs may be logged:

```output
Log Name:      Microsoft-Windows-SMBClient/Operational  
Source:        Microsoft-Windows-SMBClient  
Event ID:      30909  
Level:         Informational  
Description:  
The client supports SMB Direct (RDMA) and SMB Signing is in use.  
Share name:ShareName  
Guidance:  
For optimal SMB Direct performance, you can disable SMB Signing. This configuration is less secure and you should only consider this configuration on trustworthy private networks with strict access control.
```

```output
Log Name:      Microsoft-Windows-SMBClient/Operational  
Source:        Microsoft-Windows-SMBClient  
Event ID:      30910  
Level:         Informational  
Description:  
The client supports SMB Direct (RDMA) and SMB Encryption is in use.  
Share name: <Share name>  
Guidance:  
For optimal SMB Direct performance, you can disable SMB Encryption on the server for shares accessed by this client. This configuration is less secure and you should only consider this configuration on trustworthy private networks with strict access control.
```

```output
Log Name:      Microsoft-Windows-SmbClient/Security  
Source:        Microsoft-Windows-SMBClient  
Event ID:      31016  
Level:         Warning  
Description:  
The SMB Signing registry value is not configured with default settings.  
Default Registry Value:  
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\\Parameters]
"EnableSecuritySignature"=dword:1  
Configured Registry Value:  
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\\Parameters]
"EnableSecuritySignature"=dword:0  
Guidance:  
Even though you can disable, enable, or require SMB Signing, the negotiation rules changed starting with SMB2 and not all combinations operate like SMB1.  
The effective behavior for SMB2/SMB3 is:  
Client Required and Server Required = Signed  
Client Not Required and Server Required = Signed  
Server Required and Client Not Required = Signed  
Server Not Required and Client Not Required = Not Signed  
When requiring SMB Encryption, SMB Signing is not used, regardless of settings. SMB Encryption implicitly provides the same integrity guarantees as SMB Signing.
```

## Cause

Several features such as Storage Spaces Direct (S2D) or Cluster Shared Volumes (CSV) use SMB as a protocol transport for intra-cluster communication. Therefore, the performance of S2D may be significantly affected by enabling SMB Signing or SMB Encryption that uses the RDMA network adapter.

When either SMB Signing or SMB Encryption is enabled, SMB stops using RDMA direct data placement (also known as RDMA read/write). This is a fallback policy, and this behavior is by design for the highest level of security. Therefore, SMB falls back to use the RDMA connection in a purely send-and-receive mode. Data flows in a non-optimal path because the maximum MTU limit is 1,394 bytes. This causes message fragmentation and reassembly, and overall decreased performance.

This issue may occur after you follow the [Security baseline for Windows 10 v1607 ("Anniversary Update") and Windows Server 2016](/archive/blogs/secguide/security-baseline-for-windows-10-v1607-anniversary-edition-and-windows-server-2016) to enable SMB Signing.

Or, if you use the following Group Policy settings to enable SMB Signing:

- Microsoft network server - Digitally sign communications (always) - ENABLED
- Microsoft network client - Digitally sign communications (always) - ENABLED

## Resolution

SMB Signing and SMB Encryption have some trade-offs in performance. If network performance is important to your deployment scenarios (such as with Storage Spaces Direct), we recommend that you not deploy SMB Signing and SMB Encryption.

Windows Server 2022 SMB Direct now supports encryption. Data is encrypted before placement, leading to relatively minor performance degradation. Furthermore, Windows Server 2022 failover clusters now support granular control of encrypting intra-node storage communications for Cluster Shared Volumes (CSV) and the storage bus layer (SBL). This means that when using Storage Spaces Direct and SMB Direct, you can decide to encrypt east-west communications within the cluster itself for higher or lower security on a per SMB instance basis.

If you are deploying in a highly secure environment with Windows Server 2016 and Windows Server 2019, we recommend that you apply the following configurations:

1. Do not deploy by using RDMA-enabled network adapters, or disable RDMA by using the `Disable-NetAdapterRdma` cmdlet.

2. Based on the SMB client and SMB server version, evaluate the most appropriate solution to optimize performance. Be aware that SMB Signing provides message integrity, and SMB Encryption provides message integrity plus privacy to provide the highest level of security.

    - **SMB 3.0 (introduced with Windows Server 2012/Windows 8)** - SMB Signing will deliver better performance than SMB Encryption.
    - **SMB 3.1 (introduced with Windows Server 2016/Windows 10)** - SMB Encryption will deliver better performance than SMB Signing, and has the added benefit of increased security together with message privacy in addition to message integrity guarantees.


