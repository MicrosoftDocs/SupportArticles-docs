---
title: Copy and extract files from development environment to Linux
description: This article describes how to copy files from a Windows-based computer to a Linux virtual machine and extract files.
ms.date: 03/29/2021
ms.custom: linux-related-content
ms.reviewer: ramakoni, ahmetmb
author: ahmetmithat
---
# Part 2.5 - Copy and extract files from your development environment to Linux

_Applies to:_ &nbsp; .NET Core 2.1, .NET Core 3.1, .NET 5  

This article introduces how to copy files from a Windows-based computer to a Linux virtual machine and extract files.

## Prerequisites

This part doesn't have any prerequisites.

## Goal of this part

You'll learn how to copy files from a Windows-based computer to a Linux virtual machine (VM). This will be helpful when you deploy your application to Linux.

Although there are no prerequisites for this part, the ideal setup would follow the guidance from the previous parts. You should have the following:

- Nginx running automatically and configured to listen to requests sent on port 80
- Nginx configured as a reverse proxy and routing incoming requests to an ASP.NET Core application this is listening on port 5000
- The ASP.NET Core application that is configured to start automatically after the server is restarted or when the process is stopped or crashes.
- A Linux local firewall that is configured to allow SSH and HTTP traffic

## Copy files from Windows to Linux and vice versa

There are several options to copy files between Windows and Linux. You can find the different methods in several good articles, such as [this one](https://www.makeuseof.com/tag/transfer-share-files-windows-linux/). Here are some options:

- Share network folders. Refer to [SMB protocol](https://tldp.org/HOWTO/SMB-HOWTO-8.html) and [Samba](https://www.samba.org/samba/what_is_samba.html).
- Transfer files by using FTP. One of the best-known FTP servers in Linux is [PureFTPd](https://www.pureftpd.org/project/pure-ftpd/).
- Securely copy files through SSH. You can use the [scp](https://haydenjames.io/linux-securely-copy-files-using-scp/) command to copy over SSH. However, a better tool is [pscp](http://manpages.ubuntu.com/manpages/xenial/man1/pscp.1.html) (included with [PuTTY](https://www.ssh.com/ssh/putty/putty-manuals/0.68/Chapter5.html)).
- Share data by using sync software. A sync program helps you create sync points in both Windows and Linux, and then sync it by using an encryption key.
- Use shared folders if Linux is running as a VM in your VM. Several tools, such as Oracle's [VirtualBox](https://www.virtualbox.org/), help you create virtual shared directories.

In this part, you'll use pscp to transfer files from Windows to Linux.

## Basic pscp parameters

`Pscp` makes it easy to do basic tasks, such as copying a file to Linux. This tool is included with [PuTTY](https://www.putty.org/), so it should be installed on your Windows-based computer together with PuTTY. If it is not, install it now.

Here's a sample command:

```console
pscp -i <private key path> <local file to upload> user@host:<Linux path to save>
```

For example, to copy the *c:\web\publish.zip* file to your user's home directory in Linux, use this command:

```console
pscp -i d:\secure\myprivatekey.ppk c:\web\publish.zip <UserName>@buggyamb:<Linux path to save>
```

The private key is the same *.ppk* key that was converted from a *.pem* file when you tried to connect to your VM by using PuTTY. If you did this successfully, you should already have this file. If you don't have the *.ppk* file, follow the instructions from the "Connecting with PuTTY" section, and convert your *.pem* file to *.ppk*.

## Copy a file to Linux and extract it to another folder

### Download a sample project

For this tutorial, you'll copy a test application that is named BuggyAmb. This application is available on [BuggyAmb debugging sample application](/samples/dotnet/samples/buggyamb-debugging-sample-app). We recommend that you use this sample application because the next parts use this application to simulate high and low CPU performance problems and crash issues in the troubleshooting labs.

BuggyAmb is simply a buggy ASP.NET Core 3.1-based Razor Pages application. This application was intentionally created as a buggy application to be used as a learning resource to troubleshoot problematic scenarios for an ASP.NET Core application on Linux.

You can find the source code files at [ASP.NET Core binaries for Linux](https://buggyambfiles.blob.core.windows.net/bin/buggyamb_v1.1.tar.gz). This is in *.tar.gz* format because that format is common in the Linux world. You can also download the [buggyamb_v1.1](https://buggyambfiles.blob.core.windows.net/bin/buggyamb_v1.1.zip) in *.zip* format for Windows.

### Copy buggyamb_v1.1.tar.gz file to a Linux VM

Open a Command Prompt window on your Windows-based computer, and go to the folder that PuTTY is installed in. To copy the file, run the following command:

```console
pscp -i d:\secure\myprivatekey.ppk D:\Learn\Linux\buggyamb_v1.1.tar.gz <UserName>@buggyamb:/home/<UserName>
```

Also run the `pscp` command after you modify it by using your own private key and paths accordingly. The following screenshot shows a successful file transfer between Windows and the Linux VM.

:::image type="content" source="./media/2-5-copy-file-linux-vm-extract-file/pscp-command.png" alt-text="Screenshot of pscp command." border="true":::

> [!NOTE]
> When you connect to your VM for the first time by using the `pscp` command, you may see a warning message about a host key mismatch.

Connect to your Linux VM, and check whether the file is there. You can do this by using the `ls` command.

:::image type="content" source="./media/2-5-copy-file-linux-vm-extract-file/ls-command.png" alt-text="Screenshot of ls command." border="true":::

There are other methods to copy files between Linux and Windows. But this method is sufficient for this tutorial.

Use the *buggyamb_v1.1.tar.gz* file to create a second ASP.NET Core application that runs behind Nginx. This time, this application will be configured to use a hostname to browse it. The same application will be used in the troubleshooting labs that comprise this tutorial.

> [!NOTE]
> If you have difficulties copying the *buggyamb_v1.1.tar.gz* file to your Linux machine, you can simply download the .tar.gz file from your Linux VM by using this simple `wget` command:

```bash
wget https://buggyambfiles.blob.core.windows.net/bin/buggyamb_v1.1.tar.gz
```

## Extract the files and copy to the /var/ folder

*Buggyamb_v1.1.tar.gz* contains everything that you need to run your buggy application. Just as you did for your first ASP.NET Core application, follow the same steps to configure this application to run always behind Nginx.

Extract the *.tar.gz* file, and copy it to the */var* folder. There are two simple ways to accomplish this:

- **Option 1**: Extract the *tar.gz* file to the current directory by running `tar -xf filename.tar.gz`. Then, copy the extracted folder to the */var* folder.
- **Option 2**: Extract the *tar.gz* file directly to the */var* directory.

**Option 1**: Run `tar -xf buggyamb_v1.1.tar.gz` to create the *buggyamb_v1.1* folder. Then, copy it to the */var* folder using the `sudo cp -a buggyamb_v1.1 /var/` command.

:::image type="content" source="./media/2-5-copy-file-linux-vm-extract-file/sudo-cp.png" alt-text="Screenshot of sudo cp command." border="true":::

**Option 2**: Extract the application directly to the */var/* folder by using the `sudo tar -xf buggyamb_v1.1.tar.gz -C /var/` command.

:::image type="content" source="./media/2-5-copy-file-linux-vm-extract-file/sudo-tar.png" alt-text="Screenshot of sudo tar command." border="true":::

Choose either option, to extract the *buggyamb_v1.1* application files. These should be extracted or moved to */var/buggyamb_v1.1* folder to complete the setup. This folder will be used as the working directory for the new ASP.NET Core application.

## Next steps

[Part 2.6 - Run two ASP.NET Core applications at the same time](2-6-run-two-aspnetcore-applications-same-time.md)

Configure and run the buggy ASP.NET Core application behind Nginx. At the end of those steps, you'll have two ASP.NET Core applications running behind Nginx.
