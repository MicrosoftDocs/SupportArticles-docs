---
title: Archive mailbox can't be provisioned or deprovisioned after a mailbox is migrated to Office 365 Dedicated/ITAR vNext
description: Provides a resolution for an issue that prevents adding an archive to a mailbox after the mailbox is migrated to Microsoft Office 365 Dedicated/ITAR vNext. 
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Archiving
  - CSSTroubleshoot
ms.reviewer: kellybos
appliesto: 
  - Microsoft Business Productivity Online Dedicated
  - Microsoft Business Productivity Online Suite Federal
search.appverid: MET150
ms.date: 05/05/2025
---

# Archive mailbox can't be provisioned or deprovisioned after a mailbox is migrated to Office 365 Dedicated/ITAR vNext

_Original KB number:_&nbsp;4009935

## Symptom

After a mailbox that doesn't have an archive is migrated to Microsoft Office 365 Dedicated/ITAR vNext, you can't add an archive to the mailbox. You also can't deprovision an archive from a mailbox that was migrated from Dedicated.

If you try to provision an archive mailbox by using Exchange admin center or Remote PowerShell through `enable-mailbox`, you receive the following error message:

> The following error occurred during validation in agent 'Windows LiveId Agent': 'Can't enable the archive for 'John' because this user object is synchronized with the on-premises directory. To enable a cloud-based archive mailbox for this user, you must use your on-premises Exchange admin center or Exchange Management Shell.'

## Cause

When Exchange Online is deployed in a hybrid topology, the system expects all management to be performed through an on-premises Exchange installation. This installation enables the on-premises directory and the online directory to remain in sync.

Many Dedicated users don't have an Exchange Server installed on-premises. But the act of migrating from Dedicated causes the objects to function as though they're part of a hybrid deployment. Although having some Exchange deployment on-premises is recommended for management in order to facilitate an easier migration and lower overall costs, installing Exchange on-premises for the vNext transition isn't required. Therefore, some customers might not be able to manage archives for mailboxes that were migrated from Dedicated. Customers who are provisioned directly into vNext aren't affected.

## Resolution

After a migration, managing archives for mailboxes that were migrated from Dedicated can be performed with scripts that emulate the functionality of an on-premises Exchange deployment.

### Prerequisites

- The Active Directory Module for Windows PowerShell must be installed on the management computer.
- The management computer must have .NET 4.0 or a later version installed.
- The management computer must be domain-joined to the on-premises AD forest of the managed users.
- The operator must have Account Operator permissions or equivalent rights.
- The [enable-remotearchive.ps1](https://download.microsoft.com/download/d/d/6/dd6ca3c4-d212-4d55-9c32-dbff3f1ad611/Enable-RemoteArchive.ps1) and [disable-remotearchive.ps1](https://download.microsoft.com/download/3/d/6/3d61c749-95f9-4ee2-8b8d-834ed7a168f5/Disable-RemoteArchive.ps1) scripts must be on the management computer.

### Provisioning an archive

1. Determine the value for the 'name' property of the user being managed. This is the value that's passed for the **-Identity** parameter of the script.
1. Start PowerShell with the Active Directory Module for Windows PowerShell enabled.
1. Run the following script:

    `Enable-remotearchive.ps1 -Identity 'John'`

1. Wait for Microsoft Entra Connect to synchronize the changes.
Optional: The **ArchiveName** parameter specifies the name of the archive mailbox. This name is displayed to users in Outlook and Outlook on the web. If you don't use this parameter, the default value is **In-Place Archive - \<Mailbox_User_Display_Name>**.

### Deprovisioning an archive

1. Determine the value for the 'name' property of the user being managed. This is the value that's passed as the value for the **-Identity** parameter of the script.
2. Start PowerShell with the Active Directory Module for Windows PowerShell enabled.
3. Run the following script:

    `disable-remotearchive.ps1 -Identity 'John'`

4. Wait for Microsoft Entra Connect to synchronize the changes.
