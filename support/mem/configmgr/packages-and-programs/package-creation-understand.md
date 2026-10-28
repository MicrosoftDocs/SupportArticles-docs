---
title: Package creation in Configuration Manager
description: Learn how package creation works in Configuration Manager, and how to use logs to trace package and program creation, notifications, and permission sync.
author: Yupiter2005
ms.author: payur
ms.date: 10/27/2026
ms.topic: concept-article
ai-usage: ai-assisted
ms.manager: dcscontentpm
ms.reviewer: pusin, sagarjoshi
ms.custom: sap:Application Management\Packages and Programs
#customer intent: As a Configuration Manager administrator, I want to understand server-side package and program creation so that I can trace object creation and component processing in logs.
---

# Package creation in Configuration Manager

## Summary

In Configuration Manager, a package defines the metadata and optional source content for software distribution, and a program defines the command and execution settings that a client uses. Understanding how these objects are created helps you trace server-side processing and distinguish creation from deployment.

This article explains how the SMS Provider, SMS Database Monitor, Hierarchy Manager, and Distribution Manager process package and program creation. Use the log examples and status messages to follow object creation, permission synchronization, and package processing. Creating a package or program doesn't deploy it to clients.

## Package and program relationship

A *package* supplies metadata and, optionally, source content. A *program* defines the command and execution settings within that package.

The following table lists the SMS Provider WMI classes used for package and program creation, their identifying properties, and their purposes.

| WMI class | Key identity | Purpose |
| --- | --- | --- |
| `SMS_Package` | `PackageID` | Identifies the package and its source-content settings. |
| `SMS_Program` | `PackageID` and `ProgramName` | Defines the command and its execution settings. |

Creating a package or program normally doesn't create client deployment policy.

## Package and program creation flow

The SMS Provider creates and validates package and program objects. Database notifications then initiate security synchronization and package processing. The examples in this article use placeholders instead of environment-specific identifiers. Log excerpts illustrate the processing sequence.

:::image type="content" source="./media/package-program-creation-flow.png" alt-text="Diagram that shows package and program creation through SMSDBMON notifications to permission synchronization and content processing." lightbox="./media/package-program-creation-flow-expanded.png":::

### SMS Provider creates the package

The Configuration Manager console calls the SMS Provider to create an `SMS_Package` WMI instance. The provider validates package settings and administrator permissions, saves the package, and assigns a `PackageID`.

Configuration Manager also creates an internal default program named `*` for package processing. This program isn't the administrator-defined program that contains the command line to deploy.

In `smsprov.log`, the sequence includes the initiating console and security context, authentication and role-based administration (RBAC) validation, package metadata, the assigned identifier, scoped-access security records, and auditing.

Representative `smsprov.log` entries:

```output
Context: SMSAppName=Configuration Manager Administrator Console
Context: UserName=[user@contoso.com]
Context: MachineName=[SiteSystem]
Requested class = SMS_Package
Property Name = [PackageName]
Property PkgSourcePath = \\[SiteSystem]\Sources\[PackageName]
Auditing: User [user@contoso.com] created an instance of class SMS_Package
PackageID = [PackageID]
Successfully committed SMS_Package instance
```

### SMS Provider creates the administrator-defined program

The **Create Program Wizard** creates an `SMS_Program` instance under the package. The combination of `PackageID` and `ProgramName` uniquely identifies the program.

During creation, the SMS Provider:

- Requires a program name of 1 through 50 characters and a nonempty command line of no more than 512 characters.
- Checks for circular program dependencies.
- Rejects a duplicate nonempty MSI product ID within the same package. This ID applies to Windows Installer Source Location.
- Confirms that the administrator can modify the parent package.
- Records the program and its execution settings in the site database.

Configuration Manager verifies that the parent package exists and saves the program's execution settings and operating-system requirements.

Program properties include:

- `PackageID` and `ProgramName`.
- `CommandLine`, working directory, and drive settings.
- Program and device flags that control execution.
- Requirements and supported operating systems.
- A dependent program, if configured.
- Estimated run time.
- MSI product ID and MSI file path, when applicable.

Representative `smsprov.log` entries:

```output
Requested class = SMS_Program
Property PackageID = [PackageID]
Property ProgramName = [ProgramName]
Property CommandLine = [CommandLine]
Auditing: User [user@contoso.com] created an instance of class SMS_Program
Successfully committed SMS_Program instance
```

Program creation changes the execution definition. It doesn't create a deployment or target clients. It can notify Distribution Manager because program metadata participates in package processing.

### SMSDBMON generates component notifications

After Configuration Manager saves package or program changes, SMS Database Monitor (SMSDBMON) notifies the components that process them.

SMSDBMON places `.PKN` files in the Distribution Manager inbox for package processing and `.RBC` files in the Hierarchy Manager inbox for security synchronization.

Representative verbose `smsdbmon.log` entries:

```output
SND: Dropped ...\inboxes\distmgr.box\[PackageID].PKN
SND: Dropped ...\inboxes\hman.box\[RecordID].RBC
```

### Hierarchy Manager synchronizes RBAC

Hierarchy Manager processes the `.RBC` notification and synchronizes RBAC permissions.

Representative `hman.log` entries:

```output
HandleRBACPermissions: Check if there is request.
HandleRBACPermissions: Get 1 request, try to sync.
End sync rbac permissions.
```

### Distribution Manager processes package and program metadata

Distribution Manager processes the `.PKN` notification and reads the package and program metadata committed by the SMS Provider. It processes the source path and content properties and incorporates the program definitions into package metadata.

When source files are present, this work includes taking a source snapshot, generating hash and signature metadata, assigning a content version, and maintaining content library entries. Distribution Manager processes package version information and distributes content to assigned distribution points.

> [!NOTE]
> Package property and program setting changes can trigger Distribution Manager even when source files don't change. This processing doesn't mean that a deployment or client policy exists.

Representative `distmgr.log` entries:

```output
Started package processing thread for package '[PackageID]'
Processing package '[PackageID]' (SourceVersion: [Version])
Taking package snapshot for package '[PackageID]'
Writing package definition for '[PackageID]'
Successfully created package for package '[PackageID]' version [Version]
Adding these contents to the package '[PackageID]' version [Version]
Successfully created/updated the package '[PackageID]'
```

For content distribution details, see [Overall introduction of content distribution](../content-management/content-distribution-introduction.md).

## Status messages for package and program creation

Configuration Manager records status messages in the site database for auditing, monitoring, and reporting. You can review these messages in the Configuration Manager console to trace administrative actions and component processing without reading individual log files. Start with status messages to check progress and outcomes, and review the logs when you need more detail.

The following table lists audit and component status messages associated with package and program creation, including the component, message ID, and description.

| Component | Message ID | Description |
| --- | --- | --- |
| `SMS_DISTRIBUTION_MANAGER` | 2301 | Distribution Manager successfully processed (ProgramName) (PackageID). |
| `SMS_DISTRIBUTION_MANAGER` | 2311 | Distribution Manager successfully created or updated (ProgramName). |
| `SMS_DISTRIBUTION_MANAGER` | 2376 | Distribution Manager created a snapshot for content (PackageID) successfully. |
| `SMS_DISTRIBUTION_MANAGER` | 2300 | Distribution Manager is beginning to process (ProgramName) (PackageID). |
| `Microsoft.ConfigurationManagement.exe` | 30003 | User created a program named `[ProgramName]` that belongs to `[PackageID]`. |
| `Microsoft.ConfigurationManagement.exe` | 30000 | User created package `[PackageName]` with `[PackageID]`. |

At this stage, the package and administrator-defined program exist in the site database. Client policy creation starts only when the package and program pair is deployed.

## Next steps

- For supported creation instructions, see [Packages and programs in Configuration Manager](/intune/configmgr/apps/deploy-use/packages-and-programs).
- To follow the server-side deployment flow, see [Program deployment in Configuration Manager](package-deployment-understand.md).
