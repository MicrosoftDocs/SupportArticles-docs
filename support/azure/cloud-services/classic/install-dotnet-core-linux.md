---
title: Install .NET Core on Linux by using an Azure Batch start task
description: Describes how to install .NET Core in Linux by using an Azure Batch start task.
ms.date: 01/19/2024
ms.reviewer: v-weizhu
author: genlin
ms.author: genli
ms.service: cloud-services
ms.subservice: reference
ms.custom: linux-related-content
---
# Install .NET Core on Linux by using an Azure Batch start task

This article describes how to install .NET Core on Linux by using an Azure Batch start task.

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles)  
_Original KB number:_ &nbsp; 4466812

## Procedure

To install .NET Core in a Linux environment, follow these steps:

1. Go to [.NET tutorial](https://www.microsoft.com/net/learn/get-started/linux/ubuntu16-04) to create a shell script named `ex- dotnetcoreinstall.sh`.

    > [!NOTE]
    > This link is valid for Ubuntu version 16.04. The script can change, depending on the Linux distribution on which you want to install .NET Core. Select the required Linux distribution and create the script accordingly.
2. Upload the script `dotnetcoreinstall.sh` to the storage account from which the start task will be downloaded in the Linux VM.
3. Create a Batch pool that consists of the required Linux VM distribution, and edit the Start Task as follows. The Batch Explorer (formerly namedBatchLabs) tool is used to simulate the scenario. The same thing is true in case the pool is created from the portal.

    `Blob source:https://batchpratyaystorage.blob.core.windows.net/batchcontainer/dotnetcoreinstall.sh`

    This represents the actual URL of the blob (such as the script).

    `File path: /mnt/batch/tasks/startup/wd`

    This represents the local path on the Linux virtual machine where the script will be downloaded from the storage account.

    :::image type="content" source="media/install-dotnet-core-linux/start-task-pool.png" alt-text="Screenshot shows the Azure Batch Start task details." border="false":::

## Troubleshoot steps

These steps above work as expected when you create the script in a Linux environment. However, these steps fail and you receive the following error message when you create the script in a Windows environment and upload it to the storage account.

```console
(--install):processing archive packages-microsoft-prod.deb
cannot access archive: No such file or directory
Errors were encountered while processing:
packages-microsoft-prod.deb
] is not understood in combination with the other options.
] is not understood in combination with the other options.
Reading package lists... Done
Building dependency tree
Reading state information... Done
E: Unable to locate package dotnet-sdk-2.1.200
E: Couldn't find any package by glob 'dotnet-sdk-2.1.200'
E: Couldn't find any package by regex 'dotnet-sdk-2.1.200'
```

This behavior occurs because the script in different environments (Windows or Linux) is created in different formats. To determine the format, run the **file** command in the Linux bash shell. UNIX systems use a single character, the linefeed character, and Windows systems use both a carriage return and a linefeed (often referred to as CRLF) to terminate lines in text files.

For more information about line terminators, see the [Windows vs. UNIX: Those pesky line terminators topic](https://www.networkworld.com/article/954320/windows-vs-unix-those-pesky-line-terminators.html) on the Network World website.

Script examples

```bash
$ file dotnetcoreinstall.sh //// Script created in Windows and uploaded to storage account
dotnetcoreinstall.sh: ASCII text, with CRLF line terminators
$ file dotnetcoreinstall.sh //// Script created in Linux and uploaded to storage account
dotnetcoreinstall.sh: ASCII text
```

To prevent the file format mismatch, do one of the following:

- Create the script in a different Ubuntu environment, and upload the script to the storage explorer by using Storage Explorer for Linux.
- If you do not have Storage Explorer in your Linux environment, get the script from the VM that was created in the previous step to your Windows environment by using the following Putty command. The Putty tool includes the executable **pscp.exe**.

    :::image type="content" source="media/install-dotnet-core-linux/putty-pscp.png" alt-text="Screenshot of the Putty command.":::

 After you send the file from Linux to Windows, upload the file to the storage account as is.
 To automate the process of converting files from Windows (DOS) to UNIX format, run the following command:

```bash
dos2unix dotnetcoreinstall.sh
```

To execute this command, you must first install the **dos2unix** package. To do this, run the following command:

```bash
sudo apt-get install dos2unix
```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]
