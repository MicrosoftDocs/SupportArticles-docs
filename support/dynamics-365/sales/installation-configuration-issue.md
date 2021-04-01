---
title: An installation and configuration issue
description: Discusses an installation and configuration issue with the Microsoft Dynamics CRM Client for Microsoft Office Outlook.
ms.reviewer: chanson, henningp
ms.topic: troubleshooting
ms.date: 
---
# Errors when you try to install or to configure the Microsoft Dynamics CRM Client for Microsoft Office Outlook

This article provides a solution to errors that occur when you try to install or to configure the Microsoft Dynamics CRM Client for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2500375

## Introduction

> [!IMPORTANT]
> This article contains information about how to change the registry. Make sure that you back up the registry before you change it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and change the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

## Symptom 1

You uninstall Microsoft Office 2010 and then install the Microsoft 2007 Office suite. When you try to install the Microsoft Dynamics CRM Client for Microsoft Office Outlook, you receive the following error message:

> The installation has failed. Setup cannot continue because 64-bit Microsoft Office Outlook is installed, please run 64-bit Microsoft Dynamics CRM for Outlook setup.

## Symptom 2

When you try to configure the Microsoft Dynamics CRM 2011 Client for Microsoft Office Outlook, you receive the following error message:

> There is a problem communicating with the Microsoft Dynamics CRM server. The server might be unavailable. Try again lager. If the problem persists, contact your system administrator.
>
> Cannot configure the organization for Microsoft Dynamics CRM for Outlook. Try to configure the organization again. If the problem persists, contact your system administrator.

## Cause 1

The symptoms occur because of registry keys that are left over from the Microsoft Office 2010 installation. When Microsoft Office 2010 is installed, a registry key that is named `bitness` is created under `HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Office\14.0\Outlook` and `HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Office\14.0\Outlook`. If the `bitness` registry key is set to **x64**, installing the x86 Microsoft Dynamics CRM Client will be unsuccessful.

## Cause 2

When the Microsoft Dynamics CRM Client for Microsoft Office Outlook was installed on a computer that is running the Microsoft 2007 Office suite, the `14.0\Outlook` registry key still existed and must now be deleted.

## Resolution

> [!WARNING]
> Serious problems might occur if you change the registry incorrectly by using Registry Editor or by using another method. These problems might require you to reinstall the operating system. Microsoft can't guarantee that these problems can be resolved. Change the registry at your own risk.

To resolve this problem, delete the Outlook registry key.

We strongly recommend that you back up the registry before you delete keys. Also, delete the keys only if you no longer have Office Outlook 2010 installed on the computer.

1. Select **Start**, and then select **Run**.  
2. Type **regedit** in the **Open** box, and then select **OK**.
3. Locate the following registry subkey:  
    `HKEY_LOCAL_MACHINE\Software\Microsoft\Office\14.0\Outlook`

4. Right-click the Outlook registry key, and then select **Delete**.
5. Locate the following registry subkey:  
    `HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Office\14.0\Outlook`

6. Right-click the Outlook registry key, and then select **Delete**.
7. If you currently have the Microsoft Dynamics CRM Client for Outlook installed, you must uninstall and then reinstall and reconfigure the Microsoft Dynamics CRM 2011 Client.
