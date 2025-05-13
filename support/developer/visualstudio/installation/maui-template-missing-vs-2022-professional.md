---
title: .NET Multi-Platform App UI Template Is Missing
description: Helps resolve an error that occurs after you install the .NET Multi-platform App UI workload.
ms.date: 12/27/2024
ms.reviewer: khgupta
ms.custom: sap:Installation\Setup, maintenance, or uninstall
---

# The .NET Multi-platform App UI template is missing in Visual Studio

## Symptoms

The .NET Multi-platform App UI (MAUI) template is missing in Visual Studio even after installing the .NET MAUI workload.

## Cause

The .NET MAUI template isn't installed.

## Resolution

To install the MAUI template, follow these steps:

1. Open the Command Prompt.
1. Run the command `dotnet workload install maui` to install the MAUI workload if it's not installed. This command installs the necessary components and dependencies for MAUI development.
1. After the MAUI workload is installed, run the command `dotnet new install Microsoft.Maui.Templates` to install the MAUI templates. This command fetches and installs the latest templates for creating MAUI projects.

Once the templates are installed, you can see the .NET MAUI template available in Visual Studio when creating a new project.

For more information on installing .NET MAUI workload in Visual Studio and building .NET MAUI apps, see [Installation](/dotnet/maui/get-started/installation) and [Build your first app](/dotnet/maui/get-started/first-app).
