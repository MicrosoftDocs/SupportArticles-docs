---
title: How to set full-screen in Internet Explorer
description: This article describes how to set Internet Explorer so that it always starts in full-screen mode or so that it never starts in full-screen mode.
ms.date: 03/08/2020
ms.custom: sap:Internet Explorer
---
# How to set Internet Explorer to always start in full-screen mode or to never start in full-screen mode

[!INCLUDE [](../../../includes/browsers-important.md)]

Sometimes, Internet Explorer may not open in full-screen mode. This happens after you close Internet Explorer when it is not in full-screen mode.

This article helps you make Internet Explorer always open in full-screen mode or never open in full-screen mode, regardless of how it was closed previously.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 968870

## Always start Internet Explorer in full-screen mode

### Method 1: Edit the registry to make Internet Explorer always start in full-screen mode

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Click **Start**, type regedit in the **Start Search** box, and then press ENTER. If you are prompted for an administrator password or for confirmation, type your password, or click **Continue**. Then, click **OK**.

2. Locate and then click the following subkey in Registry Editor:  
   `HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main`

3. Locate and then double-click **FullScreen** in the right pane.

4. Type *yes* in the **Data data** field, and then click **OK**.
    > [!NOTE]
    > If the FullScreen value does not exist in the right pane, manually create a new string value with **Value name** as **FullScreen** and **Value data** set to **Yes**.

5. Exit Registry Editor.

### Method 2: Use the Group Policy Object Editor to make Internet Explorer always start in full-screen mode

1. Click **Start**, click **Run**, type *gpedit.msc* in the **Open** box, and then click **OK**.

2. Expand **Computer Configuration**, expand **Administrative Templates**, expand **Windows Components**, and then click **Internet Explorer**.

3. In the right pane, double-click the **Enforce fullscreen mode** setting.

4. Click **Enabled**, and then click **OK**.

5. Exit the Group Policy Object Editor.

## Never start Internet Explorer in full-screen mode

### Method 1: Edit the registry to make Internet Explorer never start in full-screen mode

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Click **Start**, type regedit in the **Start Search** box, and then press ENTER. If you are prompted for an administrator password or for confirmation, type your password, or click **Continue**. Then, click **OK**.

2. Locate and then click the following subkey in Registry Editor:  
   `HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main`

3. Locate and then double-click **FullScreen** in the right pane.

4. Type _no_ in the **Data data** field, and then click **OK**.

5. Exit Registry Editor.

### Method 2: Use the Group Policy Object Editor to make Internet Explorer never start in full-screen mode

1. Click **Start**, click **Run**, type gpedit.msc in the **Open** box, and then click **OK**.

2. Expand **Computer Configuration**, expand **Administrative Templates**, expand **Windows Components**, and then click **Internet Explorer**.

3. In the right pane, double-click the **Enforce fullscreen mode** setting.

4. Click **Disabled**, and then click **OK**.

5. Exit the Group Policy Object Editor.
