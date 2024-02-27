---
title: AD DS configuration operations fail
description: Describes an issue in which you receive a domain controller configuration error in Windows Server 2012.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, nedpyle
ms.custom: sap:dcpromo-and-the-installation-of-domain-controllers, csstroubleshoot
---
# "The service cannot be started" error during AD DS configuration

This article provides help to an error (The service cannot be started) that occurs when Active Directory Domain Services (AD DS) configuration fails.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2737880

## Symptoms

In Windows Server 2012, one of the following AD DS configuration operations fails:

- Configuring a new domain controller by using Server Manager or the AddsDeployment Windows PowerShell module
- Removing AD DS from an existing domain controller by using Server Manager or the AddsDeployment Windows PowerShell module
- Cloning a virtualized domain controller by using dccloneconfig.xml

When the configuration fails, you receive the following error message:
> The service cannot be started, either because it is disabled or it has no enabled devices associated with it.

Additionally, you see that the Dcpromoui.log file contains the following line of text:
> Enter GetErrorMessage 80070422

## Cause

This issue occurs because an administrator configured the "startup type" for the DS Role Server service (DsRoleSvc) to **disabled**. You can confirm this by using the Services.msc snap-in to examine the **Startup type**  list on the **General** tab.

By default, the DS Role Server service is installed during AD DS role installation and is set to the Manual startup type.

## Resolution

To resolve this issue, make sure that the DS Role Server service is not disabled. To do this, use Services.msc or Sc.exe to set the startup type to Manual and to let the DS Role Server operations start and stop the service on demand. For example, run the following command from an Administrator elevated command prompt:

```console
sc.exe config dsrolesvc start= demand
```

> [!NOTE]
> The space after the "start=" argument is intentional.

## More information

This behavior is by design.

The DS Role Server service is new to Windows Server 2012 and is used to install or remove Active Directory or to clone domain controllers.
