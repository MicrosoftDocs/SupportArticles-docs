---
title: How to reinstall Operations Management Suite (OMS) Agent for Linux
description: Describes how to reinstall Operations Management Suite (OMS) Agent for Linux.
ms.date: 06/06/2022
ms.service: automation
ms.author: genli
author: genlin
ms.reviewer: 
---
# How to reinstall Operations Management Suite (OMS) Agent for Linux

This article describes the steps to remove the Operations Management Suite (OMS) Agent for Linux and then reinstall it.

_Original product version:_ &nbsp; Azure Automation  
_Original KB number:_ &nbsp; 4131455

## Prerequisites

Before you reinstall the OMS Agent, verify that you have the following items:

- A login account to the Linux-computer that can use **sudo**.
- The workspace identifier and primary key of your OMS workspace. To get them, open the Azure portal, navigate to **Log Analytics**, select your workspace, and then select **Advanced settings**. The blade that open includes a property that's named **Workspace ID** and another that's named **Primary Key**.

## Reinstall OMS Agent for Linux

To remove the existing agent and then install the new agent, follow these steps:

1. Connect to the Linux computer, and then open a terminal session.
2. To download the desired script, run the following command:

    ```bash
    wget https://raw.githubusercontent.com/Microsoft/OMS-Agent-for-Linux/master/installer/scripts/onboard_agent.sh
    ```  

3. Run `sudo sh onboard_agent.sh --purge`. This command downloads the most recent version of the installation script and runs the uninstallation operation that will remove all existing agent components.
4. Remove the `/etc/opt/microsoft/omsagent` and `/var/opt/microsoft/omsagent` folders.
5. Run the following command:

    ```bash
    sudo sh onboard_agent.sh -w <workspaceid> -s <primarykey>
    ```

    - In this command, replace \<workspaceid> and \<primarykey> with the appropriate values from the actual Azure workspace ID and primary key, respectively.
    - If you're using a cloud service other than Azure public cloud, you must add the **-d** parameter that identifies the domain to be used. For example, if you use the Azure US Government cloud, run the following command:

      ```bash
      sudo sh onboard_agent.sh -w workspaceid -s primarykey -d opinsights.azure.us
      ```  

## Verify the agent reinstallation

To verify that the installation finished successfully, run a script that starts a check of the agent. To start the check, follow these steps:

1. Connect to the Linux computer, and then open a terminal session.
2. Run the one of these two commands to check the agent:

   If the agent is running **python2**, run this command:

   ```bash
   sudo su omsagent -c 'python2 /opt/microsoft/omsconfig/Scripts/PerformRequiredConfigurationChecks.py'
   ```

   If the agent is running **python3**, run this command:

   ```bash
   sudo su omsagent -c 'python3 /opt/microsoft/omsconfig/Scripts/python3/PerformRequiredConfigurationChecks.py'
   ```

If the script runs successfully, you'll get a result similar to this output:

```bash
instance of PerformRequiredConfigurationChecks
{
    ReturnValue=0
}
```

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
