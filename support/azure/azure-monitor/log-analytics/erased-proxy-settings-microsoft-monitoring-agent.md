---
title: Fix erased proxy settings in the Microsoft Monitoring Agent
description: Learn how to troubleshoot proxy settings that were erased for the Microsoft Monitoring Agent because of System Center Operations Manager integration.
ms.date: 01/31/2022
ms.reviewer: irfanr, v-leedennis
editor: v-jsitser
ms.service: azure-monitor
ms.subservice: logs-troubleshoot
keywords:
#Customer intent: As an Azure Monitor user, I want to troubleshoot why the proxy settings for my Microsoft Monitoring Agent have disappeared so that I can connect to my Azure Log Analytics workspace to interact with System Center Operations Manager data.
---
# Troubleshoot erased proxy settings in the Microsoft Monitoring Agent

This article helps you troubleshoot connection problems between Microsoft Monitoring Agent and Azure Log Analytics. It describes the scenarios in which integration with System Center Operations Manager causes your Microsoft Monitoring Agent proxy settings to be erased.

## Symptoms

After Microsoft Monitoring Agent connects to an Operations Manager management group, you find that the proxy settings for your agent setup are erased.

Specifically, you open the **Microsoft Monitoring Agent Properties** dialog box (in the **Microsoft Monitoring Agent** item in Control Panel, or by running *C:\\Program Files\\Microsoft Monitoring Agent\\Agent\\AgentControlPanel.exe*), select the **Proxy Settings** tab, and notice the following message:

> If this computer requires a HTTP proxy server for connecting to Azure Log Analytics, please enter the details here.

Also, the **Use a proxy server** option is cleared, and the **Proxy Server** box is empty.

## Cause 1: Operations Manager uses a different proxy address

Operations Manager specifies a different proxy address than the proxy address that was used for Microsoft Monitoring Agent. To verify this scenario, take the steps that are listed in the following table, in the given order.

| Action | Steps |
| ------ | ----- |
| Verify that Microsoft Monitoring Agent is integrated with Operations Manager | <ol><li>Sign in to the computer that runs the Microsoft Monitoring Agent that you're investigating. </li><li>Open *C:\\Program Files\\Microsoft Monitoring Agent\\Agent\\AgentControlPanel.exe* to display the **Microsoft Monitoring Agent Properties** dialog box. </li><li>On the **Operations Manager** tab, check whether an Operations Manager management group is listed in the **Management Groups** box.</li></ol> |
| Verify that Operations Manager is integrated with a Log Analytics workspace | <ol><li>Sign in to the Operations Manager Management Server as an administrator. </li><li>Open the Operations Manager console. </li><li>Select **Monitoring**, expand **Azure Log Analytics**, select **Health State**, and then select the name of the management server. </li><li>In the **Detail View** pane, find the **Authentication service URI** field. This field contains the value of the Log Analytics workspace ID if Operations Manager is integrated with a workspace. </li></ol> |
| Verify that the Microsoft Monitoring Agent for the computer is allowed to connect to the Log Analytics workspace through Operations Manager | <ol><li>In the Operations Manager console, select **Administration**, expand **Azure Log Analytics**, and then select **Managed Computers**.</li><li>Check whether the name of your computer is listed.</li></ol> |
| If Operations Manager is integrated with a Log Analytics workspace, determine whether it's overriding the proxy settings for the Microsoft Monitoring Agent | <ol><li>Under **Azure Log Analytics**, select **Connection**, and then select **Configure Proxy Server**. </li><li>In the **Azure Log Analytics Settings Wizard: Proxy Server** dialog box, check whether the **Use a proxy server to access the Azure Log Analytics** option is selected. </li><li>If that option is selected, check whether the proxy address in the **Address** box differs from the proxy address in Microsoft Monitoring Agent. </li></ol> |

### Solution 1: Disable the Operations Manager proxy server

To disable the Operations Manager proxy server and restore the proxy address for the Microsoft Monitoring Agent, follow these steps:

1. In the Operations Manager console, return to the **Azure Log Analytics Settings Wizard: Proxy Server** dialog box.

1. Delete the proxy address from the **Address** box, clear the **Use a proxy server to access the Azure Log Analytics** option, and then select the **Finish** button.

1. Return to the **Proxy Settings** tab in the **Microsoft Monitoring Agent Properties** dialog box, select the **Use a proxy server** option, and then reenter the **Proxy Server** address that you want to use.

### Solution 2: Contact System Center Operations Manager support

Is Microsoft Monitoring Agent configured for Operations Manager integration and for different Log Analytics workspaces (multi-homing)? Do you want to resolve the proxy issue without breaking the integration between Microsoft Monitoring Agent and Operations Manager? To troubleshoot this situation, contact System Center Operations Manager support.

## Cause 2: Operations Manager uses different proxy addresses for each agent

Instead of using a single proxy address, the Operations Manager administrator defines different proxy addresses for Microsoft Monitoring Agents. These proxy addresses are based on their computer groups in an Operations Manager workflow rule. If Microsoft Monitoring Agent is integrated with the Operations Manager management group, the proxy setting in Operations Manager overrides any manual proxy setting in Microsoft Monitoring Agent.

To see how the Operations Manager workflow rule defines the proxy addresses for each agent, follow these steps:

1. Sign in to the Operations Manager Management Server as an administrator.

1. Open the Operations Manager console.

1. In the navigation pane, select **Authoring**, expand **Management Pack Objects**, and then select **Rules**.

1. Select **Change Scope** to show the **Scope Management Pack Objects** dialog box. Select the **View all targets** option. In the **Look for** box, search for and select **Advisor Settings**. Then, select **OK** to exit the dialog box and view the scoped rules.

1. In the list of rules, expand **Type: Agent**, right-click **Advisor Proxy Setting Rule**, and then select **Overrides Summary** to view the **Overrides Summary** dialog box.

1. View the list of overrides for the advisor proxy setting rule. If the **Name** of the Microsoft Monitoring Agent is listed, and the corresponding **Changed value** is set to **True**, then Operations Manager has set the workflow rule to override the Microsoft Monitoring Agent's proxy address.

### Solution: Clear the override of the advisor proxy setting rule

You can remove the override of the advisor proxy setting rule so that the restored proxy address for the Microsoft Monitoring Agent is used. Follow these steps:

1. Back up the current Operations Manager configuration.

1. Return to the **Overrides Summary** dialog box of the **Advisor Proxy Setting Rule**.

1. Select the entry that involves the Microsoft Monitoring Agent, select **Delete**, and then select **Close**.

1. Return to the **Proxy Settings** tab in the **Microsoft Monitoring Agent Properties** dialog box, select the **Use a proxy server** option, and then reenter the **Proxy Server** address that you want to specify.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
