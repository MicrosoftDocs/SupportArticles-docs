---
title: Installing updates for Mailbox-role server fails
description: Resolves an issue in which you can't install Exchange Server 2013 CU1 or CU2 for a Mailbox-role server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: andreig, v-six
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
ms.date: 01/24/2024
---
# Error when you install Exchange Server 2013 CU1 or CU2: Error occurred while configuring Search Foundation

_Original KB number:_ &nbsp; 2889663

## Symptoms  

When you install Exchange Server 2013 Cumulative Update 1 (KB2816900) or Cumulative Update 2 (KB2859928) on Windows Server 2008 R2 Service Pack 1 (SP1) or Windows Server 2012, the installation of the Mailbox server role isn't successful, and you receive the following error message:

> [2] Beginning processing Write-ExchangeSetupLog  
> [2] [ERROR] Failure configuring SearchFoundation through installconfig.ps1 - Error occurred while configuring Search Foundation for Exchange.System.TimeoutException: Timed out waiting for Admin node to be up and running  
> at Microsoft.Ceres.Exchange.PostSetup.DeploymentManager.WaitForAdminNode(String hostControllerNetTcpWcfUrl)  
> at Microsoft.Ceres.Exchange.PostSetup.DeploymentManager.Install(String installDirectory, String dataDirectoryPath, Int32 basePort, String logFile, Boolean singleNode, String systemName, Boolean attachedMode) at CallSite.Target(Closure , CallSite , Type , Object , Object , Object , Object , Object , Object , Boolean )  
> ...  
> [08/30/2013 08:29:04.0660] [2] Ending processing Write-ExchangeSetupLog

In addition, you see errors in the following log files:

- C:\Program Files\Microsoft\Exchange Server\V15\Bin\Search\Ceres\Installer\log\PostSetup_install_[GUID].log

    > Z Info [6] Search Foundation PostSetup - Installation starting.
    > ...  
    > Z Info [6] Search Foundation PostSetup - Waiting until Admin node fully up and running.  
    > [.............]  
    > Z Error [6] Search Foundation PostSetup - Error occurred during installation. System.TimeoutException: Timed l waiting for Admin node to be up and running  
    > at Microsoft.Ceres.Exchange.PostSetup.DeploymentManager.WaitForAdminNode(String hostControllerNetTcpWcfUrl)  
    > at Microsoft.Ceres.Exchange.PostSetup.DeploymentManager.Install(String installDirectory, String dataDirectoryPath, Int32 basePort, String logFile, Boolean singleNode, String systemName, Boolean attachedMode)

- C:\Program Files\Microsoft\Exchange Server\V15\Bin\Search\Ceres\Diagnostics\Logs\ [Database Name].log

    > Z Info [6] Search Foundation PostSetup - Installation starting.  
    > ...
    > Z Info [6] Search Foundation PostSetup - Waiting until Admin node fully up and running.
    > [.............]  
    > Z Error [6] Search Foundation PostSetup - Error occurred during installation. System.TimeoutException: Timed out waiting for Admin node to be up and running  
    > at Microsoft.Ceres.Exchange.PostSetup.DeploymentManager.WaitForAdminNode(String hostControllerNetTcpWcfUrl)  
    > at Microsoft.Ceres.Exchange.PostSetup.DeploymentManager.Install(String installDirectory, String dataDirectoryPath, Int32 basePort, String logFile, Boolean singleNode, String systemName, Boolean attachedMode)

- C:\Program Files\Microsoft\Exchange Server\V15\Bin\Search\Ceres\Diagnostics\Logs\[ServerName-Date].log

    > Unexpected Unexpected exception in node activator: System.ArgumentException: An item with the same key has already been added.  
    > at System.Collections.Generic.Dictionary`2.Insert(TKey key, TValue value, Boolean add) at Microsoft.Ceres.CoreServices.Node.BootstrapPropertyLoader.AddEnvironmentProperties(IDictionary`2 result)  
    > at Microsoft.Ceres.CoreServices.Node.NodeActivator.InitializeBootstrapProperties(IDictionary`2 overlay) at Microsoft.Ceres.CoreServices.Node.NodeActivator.ActivateNode(IDictionary`2 configuration)

## Cause

This issue occurs because of a trailing space in the **PSModulePath** variable in the environment variables.

:::image type="content" source="media/error-occurred-while-configuring-search-foundation/show-trailing-space-in-psmodulepath-variable.png" alt-text="Screenshot shows a trailing space of the PSModulePath variable in the environment variables." border="false":::

## Resolution

To resolve this issue, remove trailing spaces from the **PSModulePath** variable. If there are more **PSModulePath** variables, make sure that they do not contain any trailing spaces. After you remove the trailing space, restart the server.

For more information about how to configure Environment Variables, see [Configure an Environment Variable item](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc772047(v=ws.11)).
