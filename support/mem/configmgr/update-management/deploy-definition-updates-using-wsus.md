---
title: Deploy Windows Defender definition updates using WSUS
description: Describes how to use Windows Server Update Services to deploy definition updates to computers that are running Windows Defender.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Use WSUS to deploy definition updates to computers that are running Windows Defender

This article describes how to use Microsoft Windows Server Update Services (WSUS) to deploy definition updates to computers that are running Microsoft Windows Defender.

_Original product version:_ &nbsp; Windows Server Update Services  
_Original KB number:_ &nbsp; 919772

## Deploy Windows Defender definition updates

To do this, follow these steps:

1. Open the WSUS Administrator console, and then select **Options** at the bottom of the console tree.
2. Select **Products and Classifications** and verify that the **Windows Defender** check box is selected under the **Products** tab.
3. Verify that the **Definition Updates** check box is selected under the **Classifications** tab, and then select **OK**.

4. Optional: approve the updates by using an automatic approval rule. To do this, follow these steps:
   1. At the bottom of the console tree, select **Options**.
   2. Select **Automatic Approvals**.
   3. Under step 1, select **New Rule...**, and then select the **When an update is in a specific classification** check box and the **When an update is in a specific product** check box.
   4. Under step 2, select **Any classification** > **Definition Updates**, then click **OK**.
   5. Next, select **Any product** and clear the **All Products** check box, then scroll down and select **Windows Defender**, afterward select **OK**.

5. At the bottom of the console tree, select **Synchronizations**.
6. On the action pane on the left, select **Synchronize now**.
7. At the top of the console tree, select **Updates**.
8. Approve any Windows Defender updates that WSUS should deploy.
