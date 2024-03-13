---
title: Table-valued parameter errors when Microsoft Entra Connect is installed on Windows Server 2019
description: Describes an issue in which a Microsoft Entra Connect synchronization generates errors in Windows Server 2019.
ms.date: 03/10/2021
author: genlin
ms.author: genli
ms.reviewer: riantu, nualex, wufrank
ms.service: active-directory
ms.subservice: enterprise-users
---

# Table-valued parameter errors after Microsoft Entra Connect is installed on Windows Server 2019

This article describes a problem in which synchronization errors appear   after Microsoft Entra Connect is installed on Windows Server 2019-based servers.

_Original product version:_&nbsp; Microsoft Entra ID, Windows Server 2019

## Symptoms

You experience one or more of various symptoms, such as password hash sync failures or receiving "staging-error" discovery errors during the import cycle (shown in the following screenshot).

:::image type="content" source="media/tvp-errors-when-AADConnect-installed-on-Windows-Server-2019/sync-service-manager-error.png" alt-text="Screenshot of Synchronization Service Manager that shows a staging error.":::

When this problem occurs, Event ID 6301 is logged in the server Application log, as follows:

>Log Name: Application<br>
>Source: ADSync<br>
>Date: 8/22/2019 11:11:17 PM<br>
>Event ID: 6301<br>
>Task Category: Server<br>
>Level: Error<br>
>Keywords: Classic<br>
>User: N/A<br>
>Computer: AADConnect.contoso.com<br>
>Description: The server encountered an unexpected error in the synchronization engine:<br>
>
>"BAIL: MMS(7996): ..\sql.cpp(7524): 0x80004005 >
(Unspecified error)<br>
>`**`BAIL: MMS(7996): x:\bt\1011518\repo\src\dev\sync\server\sqlstore\rcvtvp.h(158): 0x80004005 (Unspecified error)`**`<br>
>`**`BAIL: MMS(7996): x:\bt\1011518\repo\src\dev\sync\server\sqlstore\rcvtvp.h(52): 0x80004005 (Unspecified error)`**`<br>
>BAIL: MMS(7996): ..\sproc.cpp(1124): 0x80004005 (Unspecified error)<br>
>BAIL: MMS(7996): ..\csobj.cpp(15789): 0x80004005 (Unspecified error)<br>
>BAIL: MMS(7996): ..\tower.cpp(10511): 0x80004005 (Unspecified error)<br>
>BAIL: MMS(7996): x:\bt\1011518\repo\src\dev\sync\server\sqlstore\csobj.h(1379): 0x80004005 (Unspecified error)<br>
>BAIL: MMS(7996): ..\csobj.cpp(1368): 0x80004005 (Unspecified error)<br>
>BAIL: MMS(7996): ..\nscsimp.cpp(531): 0x80004005 (Unspecified error)<br>
>BAIL: MMS(7996): ..\syncstage.cpp(923): 0x80004005 (Unspecified error)<br>
>BAIL: MMS(7996): ..\syncstage.cpp(1666): 0x80004005 (Unspecified error)<br>
>BAIL: MMS(7996): ..\syncstage.cpp(414): 0x80004005 (Unspecified error)<br>
>Azure AD Sync 1.5.45.0"

This event indicates that an error occurs when Microsoft Entra Connect attempts a read or write operation over the LocalDB database by using table-valued parameters.

For more information about table-valued parameters, see [Use Table-Valued Parameters (Database Engine)](/sql/relational-databases/tables/use-table-valued-parameters-database-engine?text=Table-valued%20parameters%20are%20declared,temporary%20table%20or%20many%20parameters).

## Cause

This problem is caused by incompatible language settings for programs that do not support Unicode.

:::image type="content" source="media/tvp-errors-when-AADConnect-installed-on-Windows-Server-2019/region-settings-unicode.png" alt-text="Screenshot of the Region settings where the Use Unicode U T F 8 for worldwide language support option is selected." border="false":::

The service account defaults to UTF-8 for worldwide language support when it is enabled. The LocalDB database version in Windows Server 2019 does not support this format.

## Resolution

To resolve this problem, clear the checkbox next to **Beta: Use Unicode UTF-8 for worldwide language support** (shown in the previous screenshot), and then restart the server.

To change the setting, follow these steps:

1. On the Microsoft Entra Connect server, open Control Panel, and then select **Clock, Language and Region**.  

    :::image type="content" source="media/tvp-errors-when-AADConnect-installed-on-Windows-Server-2019/control-panel-clock-language.png" alt-text="Screenshot of Control Panel with the Clock, Language, and Region option selected.":::

2. Select **Region**.

    :::image type="content" source="media/tvp-errors-when-AADConnect-installed-on-Windows-Server-2019/control-panel-region.png" alt-text="Screenshot of Clock, Language, and Region page with the Region item selected.":::

3. Select the **Administrative** tab, and then select **Change System locale**.

   :::image type="content" source="media/tvp-errors-when-AADConnect-installed-on-Windows-Server-2019/administrative-tab.png" alt-text="Screenshot of the Administrative tab of the Region dialog box with the Language for Non-Unicode Programs area highlighted." border="false":::

4. If the **Use Unicode UTF-8 for worldwide language support** setting is enabled, clear it.

    :::image type="content" source="media/tvp-errors-when-AADConnect-installed-on-Windows-Server-2019/clear-region-settings-unicode.png" alt-text="Screenshot of the Region settings where the Use Unicode U T F 8 for worldwide language support is unselected." border="false":::

5. Select **OK**, and then restart the server.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
