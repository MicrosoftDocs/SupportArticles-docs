---
title: Using WSL to open core dumps in another machine
description: This article describes how to use Windows Subsystem for Linux to open a core dump in another machine.
ms.date: 06/18/2021
ms.prod: aspnet-core
ms.reviewer: ramakoni, ahmet.bostanci
---
# Lab 4.2 Analyzing core dumps in another machine - Using WSL to open core dumps

_Applies to:_ &nbsp; .NET Core 2.1, .NET Core 3.1  

This article introduces how to use Windows Subsystem for Linux (WSL) version 2 to open a core dump in Windows machine.

## Prerequisites

To be able to follow along and complete this section, you should have:

- A Windows 10 machine to enable WSL ([Windows Subsystem for Linux](windows/wsl/install-win10)).
- At least one core dump file copied on your Windows machine in any directory.

## Goal of this lab

You will learn how to open a core dump in another machine using Windows Subsystem for Linux (WSL) version 2.

## Using Windows Subsystem for Linux

As explained in this [article](/windows/wsl/about), WSL lets developers run a GNU/Linux environment directly on Windows without the overhead of a traditional virtual machine or dual-boot setup.

Visit this [page](/windows/wsl/install-on-server) to enable WSL and then upgrade to WSL2. The training assumes you have chosen the same Ubuntu 18.04 LTS once again your Linux operating system, which will be run using WSL2.

Once you installed the WSL2, update the package manager using the `sudo apt update` and `sudo apt upgrade` commands. You should be familiar with these commands from the earlier sections of this series when you installed the Linux machine the first time.

- sudo apt update:

    :::image type="content" source="./media/lab-4-2-analyze-core-dumps-another-machine-wsl/update.png" alt-text="BuggyAmb update" border="true":::

- sudo apt upgrade:

    :::image type="content" source="./media/lab-4-2-analyze-core-dumps-another-machine-wsl/upgrade.png" alt-text="BuggyAmb upgrade" border="true":::

## Copying files from Windows to Linux

You should now have WSL2 running inside your Windows machine. In the previous section, you have copied core dump files in your Windows machine's *D:\Learn\Linux\Dumps* folder and the file name was assumed to be *coredumps.tar.gz*. Your goal now is to copy *D:\Learn\Linux\Dumps\coredumps.tar.gz* to the Linux machine running inside WSL2.

Looking at the screenshot below of the command line in WSL2 notice that the *C:* drive in Windows is mapped as */mnt/c* in the WSL2 Linux machine. Therefore, to list the content of *D:\Learn\Linux\Dumps* folder, you can run `ll mnt/d/Learn/Linux/Dumps/` command:

:::image type="content" source="./media/lab-4-2-analyze-core-dumps-another-machine-wsl/ll.png" alt-text="BuggyAmb ll" border="true":::

Now copy and extract the *coredumps.tar.gz* file to a dumps folder inside the Linux home directory. The steps are easy:

- Change directory to your home directory using the `cd ~` command.
- Create a dumps folder with `mkdir dumps` command.
- Extract the *coredumps.tar.gz* file with `tar -xf /mnt/d/Learn/Linux/Dumps/coredumps.tar.gz -C dumps/` command.

The below screenshot shows these commands in action:

:::image type="content" source="./media/lab-4-2-analyze-core-dumps-another-machine-wsl/cd.png" alt-text="BuggyAmb cd" border="true":::

## Opening core dump using dotnet-dump

The rest of the procedure is similar with the earlier troubleshooting labs where you have installed the .NET Core and .NET SDK, however, this section will take you through those steps once again.

The dotnet-dump tool requires .NET SDK so before installing dotnet-dump, you need to install the .NET SDK first. As discussed earlier, before installing the .NET you need to add the Microsoft package signing key to the list of trusted keys and then add the package repository as explained [here](/dotnet/core/install/linux-ubuntu#1804-). See the steps in action in the screenshot below:

:::image type="content" source="./media/lab-4-2-analyze-core-dumps-another-machine-wsl/sudo.png" alt-text="BuggyAmb sudo" border="true":::

Now you are ready to install the latest SDK, again, as explained in this [article](/dotnet/core/install/linux-ubuntu#1804-). Below is the Windows Terminal showing the result of the commands:

:::image type="content" source="./media/lab-4-2-analyze-core-dumps-another-machine-wsl/sdk.png" alt-text="BuggyAmb sdk" border="true":::

You will open the core dump using dotnet-dump so you need to install the tool first. As discussed earlier, the command to install dotnet-dump as global tool is `dotnet tool install -g dotnet-dump`:

:::image type="content" source="./media/lab-4-2-analyze-core-dumps-another-machine-wsl/dotnet.png" alt-text="BuggyAmb dotnet" border="true":::

Following the installation, you are now ready to start exploring the core dumps. Open the core dump using dotnet-dump. As you did in the previous lab, you will run the following command: `dotnet-dump analyze ~/dumps/coredump.manual.1.11724`

:::image type="content" source="./media/lab-4-2-analyze-core-dumps-another-machine-wsl/dump.png" alt-text="BuggyAmb dump" border="true":::

Run `clrthreads` command to display the managed threads, however, this command should fail with an error message:

:::image type="content" source="./media/lab-4-2-analyze-core-dumps-another-machine-wsl/dump2.png" alt-text="BuggyAmb dump2" border="true":::

The error message is the following: **Cannot load or initialize mscordaccore.dll. The target runtime may not be initialized**.

If you get this error, it is because the required .NET Core runtime is not installed in the Linux machine. As explained in this [article](/dotnet/core/diagnostics/debug-linux-dumps), in order to analyze .NET Core dumps, LLDB, and SOS require the following .NET Core binaries from the environment the dump was created in:

- libmscordaccore.so
- libcoreclr.so
- dotnet (the host used to launch the app)

This was not a problem in our earlier troubleshooting labs because we analyzed the dumps in the same machine where the application was hosted and running so the files were already present there. Now you must either copy the correct version of these files from somewhere (from the machine where the core dumps were taken, for example), or, you have to install the same .NET runtime in the machine WSL2 Linux machine.

There could be many ways to find out the target .NET Core runtime, the easiest one is "asking the application owner", or, if you are the owner, you will know the application's target .NET Core runtime. What happens if you do not possess that information at all? There is a SOS extension command, which is `lm` or `modules` which lists the "native modules" loaded in the process. Run this command to find out the version of our .NET:

:::image type="content" source="./media/lab-4-2-analyze-core-dumps-another-machine-wsl/modules.png" alt-text="BuggyAmb modules" border="true":::

As seen in the screenshot above, the .NET Core runtime version was 3.1.10. As discussed above, you need the correct version of libmscordaccore.so, libcoreclr.so, and dotnet and you can copy those files from the machine where the core dump files were generated.

Is there another way to achieve the same result: can you install .NET Core runtime version 3.1.10 to have those files? The short answer is, yes, we can. But we cannot install it using the `sudo apt install dotnet-runtime-3.1.10` command:

:::image type="content" source="./media/lab-4-2-analyze-core-dumps-another-machine-wsl/apt.png" alt-text="BuggyAmb apt" border="true":::

We can install the .NET Core runtime 3.1 but it will install that latest .NET Core 3.1 version, which is .NET Core 3.1.15 when this article was written:

:::image type="content" source="./media/lab-4-2-analyze-core-dumps-another-machine-wsl/install.png" alt-text="BuggyAmb install" border="true":::

And it will not work because the core dump file is for a .NET Core 3.1.10 process and you have to have the exact version of those necessary files.

Fortunately there is a [dotnet-symbol tool](/dotnet/core/diagnostics/dotnet-symbol) which can download the files (symbols, DAC, modules, etc.) needed for debugging core dump files. Again, you will remember this tool from our earlier sections. To install this tool, we will run `dotnet tool install -g dotnet-symbol` command:

:::image type="content" source="./media/lab-4-2-analyze-core-dumps-another-machine-wsl/tool.png" alt-text="BuggyAmb tool" border="true":::

Now you need to ask dotnet-symbol tool to download the necessary files targeting our core dump file. I am passing the core dump file name and other necessary parameters: `dotnet-symbol --host-only --debugging ~/dumps/coredump.manual.1.11724`:

:::image type="content" source="./media/lab-4-2-analyze-core-dumps-another-machine-wsl/symbol.png" alt-text="BuggyAmb symbol" border="true":::

You can ignore the last two errors from the listing, the necessary files are downloaded in the *~/dumps* folder:

:::image type="content" source="./media/lab-4-2-analyze-core-dumps-another-machine-wsl/ll2.png" alt-text="BuggyAmb ll2" border="true":::

Open the core dump with dotnet-dump and try to run the same `clrthreads` commands:

:::image type="content" source="./media/lab-4-2-analyze-core-dumps-another-machine-wsl/clrthreads.png" alt-text="BuggyAmb clrthreads" border="true":::

You should now be able to open the core dump in our Windows machine using WSL2.

## Opening dump in lldb

This lab will not explain the steps once again because it is same as you were instructed to do in the earlier troubleshooting labs. You should have already covered the important part above which was to get the necessary files to debug core dump files with dotnet-dump and the procedure is the same for LLDB. If you want to install and use lldb for debugging, check the previous labs.

## What if dotnet-symbol cannot find the necessary files?

dotnet-symbol will work for most of the core dumps. If, for some reason, it fails to download the necessary files, there are ways to work around the blocker. You can download the binaries from Microsoft's official page and extract it, then copy the necessary files manually to the same folder where the core dump file is located.

For example, if you need the files for .NET Core 3.1.10 x64 then you can download the binaries from this link and copy the following files manually:

- .\shared\Microsoft.NETCore.App\3.1.10\libcoreclr.so
- .\shared\Microsoft.NETCore.App\3.1.10\libmscordaccore.so
- .\shared\Microsoft.NETCore.App\3.1.10\libmscordbi.so
- .\shared\Microsoft.NETCore.App\3.1.10\
- .\dotnet

If the target runtime version is a private one (remember that .NET Core is open source and you can build and use your own private version), then you will need to copy these files from the Linux machine where the core dump has been generated.

## Next steps

[Lab 4.3 Analyzing core dumps in another machine - Using Docker to open core dumps](lab-4-3-analyze-core-dumps-another-machine-docker.md)