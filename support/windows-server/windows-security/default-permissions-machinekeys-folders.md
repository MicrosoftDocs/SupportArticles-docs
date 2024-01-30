---
title: Default permissions for MachineKeys folders
description: Describes default permissions for the MachineKeys folders.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:permissions-access-control-and-auditing, csstroubleshoot
ms.subservice: windows-security
---
# Default permissions for the MachineKeys folders

This article describes default permissions for the MachineKeys folders.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 278381

## Summary

The MachineKeys folder stores certificate pair keys for both the computer and users. Both Certificate services and Internet Explorer use this folder. The default permissions on the folder may be misleading when you attempt to determine the minimum permissions that are necessary for proper installation and the accessing of certificates.

## Default permissions for MachineKeys folder

The MachineKeys folder is located under the `All Users Profile\Application Data\Microsoft\Crypto\RSA` folder. If the administrator didn't set the folder to the minimum level, a user may receive the following errors when generating a server certificate by using Internet Information Server (IIS).:

- **Failed to Generate Certificate Request**
- **Internal Server Error** (The Private Key that you are importing might require a cryptographic service provider that is not installed on your system)

The following settings are the default permissions for the MachineKeys folder:

- Administrators (Full Control) This folder only
- Everyone (Special) This folder only

## Permissions for Everyone group

To view the special permissions for the Everyone group, right-click the **MachineKeys** folder, select **Advanced** on the **Security** tab, and then select **View/Edit**. The permissions consist of the following permissions:

- List Folder/Read Data
- Read Attributes
- Read Extended Attributes
- Create Files/Write Data
- Create Folders/Append Data
- Write Attributes
- Write Extended Attributes
- Read Permissions

Select the **Reset Permissions on all Child objects and enable propagation of inheritable permissions** check box. The administrator doesn't have full control on child objects to protect a user's private part of the key pair. But the administrator can still delete certificates for a user.

For more information, see the following article:

[How to set required NTFS permissions and user rights for an IIS 5.0, IIS 5.1, or IIS 6.0 Web server](https://support.microsoft.com/help/271071).
