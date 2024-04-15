---
title: Download and install Endpoint Protection for Linux
description: Provides the steps to download and install Microsoft System Center 2012 Endpoint Protection for Linux.
ms.date: 12/05/2023
ms.custom: linux-related-content
ms.reviewer: kaushika
---
# How to download and install System Center 2012 Endpoint Protection for Linux

This article introduces how to download and install Microsoft System Center 2012 Endpoint Protection for Linux.

_Original product version:_ &nbsp; System Center 2012 Endpoint Protection for Linux  
_Original KB number:_ &nbsp; 2696659

## Download and install System Center 2012 Endpoint Protection for Linux

> [!NOTE]
>
> - System Center 2012 Endpoint Protection for Linux is part of Core Cal and will be available on the Volume Licensing Site or together with the purchase of System Center 2012.
> - The commands in these steps may vary in each distribution.

1. Download the System Center 2012 Endpoint Protection for Linux installation package.

    > [!NOTE]
    > System Center 2012 Endpoint Protection for Linux is distributed as a binary file. The file name for the installation package varies according to the distribution for which it is designed. For example, the Scep.i386.deb.bin file is intended for Debian distributions, the Scep.i386.rpm.bin file is intended for RedHat and SUSE distributions, and the Scep.i386.tgz.bin file is intended for other Linux distributions.

2. Run the installation package. To do this, type the following command, and then press Enter.

    ```console
    sh ./file_name
    ```

    The placeholder *file_name* represents the name of the file that you downloaded in step 1.

3. After the installation is complete, verify that the main System Center 2012 Endpoint Protection for Linux services is running. To do this, type the following command, and then press Enter:

    ```powershell
    ps -C scep_daemon
    ```

4. Verify that a message is returned that resembles the following:

    > PID TTY TIME CMD
    >
    > 2226 ? 00:00:00 scep_daemon  
    > 2229 ? 00:00:00 scep_daemon

    > [!NOTE]
    > At least two System Center 2012 Endpoint Protection for Linux daemon processes run in the background. The first PID is the process and threads manager. The second PID is the System Center 2012 Endpoint Protection for Linux scanning process.
