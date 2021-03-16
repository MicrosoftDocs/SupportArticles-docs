---
title: Installing .NET Core in Linux 
description: This article introduces how to install .NET Core in Linux and describes the .NET Core versions.
ms.date: 03/08/2021
ms.prod: aspnet-core-api
ms.reviewer: ramakoni
---
# Part 1.3 - Installing .NET Core in Linux

_Applies to:_ &nbsp;

**Goal of this part**

In this part, you'll learn how to install .NET Core on Linux.

This topic assumes that you're running Ubuntu, and that you're using the APT command-line tool to install applications.

## Prerequisites

This part assumes that you know the following processes:

- How to run commands as a superuser (root).
- How to install applications by using package managers.

If you're not at least familiar with these processes, refer to the previous parts before you continue.

## Installing .NET Core

For reference during this procedure, see [Preparing your Linux system for .NET Core](https://github.com/dotnet/core/blob/main/Documentation/linux-setup.md).

For the supported versions of .NET Core on different Linux distributions, see [Install .NET on Linux](/dotnet/core/install/linux).

In this article, you can select your Linux version to obtain instructions for your distribution. Because we're using Ubuntu 18.04, we'll be following the instructions from the ["18.04" section of Install the .NET SDK or the .NET Runtime on Ubuntu](/dotnet/core/install/linux-ubuntu#1804-).

Begin by running the following commands:

```console
wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
 
sudo dpkg -i packages-microsoft-prod.deb
```

The first command is a `wget` command. According to its help page, `wget` is a non-interactive network downloader. It downloads files from HTTP servers in a directory. It can run in the background even if the user is not logged in. This `wget` command downloads the `Packages-microsoft-prod.deb file` from `packages.microsoft.com` servers in the current directory.

If we run `ls` after we run the `wget` command, we should see that the package is downloaded in the current directory.

![Buggy wget](./media/install-dotnet-core-linux/wget.png)

In the second command, `dpkg` is the package manager for Debian and Ubuntu. This command adds the Microsoft package signing key to the list of trusted keys, and then adds the package repository.

![Buggy sudo](./media/install-dotnet-core-linux/sudo.png)

Because we've downloaded and added a new package repository, the package manager has to know about it. Therefore, we have to update the package manager by using the `sudo apt update` command.

![Buggy update](./media/install-dotnet-core-linux/update.png)

Now, the package manager is aware of the Microsoft repository, and we can continue the installation.

## .NET Core versions

At the time of this writing, the latest .NET Core version is 5.0. We recommend that you install the latest version. However, you should also install the .NET Core 3.1 SDK. This is necessary because the troubleshooting labs in this series of articles assumes that you are using BuggyAmb -- a buggy ASP.NET Core application that we use to learn how to troubleshoot ASP.NET Core applications. The current version of BuggyAmb is .NET Core 3.1.

The different versions of these applications can successfully run side by side on the same computer.

## Identify the correct package name

Per the ["How to install other versions" section of Install the .NET SDK or the .NET Runtime on Ubuntu](/dotnet/core/install/linux-ubuntu#how-to-install-other-versions), the .NET Core packages are named in the format of **{product}-{type}-{version}**, and have the following conditions:

- The product is either **dotnet** or **aspnetcore**. Notice that **aspnetcore** is also installed when .NET Core is installed.
- The type is either **sdk** or **runtime**.
- At the time of this writing, the supported .NET Core versions are 5.0, 3.1, 3.0, and 2.1.

For example, if you want to install version 5.0 of ASP.NET Core runtime, then the product would be **aspnetcore-runtime-5.0**.

Because you have to install the .NET Core 3.1 SDK for this series of articles, the package name would be **dotnet-sdk-3.1**.

You should know how to install packages by using APT. If you do not, refer to the previous parts. To install the .NET Core 3.1 SDK, run `sudo apt install dotnet-sdk-3.1`.

![Buggy sdk](./media/install-dotnet-core-linux/sdk.png)

Enter *y* and press Enter. The package manager downloads and install both .NET Core and ASP.NET Core runtimes and SDKs.

![Buggy sudoapt](./media/install-dotnet-core-linux/sudoapt.png)

> [!NOTE]
> You can also installing the .NET Core 5.0 SDK by running the `sudo apt install dotnet-sdk-5.0` command.

Now, verify the installation of the runtimes and SDKs by running `dotnet --info`. The next screenshot shows that .NET Core 3.1 and 5.0 runtimes and SDKs are installed side by side.

![Buggy info](./media/install-dotnet-core-linux/info.png)

Both .NET Core and ASP.NET Core runtimes are installed together with the .NET Core SDK. If you examine the SDK folder by running `ll /usr/share/dotnet/sdk`, you can see both versions there, too.

![Buggy ll](./media/install-dotnet-core-linux/ll.png)

The .NET Core SDKs and runtimes are now installed. In the next part, we'll create an ASP.NET Core application by using .NET CLI tools.

[!INCLUDE [Third-party disclaimer](../includes/third-party-disclaimer.md)]
