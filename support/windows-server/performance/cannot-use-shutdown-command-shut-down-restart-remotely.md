---
title: You cannot use the shutdown command to shut down or to restart Windows Server 2003 remotely
description: 
ms.date: 12/31/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# You cannot use the shutdown command to shut down or to restart Windows Server 2003 remotely

_Original product version:_ &nbsp;   
_Original KB number:_ &nbsp; 834100

## Symptoms

When you use the shutdown command to try to shut down or to restart a Microsoft Windows Server 2003-based computer remotely, the computer does not shut down.

For example, when you type shutdown /s /m \\ **computer_name** /t 003  
from a remote computer, you may receive one of the following error messages:
 **computer_name** : The computer is processing another action and thus cannot be shut down. Wait until the computer has finished its action, and then try again.(21)

Device is not ready

## Cause

This problem may occur if you use Remote Desktop Connection with the /console switch to open the console session (session 0) of the Windows Server 2003-based computer, and then you use **Log Off** to end the connection. For example, the problem may occur if you follow these steps in the order listed:


1. Use Remote Desktop Connection to connect remotely to the console session of the Windows Server 2003-based computer. To do this, click **Start**, click **Run**, type mstsc /console in the **Open** box, and then click **OK**. Type the computer name, and then click **Connect**.
2. After the console session opens, click **Start**, and then click **Log Off** to log off the console session.
3. From a command prompt, type shutdown /r /m \\ **computer_name** /t 003  
from the remote computer to restart the computer remotely.

## Resolution

### Hotfix information

A supported hotfix is available from Microsoft. However, this hotfix is intended to correct only the problem that is described in this article. Apply this hotfix only to systems that are experiencing this specific problem. This hotfix might receive additional testing. Therefore, if you are not severely affected by this problem, we recommend that you wait for the next software update that contains this hotfix.

If the hotfix is available for download, there is a "Hotfix download available" section at the top of this Knowledge Base article. If this section does not appear, contact Microsoft Customer Service and Support to obtain the hotfix.

> [!NOTE]
> If additional issues occur or if any troubleshooting is required, you might have to create a separate service request. The usual support costs will apply to additional support questions and issues that do not qualify for this specific hotfix. For a complete list of Microsoft Customer Service and Support telephone numbers or to create a separate service request, visit the following Microsoft Web site: [https://support.microsoft.com/contactus/?ws=support](/contactus/?ws=support) 
> [!NOTE]
> The "Hotfix download available" form displays the languages for which the hotfix is available. If you do not see your language, it is because a hotfix is not available for that language. 

#### Prerequisites

No prerequisites are required.

#### Restart requirement

You must restart your computer after you apply this hotfix.

#### Hotfix replacement information

This hotfix does not replace any other hotfixes.

#### File information

The English version of this hotfix has the file attributes (or later) that are listed in the following table. The dates and times for these files are listed in coordinated universal time (UTC). When you view the file information, it is converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the Date and Time tool in Control Panel. 
```

Date Time Version Size File name
 ------------------------------------------------------------
 07-Jan-2004 00:58 5.2.3790.116 540,160 Winlogon.exe

```  

## Workaround

To work around this problem, use one of the following methods:

- Disconnect the console session instead of logging off. For example, click the **Close** button in the console session, and then when you receive the following message, click **OK** to confirm the action:

This will disconnect your Windows session. Your programs will continue to run while you are disconnected. You can reconnect to this session later by logging on again.

- Use Remote Desktop Connection without the /console switch to connect to the Windows Server 2003-based computer.To shut down the server remotely after this problem has already occurred, use Remote Desktop Connection to reconnect to the server, and then use the **Close** button to disconnect from the server. You can then use the shutdown command to shutdown or to restart the server remotely.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section of this article. 

## More Information

For additional information about how to use Remote Desktop Connection with Windows Server 2003, click the following article number to view the article in the Microsoft Knowledge Base:

[814585](https://support.microsoft.com/help/814585) HOW TO: Connect clients to Terminal Services in Windows Server 2003  

For additional information, click the following article number to view the article in the Microsoft Knowledge Base: [824684](https://support.microsoft.com/help/824684) Description of the standard terminology that is used to describe Microsoft software updates
