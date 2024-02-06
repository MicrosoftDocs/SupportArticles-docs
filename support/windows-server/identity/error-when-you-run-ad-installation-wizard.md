---
title: Error when you run AD Installation Wizard
description: Describes an issue that may occur if you run the Adprep.exe command-line tool from the wrong Windows Server 2003 installation CD.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, fszita, v-jomcc
ms.custom: sap:schema-update-failure-or-conflict, csstroubleshoot
---
# Error when you run the Active Directory Installation Wizard: The version of the Active Directory schema of the source forest is not compatible with the version of Active Directory on this computer

This article provides a solution to an error that occurs when you try to run the Active Directory Installation Wizard.

_Applies to:_ &nbsp; Window Server 2003  
_Original KB number:_ &nbsp; 917385

## Symptoms

When you try to run the Active Directory Installation Wizard on a Microsoft Windows Server 2003 R2 server, the wizard does not finish, and you may receive the following error message:

> The Active Directory Installation Wizard cannot continue because the forest is not prepared for installing Windows Server 2003. Use the Adprep command-line tool to prepare both the forest and the domain. For more information about using the Adprep, see Active Directory Help.
>
> The version of the Active Directory schema of the source forest is not compatible with the version of Active Directory on this computer.

## Cause

This issue may occur when Active Directory has not been updated with the Windows Server 2003 R2 schema extensions.

## Resolution

To resolve this issue, run the `adprep.exe /forestprep` command from the Windows Server 2003 R2 installation disk 2 on the schema master. To do this, insert the Windows Server 2003 R2 installation disk 2, and then type the command: `<Drive>:\CMPNENTS\R2\ADPREP\adprep.exe /forestprep`.

## More information

The correct version of the ADPrep.exe tool for Windows Server 2003 R2 is 5.2.3790.2075.

You can verify the operating system support level of the schema by looking at the value of the **Schema Version** registry subkey on a domain controller. You can find this subkey in the following location:  
`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters`

You can also verify the operating system support level of the schema by using the Adsiedit.exe utility or the Ldp.exe utility to view the objectVersion attribute in the properties of the cn=schema,cn=configuration,dc= **\<domain>** partition. The value of the **Schema Version** registry subkey and the objectVersion attribute are in decimal.

Schema Version ObjectVersion values and corresponding operating system support level:

- 13=Microsoft Windows 2000
- 30=Original release version of Microsoft Windows Server 2003 and Microsoft Windows Server 2003 Service Pack 1 (SP1)
- 31=Microsoft Windows Server 2003 R2

### Windows Server 2003 R2 installation disks

Windows Server 2003 R2 comes on two installation disks. Installation disk 1 contains a slip-streamed version of Windows Server 2003 with Service Pack 1 (SP1). Installation disk 2 contains the Windows Server 2003 R2 files. If the computer has Windows Server 2003 SP1 installed, you may only have to run installation disk 2 to upgrade to Windows Server 2003 R2.

Installation disk 2 is specific to the edition of Windows Server 2003. For example, you must use a Windows Server 2003 R2, Standard Edition installation disk to upgrade a Windows Server 2003, Standard Edition-based computer. Installation disk 2 contains installation files for the x86-based version and the x64-based version of Windows Server 2003 R2.

The Adsiedit.exe utility and the Ldp.exe utility are included with Windows Server 2003 R2 support tools. To install support tools, run Suptools.msi from the \Support\Tools folder on installation disk 1.
