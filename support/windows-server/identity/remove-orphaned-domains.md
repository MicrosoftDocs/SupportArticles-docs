---
title: How to remove orphaned domains from Active Directory
description: Describes how to remove domain meta-data from Active Directory if this procedure isn't used or if or all domain controllers are taken offline but not demoted first.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Active Directory backup, restore, or disaster recovery
ms.technology: windows-server-active-directory
---
# How to remove orphaned domains from Active Directory  

_Original product version:_ &nbsp;Windows 10, Windows Server 2012 R2  
_Original KB number:_ &nbsp;230306

## Summary

Typically, when the last domain controller for a domain is demoted, the administrator selects the **This server is the last domain controller in the domain** option in the DCPromo tool, which removes the domain meta-data from Active Directory. This article describes how to remove domain meta-data from Active Directory if this procedure isn't used or if or all domain controllers are taken offline but not demoted first.

> [!CAUTION]
> The administrator must verify that replication has occurred since the demotion of the last domain controller before manually removing the domain meta-data. Using the NTDSUTIL tool improperly can result in partial or complete loss of Active Directory functionality.

## Removing Orphaned Domains from Active Directory

1. Determine the domain controller that holds the Domain Naming Master Flexible Single Master Operations (FSMO) role. To identify the server holding this role:
    1. Start the Active Directory Domains and Trusts Microsoft Management Console (MMC) snap-in from the **Administrative Tools** menu.
    2. Right-click the root node in the left pane titled **Active Directory Domains and Trusts**, and then click **Operations Master**.
    3. The domain controller that currently holds this role is identified in the Current Operations Master frame.
        > [!NOTE]
        > If this changed recently, not all computer may have received this change yet due to replication.

    For more information about FSMO roles, click the following article number to view the article in the Microsoft Knowledge Base:

    [197132](https://docs.microsoft.com/troubleshoot/windows-server/identity/fsmo-roles) Windows 2000 Active Directory FSMO Roles  
2. Verify that all servers for the domain have been demoted.
3. Click **Start**, point to **Programs** > **Accessories**, and then click **Command Prompt**.
4. At the command prompt, type: *ntdsutil*.
5. Type: *metadata cleanup*, and then press Enter.
6. Type: *connections*, and then press Enter. This menu is used to connect to the specific server on which the changes will occur. If the currently logged-on user isn't a member of the Enterprise Admins group, alternate credentials can be supplied by specifying the credentials to use before making the connection. To do so, type: set creds domainname username password, and then press Enter. For a null password, type: null for the password parameter.
7. Type: *connect to server **servername*** (where **servername** is the name of the domain controller holding the Domain Naming Master FSMO Role), and then press Enter. You should receive confirmation that the connection is successfully established. If an error occurs, verify that the domain controller being used in the connection is available and that the credentials you supplied have administrative permissions on the server.
8. Type: *quit*, and then press Enter. The **Metadata Cleanup** menu is displayed.
9. Type: *select operation target*, and then press Enter.
10. Type: *list domains*, and then press Enter. A list of domains in the forest is displayed, each with an associated number.
11. Type: *select domain **number***, and then press Enter, where **number** is the number associated with the domain to be removed.
12. Type: *quit*, and then press Enter. The **Metadata Cleanup** menu is displayed.
13. Type: *remove selected domain*, and then press Enter. You should receive confirmation that the removal was successful. If an error occurs, refer to the Microsoft Knowledge Base for articles on specific error messages.
14. Type: *quit* at each menu to quit the NTDSUTIL tool. You should receive confirmation that the connection disconnected successfully.

## References

For more information about the NTDSUTIL tool, see the Support Tools documentation located in the Support\Reskit folder on the Windows 2000 CD-ROM. The Help files included with the *Microsoft Windows 2000 Resource Kit* contain a **Books Online** link. You can click the link for information that describes the NTDSUTIL tool in greater detail.

For more information about the removal of domain controllers from the domain that you're attempting to delete, click the following article number to view the article in the Microsoft Knowledge Base:

[216498](https://support.microsoft.com/help/216498) How to remove data in Active Directory after an unsuccessful domain controller demotion
