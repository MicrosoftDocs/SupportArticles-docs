---
title: Remove orphaned domains from AD
description: This article describes how to remove domain meta-data from Active Directory.
ms.date: 08/10/2020
author: delhan
ms.author: Deland-Han
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Active Directory backup, restore, or disaster recovery
ms.technology: ActiveDirectory
---
# Remove orphaned domains from Active Directory  

This article describes how to remove domain meta-data from Active Directory.

_Original product version:_ &nbsp; Windows Server  
_Original KB number:_ &nbsp; 230306

## Summary

Typically, when the last domain controller for a domain is demoted, the administrator selects **This server is the last domain controller in the domain** option in the DCPromo tool, which removes the domain meta-data from Active Directory. This article describes how to remove domain meta-data from Active Directory if this procedure is not used or if or all domain controllers are taken offline but not demoted first.

> [!CAUTION]
> The administrator must verify that replication has occurred since the demotion of the last domain controller before manually removing the domain meta-data. Using the NTDSUTIL tool improperly can result in partial or complete loss of Active Directory functionality.

## Remove orphaned domains

1. Determine the domain controller that holds the Domain Naming Master Flexible Single Master Operations (FSMO) role. To identify the server holding this role:

    1. Start the Active Directory Domains and Trusts Microsoft Management Console (MMC) snap-in from the Administrative Tools menu.
    2. Right-click the root node in the left pane titled **Active Directory Domains and Trusts**, and then click **Operations Master**.
    3. The domain controller that currently holds this role is identified in the Current Operations Master frame.

    > [!NOTE]
    > If this changed recently, not all computer may have received this change yet due to replication.

    For more information about FSMO roles, see [Active Directory FSMO roles in Windows](https://support.microsoft.com/help/197132).

2. Verify that all servers for the domain have been demoted.
3. Click **Start**, point to **Programs**, point to **Accessories**, and then click **Command Prompt**.
4. At the command prompt, type *ntdsutil*.
5. Type `metadata cleanup`, and then press ENTER.
6. Type `connections`, and then press ENTER. This menu is used to connect to the specific server on which the changes will occur. If the currently logged-on user is not a member of the Enterprise Admins group, alternate credentials can be supplied by specifying the credentials to use before making the connection. To do so, type `set creds domainname username password`, and then press ENTER. For a null password, type null for the password parameter.

7. Type `connect to server <servername>` (where \<servername> is the name of the domain controller holding the Domain Naming Master FSMO Role), and then press ENTER. You should receive confirmation that the connection is successfully established. If an error occurs, verify that the domain controller being used in the connection is available and that the credentials you supplied have administrative permissions on the server.

8. Type `quit`, and then press ENTER. The **Metadata Cleanup** menu is displayed.
9. Type `select operation target`, and then press ENTER.
10. Type `list domains`, and then press ENTER. A list of domains in the forest is displayed, each with an associated number.
11. Type `select domain <number>`, and then press ENTER, where \<number> is the number associated with the domain to be removed.
12. Type `quit`, and then press ENTER. The **Metadata Cleanup** menu is displayed.
13. Type `remove selected domain`, and then press ENTER. You should receive confirmation that the removal was successful. If an error occurs, please refer to the Microsoft Knowledge Base for articles on specific error messages.
14. Type `quit` at each menu to quit the NTDSUTIL tool. You should receive confirmation that the connection disconnected successfully.

## References

For more information about the NTDSUTIL tool, see the Support Tools documentation located in the `Support\Reskit` folder on the Windows CD-ROM. The Help files included with the Microsoft Windows Resource Kit contain a Books Online link. You can click the link for information that describes the NTDSUTIL tool in greater detail.

For more information about the removal of domain controllers from the domain that you are attempting to delete, see [Clean up Active Directory Domain Controller server metadata](/windows-server/identity/ad-ds/deploy/ad-ds-metadata-cleanup).
