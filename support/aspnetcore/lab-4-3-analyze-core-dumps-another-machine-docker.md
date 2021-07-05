---
title: Using Docker to open core dumps in another machine
description: This article describes how to use Docker to open a core dump in another machine.
ms.date: 06/11/2021
ms.prod: aspnet-core
ms.reviewer: ramakoni, ahmet.bostanci
---
# Lab 4.3 Analyzing core dumps in another machine - Using Docker to open core dumps

_Applies to:_ &nbsp; .NET Core 2.1, .NET Core 3.1  

This article introduces how to use Docker to open a core dump in Windows machine.

## Prerequisites

To complete this section, you should have at least one core dump file copied on your Windows machine in any directory.

## Goal of this lab

You will learn how to open a core dump in another Linux machine using Docker.

## What is a container and what is Docker?

According to the [official documentation](https://www.docker.com/resources/what-container):

A container is a standard unit of software that packages up code and all its dependencies, so the application runs quickly and reliably from one computing environment to another. A Docker container image is a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries and settings.

Simply, you can use Docker containers to run and deploy your applications. You can create Docker containers from different OS images, such as Windows Core or Ubuntu and for the purposes of this exercise, you be guided on how to create an Ubuntu container to analyze our core dump file.

To create and use Docker containers in Windows machine, you can install [Docker Desktop for Windows](https://docs.docker.com/docker-for-windows/install/). The same article explains the requirements and the installation steps. As you will see from the requirements, it will use Windows Subsystem For Linux (WSL) for Linux containers.

As a first step, please install the Docker Desktop for Windows if it is not installed on your machine.

> [!NOTE]
> The Docker can run Windows and Linux containers but not at the same time. So, you will need to switch to Linux containers.

Before moving on, it is recommended that you to look at the [FAQ](https://docs.docker.com/desktop/faqs/) first to get familiar with the Docker.

## Creating a dockerfile

Once you installed the Docker Desktop on Windows, you will need a "dockerfile". A dockerfile is simply a set of instructions to create the container. The file name "dockerfile" is case-sensitive and it should be all lower-case and it does not have any extension.

You can run commands on the target container with RUN command, for example, as seen in the dockerfile below, you can run `RUN mkdir /dumps` command to run a `mkdir /dumps` command in the target container OS.

Here is a sample dockerfile content to allow you to achieve this section's goal: creating an Ubuntu container using the latest Ubuntu image, installing the latest dotnet SDK, updating the OS, installing the dotnet-dump and dotnet-symbol tools, copying and extracting the dump files and downloading the necessary files with dotnet-symbol tool against one of the core dump files.

> [!NOTE]
> The comments are starting with # sign and comments are present for each line so you can understand what each command does:

```cmd
# Install the latest Ubuntu container image
FROM ubuntu:latest
 
# Install the latest dotnet SDK
FROM mcr.microsoft.com/dotnet/core/sdk:latest AS tools-install
 
# Update the OS, the "\" sign means that the command continues in the next line
RUN apt-get update \
&& apt-get upgrade -y \
&& apt-get install -y
 
# Install the dotnet-dump and dotnet-symbol tools in /dotnetcore-tools directory
RUN dotnet tool install --tool-path /dotnetcore-tools dotnet-dump
RUN dotnet tool install --tool-path /dotnetcore-tools dotnet-symbol
 
# Add the /dotnetcore-tools in PATH environment variable so we can run our dotnet-dump and dotnet-symbol tools directly
ENV PATH="/dotnetcore-tools:${PATH}"
 
# Create a /dumps folder in the Linux container
RUN mkdir /dumps
 
# Copy the coredumps.tar.gz file from Windows machine to /dumps folder in Linux machine
COPY ./coredumps.tar.gz /dumps/
 
# Extract the tar file to the /dumps folder
RUN tar -xf /dumps/coredumps.tar.gz -C /dumps
 
# Run dotnet-symbol against one of the core dump files to download the necessary files (symbols, DAC files, etc...)
RUN dotnet-symbol --host-only --debugging ~/dumps/coredump.manual.1.11724 
```

Create a file named *dockerfile* in the same directory where the *coredumps.tar.gz* archive file is located. Remember, the file name is case-sensitive, and it does not have any extension.

## Building and running the Docker container

Once again, you need to switch to Linux containers in Docker if it is running Windows containers:

:::image type="content" source="./media/lab-4-3-analyze-core-dumps-another-machine-docker/switch.png" alt-text="BuggyAmb switch" border="true":::

Then open a command line and change the directory to the folder where the *coredumps.tar.gz* and dockerfile file are located. To build the docker container, you will run `docker build -t dotnettools .` command.

> [!NOTE]
> The `-t` parameter, which means "tag": we are going to use this tag name when running our docker container.
>
> The dot sign (`.`) at the end of the command: it means that the docker build command will use the dockerfile from current directory.

Here is the output from of the build command. Since, in the output below, the same command had been executed several times, it uses its internal cache for the target image - when you run this command first, it will download the necessary files and then cache them for later usage when it is needed. It may take some time to build the image when you first run this command:

:::image type="content" source="./media/lab-4-3-analyze-core-dumps-another-machine-docker/docker.png" alt-text="BuggyAmb docker" border="true":::

Then run the container with `docker container run -it dotnettools /bin/bash` command:

:::image type="content" source="./media/lab-4-3-analyze-core-dumps-another-machine-docker/bash.png" alt-text="BuggyAmb bash" border="true":::

That is it, you are now inside the newly built Linux container. The rest is the same as before, you will open our core dump file with the same dotnet-dump command: `dotnet-dump analyze /dumps/coredump.manual.1.11724`. Here is the result from the sample environment used to build the training series:

:::image type="content" source="./media/lab-4-3-analyze-core-dumps-another-machine-docker/manual.png" alt-text="BuggyAmb manual" border="true":::

You can now run SOS commands, such as `clrthreads` to display the managed threads:

:::image type="content" source="./media/lab-4-3-analyze-core-dumps-another-machine-docker/clrthreads.png" alt-text="BuggyAmb clrthreads" border="true":::

You are ready to analyze core dump files in a Linux container using Docker.
