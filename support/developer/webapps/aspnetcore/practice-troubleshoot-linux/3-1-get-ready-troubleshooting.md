---
title: Get ready for troubleshooting
description: This article helps you consider the troubleshooting process as a whole.
ms.date: 03/18/2021
ms.custom: linux-related-content
ms.reviewer: ramakoni, ahmetmb
author: ahmetmithat
---
# Part 3.1 - Get ready for troubleshooting

_Applies to:_ &nbsp; .NET Core 2.1, .NET Core 3.1, .NET 5  

This article helps you consider the troubleshooting process as a whole.

## Prerequisites

As in the [previous parts](2-1-create-configure-aspnet-core-applications.md), this part is structured to put more emphasis on the theory and principals to follow when you start to troubleshoot. It doesn't have any prerequisites. However, you should have following items already set up if you followed all the steps of this training so far:

- Nginx has two websites:
  - The first website listens for requests by using the **myfirstwebsite** host header (`http://myfirstwebsite`), and routes the requests to the demo ASP.NET Core application that is listening on port 5000.
  - The second website listens for requests by using the **buggyamb** (`http://buggyamb`) host header, and routes the requests to the second ASP.NET Core sample buggy application that is listening on port 5001.
- Both ASP.NET Core applications are running as services that restart automatically when the server is rebooted, or the applications stops responding or fails.
- A Linux local firewall is enabled and configured to allow SSH and HTTP traffic.

## Goal of this part

As you prepare to troubleshoot issues that you might experience if you have the configuration that was described earlier, this part provides guidance to get information about running processes on Linux.

## Is everything in Linux a file?

You may heard the phrase "everything in Linux is file." Is this phrase really the case? Although this article series doesn't focus on Linux expertise, the Linux operating system is heavily geared towards exposing everything through the file system. This part will try to delve deeper into why this is.

According to [Wikipedia](https://wikipedia.org/wiki/Procfs), Linux is based on a special file system named *procfs*.

The proc filesystem (procfs) is a special filesystem in [Unix-like](https://wikipedia.org/wiki/Unix-like) operating systems that presents information about [processes](https://wikipedia.org/wiki/Process_(computing)) and other system information in a hierarchical file-like structure. This provides a more convenient and standardized method than traditional [tracing](https://wikipedia.org/wiki/Tracing_(software)) methods or direct access to [kernel](https://wikipedia.org/wiki/Kernel_(operating_system)) memory for dynamically accessing process data that's held in the kernel. Typically, data is mapped to a [mount point](https://wikipedia.org/wiki/Mount_(computing)#MOUNT-POINT) named */proc* at boot time. The proc file system acts as an interface to internal data structures in the kernel. You can use the file to obtain information about the system and change certain kernel parameters at runtime ([sysctl](https://wikipedia.org/wiki/Sysctl)).

Therefore, if you're a superuser on a Linux-based computer, you can access information about each of the running processes through a file system file. If [everything in Linux is a file](https://wikipedia.org/wiki/Everything_is_a_file), so is a process.

You might recall that we briefly discussed this in previous parts of this series: A process is seen as a file under the */proc/* directory. This directory is defined as a special directory [here](https://www.linux.com/news/discover-possibilities-proc-directory/):

"This special directory holds all the details about your Linux system, including its kernel, processes, and configuration parameters."

If you examine this directory by using the `ll /proc/` command, you'll see several "files" and "folders." For example, you'll see a "file" that's named `/proc/meminfo`. that, if you run the `cat /proc/meminfo` command, will yield the following detailed information about the server's memory usage statistics:

:::image type="content" source="./media/3-1-get-ready-troubleshooting/cat-meminfo-command.png" alt-text="Screenshot of cat meminfo command." border="true":::

Similarly, if you run the `cat /proc/cpuinfo` command, ou will see the following server processor information:

:::image type="content" source="./media/3-1-get-ready-troubleshooting/cat-cpuinfo-command.png" alt-text="Screenshot of cat cpuinfo command." border="true":::

If you want to get Linux OS version information, you can use `cat /proc/version` commands:

:::image type="content" source="./media/3-1-get-ready-troubleshooting/cat-version-command.png" alt-text="Screenshot of cat version command." border="true":::

And so on.

## Is a process really a file?

Regarding processes, each running process on your Linux system will be shown as a subdirectory under the *:::no-loc text="/proc/":::* folder, and each folder is named as the process ID:

:::image type="content" source="./media/3-1-get-ready-troubleshooting/ll-proc-command.png" alt-text="Screenshot of ll proc command." border="true":::

If you examine one of the process ID directories, you'll see some other files and folders. You have to prefix the command by using "sudo" to get some of the following information:

:::image type="content" source="./media/3-1-get-ready-troubleshooting/sudo-command.png" alt-text="Screenshot of sudo command." border="true":::

Examine the `cmdline` for one of the processes. Run the `sudo cat /proc/19933/cmdline` command. (The PID for the process that you'll choose will be different). The output will be as follows. (This is the BuggyAmb application that was installed and configured in Part 2).

:::image type="content" source="./media/3-1-get-ready-troubleshooting/sudo-cat-command.png" alt-text="Screenshot of sudo cat command." border="true":::

Finally let's look at the environment variables for the BuggyAmb process by running the `sudo cat /proc/19933/environ` command. In a previous part, you were instructed to use the `ASPNETCORE_URLS` environment variable. This was created to instruct the web application to listen on port 5001:

:::image type="content" source="./media/3-1-get-ready-troubleshooting/sudo-cat-environ-command.png" alt-text="Screenshot of sudo cat environ command." border="true":::

By using this file system technique, you can get lots of information about a process.

## The ps command

This article won't go into detail about this command. However, the command deserves to be mentioned here in discussing processes because it is one of the simplest ways to generate a snapshot of the current processes. We recommend that you open the "man" page by using the `man ps` command, and try it for yourself.

## Next steps

[Part 3.2 - Linux task managers, top and htop](3-2-task-managers-top-htop.md)

The next part will examine some important tools and commands that you can use to troubleshoot issues.
