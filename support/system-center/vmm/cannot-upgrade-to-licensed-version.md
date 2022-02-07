---
title: Can't upgrade App Controller to a licensed version
description: Fixes a problem that prevents you from upgrading the evaluation version of System Center 2012 App Controller to the licensed version.
ms.date: 08/18/2020
ms.reviewer: sturwale, richrund
---
# You can't upgrade an evaluation version of App Controller to a licensed version

This article helps you fix an issue where you can't upgrade App Controller from an evaluation version to a licensed version if Microsoft .NET Framework version 3.5 isn't installed.

_Original product version:_ &nbsp; Microsoft System Center 2012 App Controller, System Center 2012 R2 App Controller  
_Original KB number:_ &nbsp; 2908312

## Symptoms

If you don't provide a product key during Microsoft System Center 2012 App Controller installation, App Controller is installed as an evaluation version. If you later decide to upgrade to a licensed version and therefore rerun the setup, the **Upgrade from evaluation license** link isn't displayed as expected.

## Cause

This issue may occur if .NET Framework version 3.5 isn't installed on the App Controller server.

## Resolution

To resolve this issue, follow these steps:

1. Open Server Manager, and then start the **Add Roles and Features** wizard.
2. On the Features page, expand **.NET Framework 3.5 Features**.
3. Select the **.NET Framework 3.5** check box (this includes .NET Framework 2.0 and 3.0).
4. Click **Next** > **Install** > **Close**.
5. Run App Controller Setup, and then click **Upgrade from evaluation license**.

    :::image type="content" source="media/cannot-upgrade-to-licensed-version/add-controller-setup-window.png" alt-text="Select the Upgrade from evaluation license in App Controller Setup." border="false":::

6. Follow the steps in the wizard. On the last page of the wizard, you receive the following error message:

    > The default cmdlet processor must be assigned a non-null value before this call can be made. Assign the non-null valued default cmdlet processor to the DefaultCmdletProcessor property on the 'Microsoft.SystemCenter.SetupFramework.Common.CmdletProcessor' type and try this call again.

    This is the expected behavior.

    :::image type="content" source="media/cannot-upgrade-to-licensed-version/default-cmdlet-processor-must-be-assigned-a-non-null-value.png" alt-text="Error that occurs when you run the last page of the Add Roles and Features wizard." border="false":::

7. Click **OK** in response to the error message, open **IIS Manager**, and then restart the AppController website.

You should now have a licensed version of App Controller.

## More information

For more information, see [Release notes for App Controller in System Center 2012 R2](/previous-versions/system-center/system-center-2012-R2/dn296670(v=sc.12)?redirectedfrom=MSDN).
