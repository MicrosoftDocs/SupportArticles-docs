---
title: Logon scripts don't run for five minutes
description: Provides a solution to an issue where logon scripts don't run for five minutes after a user logs on to a Windows 8.1-based computer.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, ajayps
ms.custom: sap:group-policy-management-gpmc-or-agpm, csstroubleshoot
---
# Logon scripts don't run for five minutes after a user logs on to a Windows 8.1-based computer

This article provides a solution to an issue where logon scripts don't run for five minutes after a user logs on to a Windows 8.1-based computer.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2895815

## Symptoms

After a user logs on to a Windows 8.1-based computer, the logon scripts do not run for five minutes. This behavior causes the following symptoms to occur:

- Operations that are performed by the logon scripts may not be visible on Windows 8.1-based computers until five minutes after the user logs on.

- Resources that are made available by the logon scripts may not be available to users on Windows 8.1-based computers until about five minutes after users log on.

## Cause

This behavior occurs because Windows 8.1 includes a new Group Policy setting, **Configure Logon Script Delay**, that controls the behavior of logon scripts. This script is stored in the following location:

Computer Configuration\Administrative Templates\System\Group Policy

The default value setting for the **Configure Logon Script Delay** policy is **Not Configured**. However, the default behavior of a Group Policy client is to wait five minutes before it runs logon scripts.

The goal of the five-minute delay is to speed up the loading of the user's desktop on Windows 8.1-based computers.  

## Resolution

If you want the logon scripts to run at user logon without any delay, you should configure the **Configure Logon Script Delay** setting to **Disabled** in the Computer Configuration\Administrative Templates\System\Group Policy location.

If you want to change the time that the Group Policy client waits until it runs the logon scripts, you should configure the **Configure Logon Script Delay** setting to **Enabled** in the Computer Configuration\Administrative Templates\System\Group Policy location. Then, in the options section, set **minute** to the desired value. The maximum value that you can enter is 1,000 minutes.

After you set the policy to **Enabled** and set the time in minutes, the Group Policy client waits for the specified time before it runs logon scripts at user logon. If you enter the time in minutes as zero (0), the setting is disabled, and the Group Policy client runs the logon scripts at user logon without any delay.
