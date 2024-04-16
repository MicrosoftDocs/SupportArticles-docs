---
title: New databases from a secondary DPM server aren't automatically added
description: Fixes an issue in which new databases from a secondary DPM server aren't automatically added for protection to a SQL Server instance.
ms.date: 04/08/2024
ms.reviewer: Mjacquet
---
# New databases from a secondary DPM server aren't automatically added to a SQL Server instance

This article helps you fix an issue in which new databases from a secondary Data Protection Manager (DPM) server aren't automatically added to a SQL Server instance.

_Original product version:_ &nbsp; System Center 2016 Data Protection Manager  
_Original KB number:_ &nbsp; 4456296

## Symptoms

Consider the following scenario:

- You're running Microsoft System Center Data Protection Manager on a primary and secondary server.
- On the primary DPM server, Microsoft SQL Server auto protection is enabled.
- DPM secondary protection is configured to protect the current SQL Server databases under the protected SQL Server instance.

In this scenario, auto protection adds new databases to the SQL Server instance from the primary DPM server, as expected. However, new databases are not automatically added from the secondary DPM server.  

## Resolution

To resolve this problem, enable SQL Server auto protection on the secondary DPM server. To do this, follow these steps:

1. On the secondary DPM server, locate the protection group that's associated with the SQL Server instance you want to auto protect.
2. Right-click the protection group, and then select **Modify Protection Group** to start the wizard.
3. On the **Select Group Members** screen, expand the appropriate server that's running SQL Server.
4. Select the SQL Server instance by selecting the check box next to the name, and then right-click the name.
5. Select the **Turn on auto protection** pop-up window, as shown in the following screenshot.

    :::image type="content" source="media/new-databases-not-automatically-added/turn-on-auto-protection.png" alt-text="Turn on the SQL Server auto protection on the secondary DPM server." border="false":::

    After auto protection is turned on, the screen resembles the following:

    :::image type="content" source="media/new-databases-not-automatically-added/auto-protection-on.png" alt-text="The SQL Server auto protection on the secondary DPM server is turned on." border="false":::

6. Select **Next**, and then continue the **Modify Protection Group** wizard to save the change.

## References

For more information about SQL Server auto protection, see [Add databases to a SQL Server](/previous-versions//hh758042(v=technet.10)?redirectedfrom=MSDN).
