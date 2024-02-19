---
title: Can't install .NET Framework 3.5 on OEM Windows installation
description: Works around an issue in which you cannot install the .NET Framework 3.5 on an OEM Windows installation. This issue occurs when you cannot access the public Internet.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, match, chadbee, v-miand3
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# Can't install the .NET Framework 3.5 without a public Internet environment on an OEM Windows installation

This article provides a workaround for an issue where the Microsoft .NET Framework 3.5 installation fails without a public Internet environment on an OEM Windows installation.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2956772

## Symptoms

Consider the following scenario:

- You have an exclusive network environment that is not connected to the Internet.
- You have a Windows operating system installed from a standard OEM image in this environment. This image may include a combination of languages and the latest updates relevant to the system and environment.
- You try to install the .NET Framework 3.5 or the .NET Framework 3.5 Service Pack 1 (SP1) on this computer.

In this scenario, you receive an error message, and the .NET Framework installation fails.

The .NET Framework installation also fails in one of the following situations:
- You use the stand-alone .NET Framework redistributable package.
- The sources\sxs folder from the original installation media is used as an alternative source.

## Cause

This issue occurs because Windows was designed with the intent that the operating system would have access to the Internet. 

If you cannot access the Internet, the .NET Framework 3.5 has to pull data from an alternative source. If that source does not explicitly match the installing OS (such as a hotfix, hotfix version, or a language pack-specific file that was installed), you will encounter this issue.

## Workaround

To work around this issue, create an installation media that has the .NET Framework 3.5 preinstalled. To do this, follow the steps on the following webpage for each language that will be installed on this operating system:
 [The .NET Framework 4.5 is default and the .NET Framework 3.5 is optional](https://msdn.microsoft.com/library/windows/desktop/hh848079%28v=vs.85%29.aspx) 
Or, you can temporarily connect the computer that needs the .NET Framework 3.5 to the Internet in order to install the .NET Framework.

> [!NOTE]
> You have to perform these steps before you install the language packs. However, hotfixes typically must be installed after the language packs are installed.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section. Currently, an efficient and effective strategy has not been located for existing operating systems. However, this issue is under investigations for future operating systems.

## More information

If you were successful in building an alternative installation source by using an offline OS image, be aware that with this solution, you have to make sure that this alternative source has all updates (hotfixes) applied to it that might be on the target computers together with all language packs. This image has to be kept up-to-date as new updates are released. 

> [!NOTE]
> Some hotfixes can only be obtained by contacting Microsoft directly. These hotfixes should also be considered when you build the installation source if this route is selected. 

Our recommendation regarding the building of installation media (as mentioned in the "Workaround" section) is to build an alternative-source media and test it, as this process has proven expensive considering the time that must be spent. This is compared to creating installation media by using known file versions.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
