---
title: Heavy Excel workloads run slowly in multi-session environments
description: Describes a slow performance issue that you might experience when you run heavy Excel workloads in a multi-session environment. Provides workarounds.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: rtaylor, jefferc
ms.custom: 
  - Reliability
  - CSSTroubleshoot
  - CI 172461
search.appverid: 
  - MET150
appliesto: 
  - Excel
ms.date: 05/26/2025
---

# Heavy Excel workloads run slowly in multi-session environments

## Symptoms

You might experience slow performance when you run heavy Microsoft Excel workloads in a multi-session environment such as:

- Windows Server 2022
- Windows Server 2019
- Windows 10 or Windows 11 Enterprise multi-session in the Azure Virtual Desktop service

## Cause

This issue occurs because, by default, Microsoft 365 Apps that are deployed to multi-session environments are limited to two threads for multithreaded recalculation (MTR) and worker thread pools. This limit is imposed to make sure that all concurrent user sessions have enough resources to provide a good user experience. However, heavy Excel workloads that require calculation or data analysis and involve data snapshots (such as Flash Fill) in a user session might run slowly because of the restricted thread count.

## Workaround

To work around this issue, use one of the following options.

### Option 1: Use Windows 11 or Windows 10

If a multi-session environment isn't required, use a client that's running Windows 11 or Windows 10. Then, Microsoft 365 Apps can use all the available system resources for optimal performance. For more information about how to migrate Microsoft 365 Apps from Windows Server, see [Microsoft 365 Apps migration from Windows Server](/deployoffice/endofsupport/windows-server-migration).

### Option 2: Increase the number of threads available for Microsoft 365 Apps

> [!IMPORTANT]
> Consider the risks carefully before you change the default limit of threads. Although increasing the number of threads can improve performance when handling intensive tasks in a user session, it might also cause increased resource consumption on the shared server. This can cause server performance issues and stability issues if multiple user sessions are active and doing the same tasks at the same time. If you decide to change the limit, start by using a low value, and gradually increase the value until you find a suitable compromise that doesn't tax the system resources.
>
> This method contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, [back up the registry for restoration](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692) before you modify it.

On the multi-session host, follow these steps:

1. Open Registry Editor.
2. Locate the following registry subkey:

   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\Common`
3. If the **IdealConcurrencyValueOverride** entry doesn't exist, right-click the subkey, select **New** > **DWORD (32-bit) Value**, and then enter *IdealConcurrencyValueOverride* as the name of the entry.

   **Note:** By default, the **IdealConcurrencyValueOverride** entry doesn't exist, and Microsoft 365 Apps is limited to using two threads.
4. Right-click **IdealConcurrencyValueOverride**, and select **Modify**.
5. In the **Value data** field, enter a number between 2 and 512 to specify the number of threads, and then select **OK**.
