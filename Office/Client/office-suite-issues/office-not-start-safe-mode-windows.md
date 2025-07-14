---
title: Office doesn't start when Windows runs in safe mode
description: Describes an issue that prevents Office applications from starting and that triggers an error at startup when Windows is running in safe mode. Provides a workaround.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: tasitae
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - DownloadInstall\InstallErrors\AppLaunchErrors
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Outlook 2016
  - Word 2016
  - Excel 2016
  - OneNote 2016
  - PowerPoint 2016
  - Access 2016
  - Outlook 2013
  - Word 2013
  - Excel 2013
  - OneNote 2013
  - PowerPoint 2013
  - Access 2013
ms.date: 06/06/2024
---
# Office applications don't start when Windows is running in safe mode

_Original KB number:_ &nbsp; 3140179

## Symptoms

When you try to open an Office 2016 or Office 2013 application, such as Outlook, Word, Excel, PowerPoint, OneNote, or Access, one of the following errors may be displayed, depending on the installation type of Office.

- Click-to-Run installation type:

    > Something went wrong
    > We couldn't start your program. Please try starting it again.
    > If it won't start, try repairing Office from 'Programs and Features' in the Control Panel.

    :::image type="content" source="media/office-not-start-safe-mode-windows/error-for-c2r-installation.png" alt-text="Screenshot shows the error message for the Click-to-Run installation type.":::

- MSI-based installation type:

  > Microsoft Office can't find your license for this application. A repair attempt was unsuccessful or was cancelled. Microsoft Office will now exit.

  :::image type="content" source="media/office-not-start-safe-mode-windows/error-for-msi-installation.png" alt-text="Screenshot shows the error message for the M S I-based installation type.":::

## Cause

This issue occurs when you try to start an Office 2016 or Office 2013 application while Microsoft Windows is running in safe mode.

## Workaround

To work around this issue, start Windows by using the **Selective Startup** option in **System Configuration** instead of safe mode. The steps to configure **Selective Startup** vary, depending on your Office installation type.

- Click-to-Run installation type:

    1. Open **System Configuration**. To do this, press the Windows Key + R to open a **Run** dialog box. Type *msconfig*, and then click **OK**.
    2. Select **Selective startup**, and then clear the **Load system services** and **Load startup items** check boxes.

       :::image type="content" source="media/office-not-start-safe-mode-windows/selective-startup-for-c2r-installation.png" alt-text="Screenshot to clear the Load system services and Load startup items check boxes.":::

    3. Click the **Services** tab.
    4. Select the **Microsoft Office ClickToRun Service** check box.

       :::image type="content" source="media/office-not-start-safe-mode-windows/c2r-service.png" alt-text="Screenshot to select the Microsoft Office ClickToRun Service check box.":::

    5. Click **OK**.
    6. If you're prompted, click **Restart**.

       :::image type="content" source="media/office-not-start-safe-mode-windows/restart-button.png" alt-text="Screenshot to select the Restart option in the System Configuration window.":::

- MSI-based installation type:

    1. Open **System Configuration**. To do this, press the Windows Key + R to open a **Run** dialog box. Type *msconfig*, and then click **OK**.
    2. Select **Selective startup**, and then clear the **Load system services** and **Load startup items** check boxes.

       :::image type="content" source="media/office-not-start-safe-mode-windows/selective-startup-for-msi-installation.png" alt-text="Screenshot to clear the Load system services and Load startup items check boxes for M S I-based installation type.":::

    3. Click **OK**.
    4. If you're prompted, click **Restart**.

       :::image type="content" source="media/office-not-start-safe-mode-windows/restart-button.png" alt-text="Screenshot to select the Restart option in System Configuration.":::

When you have finished troubleshooting and no longer need to run in **Selective startup**, return to **Normal startup** by following these steps:

1. Open **System Configuration**. To do this, press the Windows Key + R to open a **Run** dialog box. Type *msconfig*, and then click **OK**.
2. Select **Normal startup**.
3. Click **OK**.
4. If you're prompted, click **Restart**.

## More information

To determine whether your Office installation is Click-to-Run or MSI-based, follow these steps:

1. Start an Office application, such as Outlook or Word.
2. On the **File** menu, select **Account** or **Office Account**.
3. For Office Click-to-Run installations, an **Update Options** item is displayed. For MSI-based installations, the **Update Options** item isn't displayed.

    | Click-to-Run Office installation| MSI-based Office installation |
    |---|---|
    |:::image type="content" source="media/office-not-start-safe-mode-windows/update-option-for-c2r-installation.png" alt-text="Screenshot shows the Update Options item is displayed for Click-to-Run installation.":::|:::image type="content" source="media/office-not-start-safe-mode-windows/no-update-option-for-msi-installation.png" alt-text="Screenshot shows the Update Options item isn't displayed for M S I-based installation.":::|
