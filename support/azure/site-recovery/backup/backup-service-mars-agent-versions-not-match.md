---
title: Azure Backup service version and Microsoft Azure Recovery Services Agent versions do not match
description: Provides a solution to an issue in which Azure Backup service and Microsoft Azure Recovery Services Agent versions do not match (0x1FBD3).
ms.date: 08/14/2020
ms.service: azure-site-recovery
ms.author: jarrettr
author: JarrettRenshaw
ms.reviewer: 
ms.custom: sap:I need help with Azure Backup
---
# Azure Backup service version and Microsoft Azure Recovery Services Agent versions do not match

This article describes the symptoms and resolution for an issue that occurs in these two scenarios:

- Back up files and System State by using the Microsoft Azure Recovery Services Agent
- Back up data to Azure by using System Center Data Protection Manager or Azure Backup Server

_Original product version:_ &nbsp; Azure Site Recovery, Azure Backup  
_Original KB number:_ &nbsp; 4096064

## Symptoms

The following error message appears on the **Errors** tab of the **Job Details** dialog box that corresponds to a failed Backup job on the Azure Recovery Services Agent console, Data Protection Manager, or Azure Backup Server console for Azure Recovery Services Agent version numbers below 2.0.9083.0.

> Azure Backup service version and Microsoft Azure Recovery Services Agent do not match. Please install the latest version of Microsoft Azure Recovery Services Agent from the Microsoft Download Center (<https://go.microsoft.com/fwlink/?linkid=225925>). If the issue persists, please contact Microsoft Support (0x1FBD3).

The following is a sample of this error:

:::image type="content" source="media/backup-service-mars-agent-versions-not-match/failed-backup-job-error.png" alt-text="Screenshot of a failed Backup error in Job Details dialog box." border="false":::

## Cause

This issue occurs because the Microsoft Azure Recovery Services Agent is outdated.

## Resolution

To resolve this issue, follow these steps:

1. Close the Microsoft Azure Recovery Services Agent console.

    > [!IMPORTANT]
    > If the server or the server's proxy has limited Internet access, follow steps 2 to 4. Otherwise, go to step 5.
2. To configure the firewall settings as mentioned earlier, run the following command from an elevated command prompt:

    ```console
    net stop obengine
    ```

3. Make sure that the firewall settings on the server or proxy are configured to allow the URL that is appropriate to the Azure cloud that you are using.

    - [Azure Cloud (Public)](https://login.windows.net)
    - [Azure China Cloud](https://login.chinacloudapi.cn)
    - [Azure US Government Cloud](https://login.microsoftonline.us)
    - [Azure German Cloud](/previous-versions/azure/germany/germany-welcome)

4. Run the following command from an elevated command prompt:

    ```console
    net start obengine
    ```

5. Download the [latest version of Azure Backup Agent](https://go.microsoft.com/fwlink/?linkid=229525) to the server that has the issue.
6. Run the installer. The Microsoft Azure Recovery Services Agent Upgrade Wizard opens.

    :::image type="content" source="media/backup-service-mars-agent-versions-not-match/azure-recovery-services-agent-upgrade-wizard.png" alt-text="Screenshot of the Microsoft Azure Recovery Services Agent Upgrade Wizard." border="false":::

7. Click **Next**.
8. Click **Upgrade**.

    :::image type="content" source="media/backup-service-mars-agent-versions-not-match/upgrade-installation.png" alt-text="Screenshot of upgrade installation of the Microsoft Azure Recovery Services Agent." border="false":::

    The final confirmation screen indicates that Azure Backup Agent has been successfully updated.
9. Close the wizard.
10. Open the MARS Agent Console.
11. In the right side of the console, click **Back up Now**  in the "Actions"**** pane, and then check if Backup is running successfully.

## Next steps

There could be other servers in your Backup environment that contain an Azure Recovery Services agent that is older than version 2.0.9083.0 and may face a similar issue.
Follow the guidance in [Updating Azure Backup agents](https://blogs.technet.microsoft.com/srinathv/2018/01/17/updating-azure-backup-agents/) to identify and update Azure Recovery Services agent.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
