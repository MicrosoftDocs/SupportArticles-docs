---
title: Menus for a third-party product don't appear in the by Menu view of the Advanced Security window
description: Provides a Dexterity code example resolve the problem where menus for a third-party product appear in Microsoft Dynamics GP but do not appear in the by Menu view of the Advanced Security window.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Menus for a third-party product appear in Microsoft Dynamics GP but do not appear in the "by Menu" view of the Advanced Security window

This article provides a Dexterity code example to an issue where menus for a third-party product appear in Microsoft Dynamics GP but do not appear in the "by Menu" view of the Advanced Security window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 927701

## Introduction

Third-party developers can use Dexterity in Microsoft Dynamics GP to add menu items to the standard menu structure. In some cases, the menus appear in Microsoft Dynamics GP. But the menus do not appear in the **by Menu** view of the Advanced Security window.

## More information

Advanced Security in Microsoft Dynamics GP uses the syMenuMstr (SY07110) table to read the menu structure for the **by Menu** view. Therefore, the menu entries for the product must exist in the syMenuMstr table. The example code in the Microsoft Dynamics GP Integration Guide has a check to make sure that menus are not added two times to the table when the LoadMode is set to MENULOAD_TOTABLE. For more information, see Chapter 22, "Menus in Microsoft Dynamics GP" in Part 5, "Navigation." The check in the example code is as follows.

```vb
If LoadMode = MENULOAD_TOTABLE then
    {Find out whether the menu items exist in the Menu Master table.}
    If MenusExistForProduct(IG_PROD_ID) of form syMenuObj = True Then
        {Do not need to add the menu items}
        AddMenuItems = False;
    End If;
End If;
```

If you are adding or changing menu entries for the product, you can run the following Microsoft SQL Server statement. The following SQL Server statement removes the entries and enables them to be re-added to the table by using the code.

```sql
DELETE FROM SY07110 WHERE CmdParentDictID = XXX OR CmdDictID = XXX /* Where XXX is the Dexterity product ID. */
```

The commands that are used in the menus must be linked directly to a form. Or, if they are linked to a script that opens a form, the Security Form must be selected.

If Advanced Security is unable to identify the form, Advanced Security cannot control access to the form from the **by Menu** view. However, the form is still available in the **by Dictionary** view.
