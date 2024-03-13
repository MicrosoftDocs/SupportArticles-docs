---
title: Deploy GP in a Terminal Server environment
description: Discusses how to deploy Microsoft Dynamics GP and Microsoft Business Solutions - Great Plains in a Terminal Server environment.
ms.reviewer: jcirks, kyouells
ms.topic: how-to
ms.date: 03/13/2024
---
# How to deploy Microsoft Dynamics GP and Microsoft Business Solutions - Great Plains in a Terminal Server environment

This article discusses tips to deploy Microsoft Dynamics GP and Microsoft Business Solutions - Great Plains in a Terminal Server environment.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 872242

## Introduction

Follow these tips when you deploy Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains in a Terminal Server environment.

## More information

- We recommend that you've a dedicated server that is running Microsoft SQL Server and a dedicated server that has Terminal Server or that has Terminal Services enabled.
- Verify that the terminal server meets the system requirements. To see descriptions of the system requirements, see [System Requirements for Microsoft Dynamics GP 2018](/dynamics/s-e/gp/mdgp2018_system_requirements)

- Citrix can also be installed in the environment. However, Citrix isn't required.
- When you install Microsoft Dynamics GP onto a terminal server, make sure that you're a local administrator and that you start the installation in Add or Remove Programs.
- If you've modified dictionaries that are shared on the server, we recommend that you put the modified dictionaries onto the server that is running Terminal Server. Modified dictionaries are dictionary files such as the Reports.dic file and the Forms.dic file.
- Microsoft Product Support Services supports the default configuration for Microsoft Dynamics GP. In this configuration, remote workstations start Microsoft Dynamics GP from the installation folder that is located on the terminal server. Remote workstations don't use user profiles or roaming profiles for the Dex.ini file or for the Dynamics.set file. Instead, remote workstations use the same Dex.ini and Dynamics.set files that are located in the installation folder.
- When you set up Named Printers on a Terminal Server environment, you should consider the following situations:
  - Named Printers is machine-based. This utility stores a computer ID in the Dex.ini file for each workstation. Additionally, all settings apply only to the current workstation. So in a Terminal Server environment, all users share the same settings because the users are using the same workstation.
  - We don't recommend that you use Workstation Printers with Named Printers because the Workstation Printers can change depending on which computer is used to sign in to a Terminal Server session. It's best to select only printers that are permanently visible to Terminal Server.
  - You can set up printers on a user basis. It enables different users to have different configurations on a single Terminal Server workstation.
  - If you're using multiple application folders on one Terminal Server or on multiple Terminal Servers, make sure that each Terminal Server has its own computer ID. You might need to manually edit the ST_MachineID setting in the Dex.ini file and then individually configure Named Printers on each instance of Terminal Server.
  - For a simple site where all users have the same printers defined, use System or Company class printers to set up Named Printers as if it's a single workstation.
  - For a more complex site where several remote locations access the server, you should use user class printers. You should do it so that each user has an individual configuration defined. However, when you use a user class printer, you must define it for all users. It may be time-consuming. Usually, all the users from a single remote location will want the same configuration. Named Printers lets you quickly set this up. To do it, you have to use Template Users feature in Named Printers.
  - For more information about setting up named printers, see the SystemAdminGuide.pdf file.
- Don't use the local hard disk on the remote workstations for the placement of the Dex.ini file or of the Dynamics.set file. This configuration will create performance issues.

## Notes

Many Microsoft Dynamics GP processes read back to the Dex.ini file.

Put the Dynamics.set file and all dictionary files that are listed in the Dynamics.set file onto the server that is running Terminal Server.

- When you set up named printers for users who access Microsoft Dynamics GP by using Terminal Services, visit [System Requirements for Microsoft Dynamics GP 2018](/dynamics/s-e/gp/mdgp2018_system_requirements) to verify that the printer and the printer driver are supported.

- Printer drivers that will be used by a remote workstation must be installed on the server that is running Terminal Server before the remote workstation signs in to that server.
