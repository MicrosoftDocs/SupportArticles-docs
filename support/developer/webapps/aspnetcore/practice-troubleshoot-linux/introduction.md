---
title: Overview of ASP.NET Core on Linux troubleshooting
description: This article provides an overview of how to troubleshoot ASP.NET Core applications on Linux and what you should consider before the troubleshooting.
ms.date: 03/08/2021
ms.custom: linux-related-content
ms.reviewer: ramakoni, ahmetmb
author: ahmetmithat
---
# Overview of ASP.NET Core on Linux troubleshooting

_Applies to:_ &nbsp; .NET Core 2.1, .NET Core 3.1, .NET 5  

This article provides an overview of how to troubleshoot ASP.NET Core applications on Linux and what you should consider before the troubleshooting.

## Prerequisites

This training series targets an audience that has no previous experience with the Linux operating system. The goal is to enable someone who has little or no knowledge about Linux to get started quickly on installing, managing, and troubleshooting ASP.NET Core applications on Linux.

Any experience that you might have in troubleshooting web applications is a plus. However, it's not necessary. Users who try to follow this tutorial but lack troubleshooting experience should not be concerned about that. Throughout the series, you'll learn the reasoning behind every action. The goal is to provide a general, hands-on approach to troubleshooting different kinds of problems that you might encounter when you run ASP.NET Core workloads on Linux.

The main prerequisite is to have a Linux virtual machine available so that you can follow the proposed exercises throughout the training.

## What is covered in this series

This troubleshooting training covers the following topics.

### Part 1 - Connect to a Linux computer and manage basic tasks

Part 1 is for those who have no previous experience with Linux. It covers the following topics:

- How to create a Linux virtual machine in Microsoft Azure. You can skip this step if you already have access to a Linux virtual machine. The training will make use of an Ubuntu x18.04 LTS virtual machine. We recommend that you use the same distribution of Linux if you want to follow along with the exercises.
- How to connect to a Linux virtual machine from a Windows-based computer.

If you already have a Linux virtual machine, you can skip this part entirely and start at Part 2 directly.

### Part 2 - Install and run ASP.NET Core applications in Linux

In Part 2, we will learn the following:

- How to install .NET Core on Linux, and how to run ASP.NET Core applications on this operating system.
- How to configure ASP.NET Core applications to start automatically.
- How to host multiple web applications behind a reverse proxy.
- How to deploy ASP.NET Core applications to a Linux virtual machine from a Windows-based computer.

You'll also practice how to manage basic tasks when you work with the Linux operating system, such as creating and deleting files and folders, working with compressed files and folders, running commands as a privileged user, and installing applications by using package managers.

If you already know how to install and run ASP.NET Core applications, and you want to learn about troubleshooting, you can start at Part 3, and then continue to the troubleshooting labs.

### Part 3 - Troubleshooting ASP.NET Core application issues on Linux

Part 3 focuses on the tools and commands that you can use to troubleshoot application issues on Linux. We will explore the following scenarios:

- Checking the CPU and memory usage of a process.
- Using core dump files to analyze crash and performance problems.
- Capturing and analyzing core dump files, and discussing the tools that we use to do this.

### Part 4 - Troubleshooting labs

The troubleshooting labs in this series are based on a sample application, BuggyAmb. Part 4 covers the following techniques:

- Downloading and installing the "BuggyAmb" sample application on Linux.
- Addressing an ASP.NET Core application crash by checking the system and application logs, and analyzing a system-generated core dump file.
- Collecting and analyzing core dump files by using .NET development tools to troubleshoot a crash problem.
- Collecting core dump files by using .NET tools and ProcDump to troubleshoot a performance issue.
- Analyzing core dump files on a Windows computer:
  - Windows Subsystem for Linux (WSL2)
  - Docker containers

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]
