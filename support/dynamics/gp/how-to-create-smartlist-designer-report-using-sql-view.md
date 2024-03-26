---
title: How to create Smartlist Designer report using SQL view
description: How to create a Smartlist Designer report using a SQL view.
ms.reviewer: theley, cwaswick
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# How to create a Smartlist Designer report using a SQL view

This article introduces how to create a Smartlist Designer report using a SQL view in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4014658

> [!NOTE]
> The steps below assume that you have already created the view.

## Create a Smartlist Designer report using a SQL view

1. Run `grant.sql` against the Company database and the Dynamics database before attempting the steps below.

    > [!NOTE]
    > The default location for this SQL script would be similar to C:\Program Files\Microsoft Dynamics\GP\SQL\Util\grant.sql.  

2. Open SmartList (Select **Smartlist** under **Microsoft Dynamics GP**)
3. Select **New** to open Smartlist Designer.
4. Enter the **List Name** you want to name it.
5. For **Product**, select **Microsoft Dynamics GP** at the top of the pick list.
6. For **Series**, select the module the list will be for.
7. In the left margin for **Database View**, scroll to the bottom and expand **Views**, then expand **Company** and the view list will load.
8. Mark the **check box** next to the SQL view you wish to use. (You can also expand the view and select specific columns within that view too if you wish. All are marked by default.)

    > [!NOTE]
    > You can do formatting such as adding decimal places or dollar signs to amount fields by creating a calculated field. Select the **Fx** button in the header for the **Selected Fields** section to open the Calculated Fields window. Select **Add**. Name the calculated field. Select the type of Currency, Date, Integer, Long Integer or string. Select the field under **Table Fields**, and use the **Functions** and **Constants** to build your expression at the bottom of the window. (For decimals, you may select a type of currency, and use the Function for Arithmetic and multiply (*) the field by .00001 or how many you need). **Save**. Select **OK** on the message and **OK** at the top of the Calculated fields window to insert the field to your report.

9. Select Execute Query to see the results of your report.
10. Select **OK** to save your report. (It may take some time to process and create it.)
11. Run `grant.sql` again against the Company database and Dynamics database. (otherwise only the `sa` user will have access to it.)

Or, you could also add a tag to your view so it will work for other users. Example:

```console
go

grant select on  [YOURVIEWNAME] TO  DYNGRP
```
