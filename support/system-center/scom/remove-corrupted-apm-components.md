---
title: Remove corrupted APM components
description: Describes how to resolve issues that may affect IIS and SharePoint servers by removing possibly corrupted APM components in System Center 2016 Operations Manager.
ms.date: 03/12/2024
ms.reviewer: michjohn, jarrettr
---
# Resolve issues by removing APM components in System Center 2016 Operations Manager

This article describes how to resolve issues that may affect Internet Information Services (IIS) and SharePoint servers by removing possibly corrupted Application Performance Monitoring (APM) components in Microsoft System Center 2016 Operations Manager.

_Original product version:_ &nbsp; System Center 2016 Operations Manager  
_Original KB number:_ &nbsp; 4457771

## Symptoms

You may experience issues that occur between System Center 2016 Operations Manager and the default installed APM feature. These issues may affect IIS and SharePoint servers.

For more information about these issues, see the following blog articles:

- [SCOM 2016 Agent Crashing Legacy IIS Application Pools](https://kevingreeneitblog.blogspot.com/2017/03/scom-2016-agent-crashing-legacy-iis.html)
- [APM fix for agent crashing issue shipped in UR3 is not completely resolved](https://techcommunity.microsoft.com/t5/system-center-blog/apm-fix-for-agent-crashing-issue-shipped-in-ur3-is-not/ba-p/351819)
- [Update on APM fix for agent crashing issue shipped in UR3](https://techcommunity.microsoft.com/t5/system-center-blog/update-on-apm-fix-for-agent-crashing-issue-shipped-in-ur3/ba-p/351820)

## Download the agent management pack

To resolve issues that may be caused by corrupted APM components, you can remove the components and then reinstall them. If you don't use the APM feature, you can completely remove the APM components.

Typically, you can uninstall the Operations Manager agent and then reinstall it by using the `NOAPM=1` command-line parameter. This can be a challenging task if you have hundreds or thousands of deployed agents. However, you can easily remove the APM components from the deployed agents by using the agent management pack (SCOM.Management.10.19.10349.0).

## Determine which agents have APM installed

This management pack has a class property in the state view that is named **APM Installed** to help you determine which agents still have the APM components installed (installed by default).

:::image type="content" source="media/remove-corrupted-apm-components/apm-installed.png" alt-text="Screenshot of the APM Installed property that shows which agents have APM installed.":::

## Repair or upgrade an agent

To repair or upgrade an agent, use the **Execute any PowerShell** task.

To repair an existing Operations Manager agent and remove the APM components, run the following command:

```console
msiexec.exe /fvomus "\\server\share\agents\scom2016\x64\MOMagent.msi" NOAPM=1
```

To upgrade an existing Operations Manager agent, such as to upgrade the agent from System Center 2012 Operations Manager to System Center 2016 Operations Manager, run the following command:

```console
msiexec.exe /i "\\server\share\agents\scom2016\x64\MOMagent.msi" NOAPM=1 AcceptEndUserLicenseAgreement=1
```

> [!NOTE]
> You must put the MOMAgent.msi file on a share that your domain computer accounts have access to. The agent will connect to the share as the Local System account. Therefore, you have to make sure that these domain computer accounts have access at the share permission and NTFS permission. For example, grant **Read** permissions to everyone, or grant **Read** permissions to authenticated users.

The following image is an example of a repair task.

:::image type="content" source="media/remove-corrupted-apm-components/repair-task.png" alt-text="Screenshot of a repair task example.":::

This task runs a lightweight repair or upgrade (depending on which command that you choose) of the agent, but changes only the `NOAPM=1` switch. The result is that all settings remain unchanged. The task only removes the APM service and components.

You can run such a command across hundreds of agents in a short time. Also, you can multi-select and then run this task on many agents at the same time.

## Remove APM - Method 1

If you have no plans to use the APM feature in System Center 2016 Operations Manager, you might want to consider removing the maintenance packs that are imported by default. Maintenance packs such as the following discover many instances of sites, services, and classes in which APM components are installed on the agents:

- Microsoft.SystemCenter.DataWarehouse.ApmReports.Library (Operations Manager APM Reports Library)
- Microsoft.SystemCenter.Apm.Web (Operations Manager APM Web)
- Microsoft.SystemCenter.Apm.Wcf (Operations Manager APM WCF Library)
- Microsoft.SystemCenter.Apm.NTServices (Operations Manager APM Windows Services)
- Microsoft.SystemCenter.Apm.Infrastructure.Monitoring (Operations Manager APM Infrastructure Monitoring)
- Microsoft.SystemCenter.Apm.Library (Operations Manager APM Library)
- Microsoft.SystemCenter.Apm.Infrastructure (Operations Manager APM Infrastructure)

Delete the maintenance packs if you don't use the APM feature.

Before you can delete the **Microsoft.SystemCenter.Apm.Infrastructure** maintenance pack, you have to remove a **RunAs** account profile association, and then clean up the `SecureReference` library manually by you delete the reference.

To do this, follow these steps:

1. In the Administrator pane, select **Run As Configuration**, and then select **Profiles** in the Data Warehouse account.
2. In the **Run As accounts** section, remove the **Operations Manager APM Data Transfer Service**.

   :::image type="content" source="media/remove-corrupted-apm-components/remove-class.png" alt-text="Screenshot of removing a class in Run As accounts.":::

3. Manually export the **Microsoft.SystemCenter.SecureReferenceOverride** maintenance pack, and make a backup copy.
4. Edit the maintenance pack by using an XML editor.
5. Delete the reference to the **Microsoft.SystemCenter.Apm.Infrastructure** maintenance pack.

   :::image type="content" source="media/remove-corrupted-apm-components/edit-maintenance-pack.png" alt-text="Screenshot of deleting the reference to the Microsoft.SystemCenter.Apm.Infrastructure.":::

6. Save your changes, and then reimport the maintenance pack.

## Remove APM - Method 2

You can disable discoveries if you don't use the APM feature.

:::image type="content" source="media/remove-corrupted-apm-components/disable-discoveries.png" alt-text="Screenshot of disabling discoveries.":::

Then, run the `Remove-SCOMDisabledClassInstance` cmdlet in your Operations Manager command shell. This removes all the discovered instances that you don't use.  

[!INCLUDE [Third-party contact disclaimer](../../includes/third-party-contact-disclaimer.md)]
