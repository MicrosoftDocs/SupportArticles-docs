---
title: Archive mailbox can't be provisioned or deprovisioned after a mailbox is migrated to Office 365 Dedicated/ITAR vNext
description: Describes an issue that prevents you from adding an archive to a mailbox after the mailbox is migrated to Microsoft O365 Dedicated/ITAR vNext. Provides a resolution.
author: helenclu
ms.author: luche
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

After a mailbox that does not have an archive is migrated to Microsoft Office 365 Dedicated/ITAR vNext, you cannot add an archive to the mailbox. You also cannot deprovision an archive from a mailbox that was migrated from Dedicated.

If you try to provision an archive by using Exchange Admin Center or Remote PowerShell through `enable-mailbox`, you receive the following error message:

> The following error occurred during validation in agent 'Windows LiveId Agent': 'Can't enable the archive for 'John' because this user object is synchronized with the on-premises directory. To enable a cloud-based archive mailbox for this user, you must use your on-premises Exchange admin center or Exchange Management Shell.'

## Cause

When Exchange Online is deployed in a hybrid topology, the system expects all management to be performed through an on-premises Exchange installation. This enables the on-premises directory and the online directory to remain in sync.

Many Dedicated users don't have Exchange Server installed on-premises. But the act of migrating from Dedicated causes the objects to function as though they are part of a hybrid deployment. Although having some Exchange deployment on-premises is recommended for management in order to facilitate an easier migration and lower overall costs, installing Exchange on-premises for the vNext transition is not required. Therefore, some customers may be unable to manage archives for mailboxes that were migrated from Dedicated.

> [!NOTE]
> This does not apply to users who are provisioned directly into vNext.

## Resolution

After a migration, managing archives for mailboxes that were migrated from Dedicated can be performed with scripts that emulate the functionality of an on-premises Exchange deployment.

### Prerequisites

- The Active Directory Module for Windows PowerShell must be installed on the management computer.
- The management computer must have .NET 4.0 or a later version installed.
- The management computer must be domain-joined to the on-premises AD forest of the users who will be managed.
- The operator must have Account Operator permissions or equivalent rights.
- The [enable-remotearchive.ps1](https://download.microsoft.com/download/d/d/6/dd6ca3c4-d212-4d55-9c32-dbff3f1ad611/Enable-RemoteArchive.ps1) and [disable-remotearchive.ps1](https://download.microsoft.com/download/3/d/6/3d61c749-95f9-4ee2-8b8d-834ed7a168f5/Disable-RemoteArchive.ps1) scripts must be on the management computer.

### Provisioning an archive

1. Determine the value for the 'name' property of the user being managed. This step will be passed as the value for the **-Identity** parameter of the script.
1. Start PowerShell with the Active Directory Module for Windows PowerShell enabled.
1. Run the following script:

    `Enable-remotearchive.ps1 -Identity 'John'`

1. Wait for Microsoft Entra Connect to synchronize the changes.Optional: The
 **ArchiveName** parameter specifies the name of the archive mailbox. This is the name displayed to users in Outlook and Outlook Web App (OWA). If you don't use this parameter, the default value is **In-Place Archive - \<Mailbox_User_Display_Name>**.

### Deprovisioning an archive

1. Determine the value for the 'name' property of the user being managed. This step will be passed as the value for the **-Identity** parameter of the script.
2. Start PowerShell with the Active Directory Module for Windows PowerShell enabled.
3. Run the following script:

    `disable-remotearchive.ps1 -Identity 'John'`

4. Wait for Microsoft Entra Connect to synchronize the changes.
