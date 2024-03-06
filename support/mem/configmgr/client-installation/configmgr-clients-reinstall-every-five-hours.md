---
title: Configuration Manager clients reinstall every five hours
description: Describes an issue in which the Configuration Manager client reinstalls itself every five hours and may cause an inadvertent client upgrade if a current branch site is already upgraded. Provides a workaround.
ms.date: 12/05/2023
ms.reviewer: kaushika, brianhun, jstewart, yohuang, brenduns, cmkbreview
---
# Configuration Manager clients reinstall every five hours and may cause an inadvertent client upgrade

This article discusses an issue in System Center 2012 Configuration Manager client and System Center 2012 R2 Configuration Manager client that could cause an inadvertent client upgrade in a Configuration Manager current branch or long-term servicing branch (LTSB) environment.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager  
_Original KB number:_ &nbsp; 4018655

## Summary

The Configuration Manager client installation (CCMSetup) initially fails and causes a client retry task to be registered in Windows Task Scheduler. After the client installation succeeds, the retry task is not deleted as expected. Therefore, the clients continue to reinstall every five hours.

In this situation, if you upgrade the Configuration Manager infrastructure to Configuration Manager current branch or LTSB, and if you don't upgrade the Configuration Manager clients, the scheduled retry task continues to force a client reinstallation every five hours.

The next time that CCMSetup runs, the clients find an updated management point or distribution point, and they reinstall the client software. This upgrades the clients to Configuration Manager.

These continual upgrades occur outside the normal upgrade process that is configured by the administrator. This includes the client piloting feature.

## Symptoms

In a Microsoft System Center 2012 or System Center 2012 R2 environment, you notice the following symptoms:

- Clients successfully reinstall themselves every five hours. This activity is logged in ccmsetup.log and Windows event logs.
- When you view the \Microsoft\Microsoft\ConfigurationManager folder in **Task Scheduler**, you find a task that is named **Configuration Manager Client Retry Task**.

## Cause

This issue occurs because CCMSetup creates the client retry task in the wrong folder on the client. This prevents CCMSetup from locating and removing the task.

The scheduled task is created in the \Microsoft\Microsoft\Configuration Manager folder instead of the \Microsoft\Configuration Manager folder.

## Workaround 1

Manually remove **Configuration Manager Client Retry Task** from the \Microsoft\Microsoft\Configuration Manager folder by using **Task Scheduler**.

## Workaround 2

Deploy a script to remove **Configuration Manager Client Retry Task** from the \Microsoft\Microsoft\Configuration Manager folder.

Example Windows PowerShell commands to add to your script:

```powershell
get-scheduledtask -taskname "Configuration Manager Client Retry Task"  
unregister-scheduledtask -taskname "Configuration Manager Client Retry Task" -confirm:$false
```

## More information

In Configuration Manager current branch version 1602 and later versions, and in LTSB version 1606, Ccmsetup correctly removes the scheduled task after the clients are upgraded.
