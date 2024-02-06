---
title: Domain Controllers in-place upgrade hangs at black screen
description: This article describes a problem where domain controllers in-place upgraded hangs at a solid black screen.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: arrenc, herbertm, warrenw, kaushika, joscon
ms.custom: sap:setup, csstroubleshoot
---
# Domain Controllers in-place upgrade hangs at black screen

This article provides a resolution for the issue that Domain Controllers in-place upgrade hangs at black screen.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2843034

## Symptoms

Consider the following scenario:

- You have a computer that is running Windows Server 2008 R2 Server-Core edition
- Server-Core is hosting Domain Controller role
- On Server Core you run in-place upgrade to Windows Server 2012  

In this scenario, the Windows Server 2012 setup upgrade hangs at a solid black screen with a mouse pointer as seen in image below.

:::image type="content" source="media/in-place-upgrade-hangs-black-screen/black-screen.png" alt-text="A black screen together with a mouse pointer.":::

> [!NOTE]
> The problem described in this article is specific to server-core enabled domain controllers that are in-place upgraded to Windows Server 2012 server core. This condition does not occur on GUI or Full-DCs that are in-place upgraded to Windows Server 2012.

## Cause

The NTDSA.DLL & NTDSAI.DLL files are not installed when Windows Server 2008 R2 server core DC is upgraded to Windows Server 2012. This is confirmed through debug and OS image analysis. A Debug session from NTSD attached to LSASS.EXE with loader snaps enabled shows the following sequence while attempting to load NTDSA.DLL

023c:0240 @ 00048468 - LdrpLoadDll - ENTER: DLL name: C:\Windows\system32\ntdsa.dll  
023c:0240 @ 00048468 - LdrpLoadDll - INFO: Loading DLL C:\Windows\system32\ntdsa.dll  
023c:0240 @ 00048468 - LdrpFindOrMapDll - ENTER: DLL name: C:\Windows\system32\ntdsa.dll  
023c:0240 @ 00048468 - LdrpResolveDllName - ENTER: DLL name: C:\Windows\system32\ntdsa.dll  
023c:0240 @ 00048468 - LdrpResolveDllName - RETURN: Status: 0xc0000135  
023c:0240 @ 00048468 - LdrpResolveDllName - ENTER: DLL name: C:\Windows\system32\ntdsa.dll  
023c:0240 @ 00048468 - LdrpResolveDllName - RETURN: Status: 0xc0000135  
023c:0240 @ 00048468 - LdrpFindOrMapDll - RETURN: Status: 0xc0000135  
023c:0240 @ 00048468 - LdrpLoadDll - RETURN: Status: 0xc0000135  
023c:0240 @ 00048468 - LdrLoadDll - RETURN: Status: 0xc0000135  

where the 0xc0000135 status code maps to:

| Hex| Decimal| Symbolic| Friendly error string |
|---|---|---|---|
|0xc0000135|-1073741515|STATUS_DLL_NOT_FOUND|This application has failed to start because %hs was not found. Re-installing the application may fix this problem.|
  
These binaries are installed as part of the "Active Directory Domain Services" optional role. The DirectoryServices-DomainController role is disabled by default and is not enabled because there is no role with that name on the Windows Server 2008 R2 operating system. Since there is nothing to match up among the available Windows Server 2012 manifests, the upgrade hangs.

## Resolution

To resolve the situation where the server is stuck on the upgrade, continue to reboot the server until the rollback to the previous OS version and state is triggered. After the permanent hang at the black screen, reboot the server twice. Setup will detect the failed upgrade attempt and will roll back the system to the previous OS version.

> [!NOTE]
> You should not experience any data loss in this process. Server-core DCs that were healthy and functioning prior to the OS version upgrade attempt should be continue to function.

You can make the in-place upgrade succeed by adding a "Replacement Manifest" to the setup source files. Please contact Microsoft Customer Technical Support to retrieve the manifest. Ensure to reference this article so the agent can provide you with the manifest file free of charge.

These are the steps to follow to use this manifest to upgrade a server Core Domain Controller:  

1. Expand the contents of the CAB file retrieved from Microsoft to get the manifest file "DirectoryServices-DomainController-ServerCoreUpg-Replacement.man".
2. Copy the Windows Server 2012 installation DVD contents to a hard disk folder such as d:\products\ws12.
3. Create a folder d:\products\ws12\sources\replacementmanifests.
4. Place the manifest file retrieved from Microsoft into the new folder.
5. Use the server location created in step 2 as the source for your server upgrade.

#### Workaround

The workaround to get out of this situation if you cannot use the approach mentioned above:  

1. Promote new Windows Server 2012 Server core DCs on different physical or physical machines.
Instead of in-place upgrading existing W2K8 R2 Server core DCs, promote new Windows Server 2012 server core DCs on new physical or virtual machines. Retire the down-level W2K8 R2 server-core DCs as required.

2. Remove the ADDS role on the W2K8 R2 Server core computer prior to the in-place upgrade to Windows Server 2012.

## More information

When the upgrade hangs and you reset the machine, Windows boot loader defaults to booting "Windows Server 2012". You could trigger the rollback in the Windows boot loader by selecting the "Windows Setup Rollback" boot option. You can also boot the machine with the default setting:

:::image type="content" source="media/in-place-upgrade-hangs-black-screen/boot-manager.png" alt-text="Windows boot loader defaults to booting Windows Server 2012.":::

If the "Windows Server 2012" boot option was used, SETUP detects the failed in-place upgrade and automatically triggers the rollback to the previous OS version.

:::image type="content" source="media/in-place-upgrade-hangs-black-screen/upgrade-failed-rollback-started.png" alt-text="SETUP detects the failed in-place upgrade and automatically triggers the rollback to the previous O S version." border="false":::

> [!NOTE]
> The size and aspect ratio of screenshots depicted in this article have been modified for brevity.

You might run into a problem with Internet Explorer after the rewind:

> There was a problem starting iernonce.dll  
> The specified module could not be found.

:::image type="content" source="media/in-place-upgrade-hangs-black-screen/ie-error-at-startup.png" alt-text="There was a problem starting iernonce.dll error occurs after the rewind." border="false":::

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
