---
title: Folder redirection settings are applied from Group Policy
description: This article describes a problem that you experience when you turn on loopback processing in Group Policy and notice that the folder redirection settings are being applied from the Group Policy settings that are deployed to the user's computer.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot
ms.technology: windows-server-group-policy
---
# Folder redirection settings are still applied from Group Policy settings even though you turn on loopback processing in Group Policy

This article provides a solution to an issue that folder redirection settings are being applied from the Group Policy settings that are deployed to the user's computer even though you turn on loopback processing in Group Policy.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 328008

## Symptoms

When you turn on loopback processing in Group Policy, you may notice that folder redirection settings are being applied from the Group Policy settings that are deployed to the user's computer. All the settings that are configured by the loopback policy take effect except the folder redirection settings.

You notice this problem only when a user already has a Group Policy setting for folder redirection, and you try to turn on loopback processing on his or her computer. You do not notice this problem when users have a Group Policy setting applied for folder redirection, they have loopback processing turned on at the same time, and that loopback processing is being turned on for the first time.

## Cause

This problem occurs when you turn on loopback processing with Replace mode in Group Policy, but you do not configure any folder redirection settings for that policy.

When you do not configure any folder redirection settings, the default setting for folder redirection folders, such as the My Documents folder, is **No Administrative policy specified**. This setting does not remove or turn off the folder redirection feature if it is turned on for the user by another Group Policy setting.

## Resolution

To resolve this problem, configure the folder redirection settings for the Group Policy setting.

For example, to redirect the My Documents folder, follow these steps:

1. Change the My Documents folder setting in the loopback policy to **Redirect everyone's folder to the same location**.
2. Set the destination folder location as **%LOCALPROFILE%\My Documents**.

This points the My Documents folder to the user local profile My Documents folder path. You can turn on or turn off the **Move the contents of My Documents to new location** setting, depending on whether you want to move the copy of the My Documents folder from the server share.

> [!NOTE]
> When the **Move the contents of My Documents to new location** setting is turned on, the contents of the My Documents folder are redirected every time the user switches from the computer that is affected by the loopback policy to another computer. By turning off this setting, you avoid this.

## More information

Organizations that use software distribution and folder redirection Group Policy settings may not want to use those settings for users who have slow Internet connections. Such organizations can turn on loopback processing so that users have two different Group Policy settings applied, based on the computer that they use to log on to the network.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Group Policy issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-group-policy.md).
