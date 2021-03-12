---
title: Table-valued parameter errors when Azure AD Connect is installed on Windows Server 2019
description: Describes an issue in which an Azure AD Connect synchronization generates errors in Windows Server 2019.
ms.date: 3/10/2021
author: jc-mackin
ms.author: v-jcmackin
ms.reviewer: riantu, nualex, wufrank
editor: 
---

# Table-valued parameter errors when Azure AD Connect is installed on Windows Server 2019

This article describes a problem in which synchronization errors appear   after Azure AD Connect is installed on Windows Server 2019 servers.

_Original product version:_ &nbsp; Azure Active Directory, Windows Server 2019

## Symptoms

Symptoms vary from seeing "staging-error" discovery errors during the import cycle (shown below), to password hash sync failures.

:::image type="content" source="media/tvp-errors-aadconnect-ws19/sync-service-manager-error.png" alt-text="Screenshot of Synchronization Service Manager that shows a staging error.":::
 
What these errors have in common is the presence of event ID 6301 in the server Application event log, with the following error description:

```
Log Name:   Application
Source:    ADSync
Date:     8/22/2019 11:11:17 PM
Event ID:   6301
Task Category: Server
Level:     Error
Keywords:   Classic
User:     N/A
Computer:   AADConnect.contoso.com
Description:
The server encountered an unexpected error in the synchronization engine:

 "BAIL: MMS(7996): ..\sql.cpp(7524): 0x80004005 (Unspecified error)
**BAIL: MMS(7996): x:\bt\1011518\repo\src\dev\sync\server\sqlstore\rcvtvp.h(158): 0x80004005 (Unspecified error)**
**BAIL: MMS(7996): x:\bt\1011518\repo\src\dev\sync\server\sqlstore\rcvtvp.h(52): 0x80004005 (Unspecified error)**
BAIL: MMS(7996): ..\sproc.cpp(1124): 0x80004005 (Unspecified error)
BAIL: MMS(7996): ..\csobj.cpp(15789): 0x80004005 (Unspecified error)
BAIL: MMS(7996): ..\tower.cpp(10511): 0x80004005 (Unspecified error)
BAIL: MMS(7996): x:\bt\1011518\repo\src\dev\sync\server\sqlstore\csobj.h(1379): 0x80004005 (Unspecified error)
BAIL: MMS(7996): ..\csobj.cpp(1368): 0x80004005 (Unspecified error)
BAIL: MMS(7996): ..\nscsimp.cpp(531): 0x80004005 (Unspecified error)
BAIL: MMS(7996): ..\syncstage.cpp(923): 0x80004005 (Unspecified error)
BAIL: MMS(7996): ..\syncstage.cpp(1666): 0x80004005 (Unspecified error)
BAIL: MMS(7996): ..\syncstage.cpp(414): 0x80004005 (Unspecified error)
Azure AD Sync 1.5.45.0"
```

This event indicates an error when attempting an operation (read/write) over the SQL database by using table-valued parameters.

>For more information on table-valued parameters, visit [Use Table-Valued Parameters (Database Engine) - SQL Server | Microsoft Docs](https://docs.microsoft.com/sql/relational-databases/tables/use-table-valued-parameters-database-engine?text=Table-valued%20parameters%20are%20declared,temporary%20table%20or%20many%20parameters).

## Cause
The root cause of this issue is related to language settings for programs that do not support Unicode.

:::image type="content" source="media/tvp-errors-aadconnect-ws19/region-settings-unicode.png" alt-text="Screenshot of region language settings with the option selected to use Unicode U T F 8 for worldwide language support .":::
 
The service account defaults to UTF-8 for worldwide language support when it is enabled, and the SQL database version in Windows Server 2019 does not support this format.

## Resolution
To resolve this issue, clear the checkbox next to **Beta: Use Unicode UTF-8 for worldwide language support** (shown in the image above), and then restart the server.
Follow these steps to change the setting:
1.	On the Azure AD Connect server, open Control Panel and select **Clock, Language and Region**.

:::image type="content" source="media/tvp-errors-aadconnect-ws19/control-panel-clock-language.png" alt-text="Screenshot of Control Panel with Clock, Language, and Region highlighted."::: 

2.	Then, select **Region**.

:::image type="content" source="media/tvp-errors-aadconnect-ws19/control-panel-region.png" alt-text="Screenshot of Control Panel Clock, Language, and Region page with Region highlighted.":::
 
3.	Select the **Administrative** tab, and then click **Change System locale…** button.

:::image type="content" source="media/tvp-errors-aadconnect-ws19/administrative-tab.png" alt-text="Screenshot of the Administrative tab of the Region dialog box with the Language for Non-Unicode Programs area highlighted.":::
 
4.	If the **Use Unicode UTF-8 for worldwide language support** setting is enabled, uncheck it. Click **OK** and then restart the server.

:::image type="content" source="media/tvp-errors-aadconnect-ws19/region-settings-unicode.png" alt-text="Screenshot of region language settings with the option selected to use Unicode U T F 8 for worldwide language support .":::

## More information
Still need help? Go to [Microsoft Community](https://answers.microsoft.com/en-us) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/Forums/en-US/home?forum=windowsazuread) website.

