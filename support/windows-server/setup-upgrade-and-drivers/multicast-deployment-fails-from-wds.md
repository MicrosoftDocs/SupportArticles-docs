---
title: Multicast deployment fails from WDS
description: Provides a solution to an issue where deploying an image from a Windows Deployment Services (WDS) server by using multicast fails.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, scottmca
ms.custom: sap:windows-adk-installation, csstroubleshoot
---
# Multicast Deployment Fails from Windows Deployment Services

This article provides a solution to an issue where deploying an image from a Windows Deployment Services (WDS) server by using multicast fails.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2582106

## Symptoms

When deploying an image from a WDS server using multicast, you may encounter one or more of the following issues
- The multicast session never completes
- The multicast session produces an error message
- The multicast session is slow. If you change the deployment to unicast, it works. 

## Cause

There are many possible causes for a multicast deployment to fail.  One possible reason is that the network router/switches do not handle IP fragmentation properly. 

## Resolution

To change WDS so that it does not send fragmented packets, do the following:

**Windows Server 2008 R2**  
Set the following registry key and restart the WDSService
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WDSServer\Providers\WDSMC\Protocol
Name: ApBlockSize
Value type: REG_DWORD
Value data: 1385 decimal

**Windows Server 2008**  
Windows Server 2008 uses network profiles to control the settings.  Do the following to configure it to not send fragmented packets
1. Click Start, Run, WdsMgmt.msc
2. Right-click the WDS server and choose properties
3. Choose the network settings tab
4. Change the network profile to custom

Set the following registry key and restart the WDSService
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WDSServer\Providers\WDSMC\Profiles\Custom
Name: ApBlockSize
Value type: REG_DWORD
Value data: 1385 decimal

If this allows the multicast transmission to complete you can, then modify the TpCacheSize registry key below to increase the performance.  If you decrease ApBlockSize without increasing TpCacheSize, then overall performance will decrease. Basically ApBlockSize * TpCacheSize = the maximum bandwidth that can be achieved.

**Windows Server 2008 R2**  
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WDSServer\Providers\WDSMC\Protocol
Name: TpCacheSize
Value type: REG_DWORD
Value data: 3145 decimal

**Windows Server 2008**  
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WDSServer\Providers\WDSMC\Profiles\Custom
Name: TpCacheSize
Value type: REG_DWORD
Value data: 3145 decimal

Restart the WDSServer service after setting this registry key.
After setting this run a deployment to verify, it completes and take note of the time to download the image.  Then increase this value in increments until it fails or reaches 7550.   

If you have to disable IP fragmentation to get multicast working, then this may be indicative of low-end switching/routing hardware that perhaps does not support fragmentation efficiently or does not support multicast efficiently (IGMP/MLD snooping etc.).  Multicast can be demanding on a network so it can expose problems or issues in network infrastructure that were unknown until multicast was set up. 

## More information

Other possible reasons for multicast failures include

- Make sure the WDS server hardware is sized properly.  Especially the amount of RAM and network cards.  For more information on recommended hardware requirements, see [Optimizing Performance and Scalability](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732088(v=ws.10))
- If the WDS server is Windows Server 2008 R2 check the Multicast Tab and verify what the "Transfer settings" is set to.
- If larger images fail but smaller images work it may be due to timeouts.  For instance, on Cisco switches the default value for ip igmp query-interval is 60 seconds, which means that the switch will stop forwarding multicast traffic to the port after 3 * 60 = 180 seconds if it doesn't see any IGMP traffic.  Contact your switch vendor for how to configure these timeouts.
- The default Multicast range in WDS is 239.0.0.1 to 239.0.0.254.  Depending on the network, this may not work.  Change the range to 239.192.0.2 to 239.192.0.250 or check with your network administrator for an unused range
- Test with different machines.  A machine participating in the multicast stream that has a bad NIC can cause problems with multicast completing

For more information on optimizing and troubleshooting, see [Optimizing Performance and Scalability](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732088(v=ws.10))

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
