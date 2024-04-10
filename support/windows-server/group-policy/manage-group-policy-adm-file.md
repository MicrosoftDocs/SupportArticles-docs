---
title: Recommendations for managing Group Policy administrative template (.adm) files
description: Describes how ADM files work, the policy settings that are available to manage their operation, and recommendations about how to handle common ADM file management scenarios
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Group Policy\Group Policy management (GPMC or GPedit), csstroubleshoot
---
# Recommendations for managing Group Policy administrative template (.adm) files

This article describes how ADM files work, the policy settings that are available to manage their operation, and recommendations about how to handle common ADM file management scenarios.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 816662

> [!NOTE]
> We recommend that you use Windows Vista to manage the Group Policy infrastructure by using a central store. This recommendation holds true even when the environment has a mix of down-level clients and servers, such as computers that are running Windows XP or Windows Server 2003. Windows Vista uses a new model that employs ADMX and ADML files to manage Group Policy templates.
>
> For more information, visit the following Web sites:
>
> - [Deploying Group Policy Using Windows Vista](/previous-versions/windows/it-pro/windows-vista/cc766208(v=ws.10))
> - [How to create the Central Store for Group Policy Administrative Template files in Windows Vista](create-central-store-domain-controller.md)
>
> If you must use Windows XP-based or Windows Server 2003-based computers to manage the Group Policy infrastructure, see the recommendations in this article.

## Introduction to ADM files

ADM files are template files that are used by Group Policies to describe where registry-based policy settings are stored in the registry. ADM files also describe the user interface that administrators see in the Group Policy Object Editor snap-in. Group Policy Object Editor is used by administrators when they create or modify Group Policy objects (GPOs).

## ADM file storage and defaults

In the Sysvol folder of each domain controller, each domain GPO maintains a single folder, and this folder is named the Group Policy Template (GPT). The GPT stores all the ADM files that were used in Group Policy Object Editor when the GPOs were last created or edited.

Each operating system includes a standard set of ADM files. These standard files are the default files that are loaded by Group Policy Object Editor. For example, Windows Server 2003 includes the following ADM files:

- System.adm
- Inetres.adm
- Conf.adm
- Wmplayer.adm
- Wuau.adm

## Custom ADM files

Custom ADM files can be created by program developers or IT professionals to extend the use of registry-based policy settings to new programs and components.

> [!NOTE]
> Programs and components must be designed and coded to recognize and respond to the policy settings that are described in the ADM file.

To load ADM files in Group Policy Object Editor, follow these steps:

1. Start the Group Policy Object Editor.
2. Right-click **Administrative Templates**, and then click **Add/Remove Templates**.

    > [!NOTE]
    > Administrative Templates are available under either **Computer** or **User Configuration**. Select the configuration that is correct for your custom template.
3. Click **Add**.
4. Click an ADM file, and then click **Open**.
5. Click **Close**.
6. The custom ADM file policy settings are now available in Group Policy Object Editor.

## Update ADM files and timestamps

Each administrative workstation that is used to run Group Policy Object Editor stores ADM files in the %windir%\\Inf folder. When GPOs are created and first edited, the ADM files from this folder are copied to the Adm subfolder in the GPT. This includes the standard ADM files and any custom ADM files that are added by the administrator.

> [!NOTE]
> Creating a GPO without later editing that GPO creates a GPT without any ADM files.

By default, when GPOs are edited, Group Policy Object Editor compares the timestamps of the ADM files in the workstation's %windir%\\Inf folder with those that are stored in the GPTs Adm folder. If the workstation's files are newer, Group Policy Object Editor copies these files to the GPT Adm folder, overwriting any existing files of the same name. This comparison occurs when the Administrative Templates node (computer or user configuration) is selected in Group Policy Object Editor, regardless of whether the administrator actually edits the GPO.

> [!NOTE]
> The ADM files stored in the GPT can be updated by viewing a GPO in Group Policy Object Editor.

Because of the importance of timestamps on ADM file management, editing of system-supplied ADM files is not recommended. If a new policy setting is required, Microsoft recommends that you create a custom ADM file. This prevents the replacement of system-supplied ADM files when service packs are released.

### Group Policy Management Console

By default, the Group Policy Management Console (GPMC) always uses local ADM files, regardless of their time stamp, and never copies the ADM files to the Sysvol. If an ADM file is not found, GPMC looks for the ADM file in the GPT. Also, the GPMC user can specify an alternative location for ADM files. If an alternative location is specified, this alternative location takes precedence.

## GPO replication

The File Replication Service (FRS) replicates the GPTs for GPOs throughout the domain. As part of the GPT, the Adm subfolder is replicated to all domain controllers in the domain. Because each GPO stores multiple ADM files, and some can be quite large, you must understand how ADM files that are added or updated when you use Group Policy Object Editor can affect replication traffic.

## Use policy settings to control ADM file updates

Two policy settings area available to help with management of ADM files. These settings make it possible for the administrator to tune the use of ADM files for a specific environment. These are the "Turn off automatic updates of ADM files" and the "Always use local ADM files for Group Policy Editor" settings.

### Turn off automatic updates of ADM files

This policy setting is available under User Configuration\\Administrative Templates\\System\\Group Policy in Windows Server 2003, in Windows XP, and in Windows 2000. This setting may be applied to any Group Policy-enabled client.

### Always use local ADM files for Group Policy editor

This policy setting is available under Computer Configuration\\Administrative Templates\\System\\Group Policy. This is a new policy setting. It may be successfully applied only to Windows Server 2003 clients. The setting may be deployed to older clients, but it will have no effect on their behavior. If this setting is enabled, Group Policy Object Editor always uses local ADM files in the local system %windir%\\Inf folder when you edit a Group Policy object.

> [!NOTE]
> If this policy setting is enabled, the Turn off automatic updates of ADM files policy setting is implied.

## Common scenarios and recommendations for multilanguage administration issues

In some environments, policy settings may have to be presented to the user interface in different languages. For example, an administrator in the United States may want to view policy settings for a specific GPO in English, and an administrator in France may want to view the same GPO by using French as their preferred language. Because the GPT can store only one set of ADM files, you cannot use the GPT to store ADM files for both languages.

For Windows 2000, the use of local ADM files by Group Policy Object Editor is not supported. To work around this, use the "Turn off automatic updates of ADM files" policy setting. Because this policy setting has no effect on the creation of new GPOs, the local ADM files will be uploaded to the GPT in Windows 2000, and creating a GPO in Windows 2000 effectively defines "the language of the GPO". If the "Turn off automatic updates of ADM files" policy setting is in effect at all Windows 2000 workstations, the language of the ADM files in the GPT will be defined by the language of the computer that is used to create the GPO.

For administrators that are using Windows XP and Windows Server 2003, the "Always use local ADM files for Group Policy editor" policy setting can be used. This makes it possible for the French administrator to view policy settings by using the ADM files that are installed locally on his or her workstation (French), regardless of the ADM file that is stored in the GPT. When you use this policy setting, it is implied that the "Turn off automatic updates of ADM files" policy setting is enabled to avoid unnecessary updates of the ADM files to the GPT.

Also, consider standardizing on the latest operating system from Microsoft for administrative workstations in a multi-language administrative environment. Then configure both the "Always use local ADM files for Group Policy editor" and "Turn off automatic updates of ADM files" policy settings.

If Windows 2000 workstations are being used, use the "Turn off automatic updates of ADM files" policy setting for administrators and consider the ADM files in the GPT to be the effective language for all Windows 2000 workstations.

> [!NOTE]
> Windows XP workstations may still use their local, language specific versions.

## Common scenarios and recommendations for operating system and service pack release issues

Each operating system or service pack release includes a superset of the ADM files provided by earlier releases, including policy settings that are specific to operating systems that are different to those of the new release. For example, the ADM files that are provided with Windows Server 2003 include all policy settings for all operating systems, including those that are only relevant to Windows 2000 or Windows XP Professional. This means that only viewing a GPO from a computer with the new release of an operating system or service pack effectively upgrades the ADM files. As later releases are typically a superset of previous ADM files, this will not typically create problems, assuming that the ADM files that are being used have not been edited.

In some situations, an operating system or service pack release may include a subset of the ADM files that was provided with earlier releases. This has the potential to present an earlier subset of the ADM files, resulting in policy settings no longer being visible to administrators when they use Group Policy Object Editor. However, the policy settings will remain active in the GPO. Only the visibility of the policy settings in Group Policy Object Editor is affected. Any active (either Enabled or Disabled) policy settings are not visible in Group Policy Object Editor, but remain active. Because the settings are not visible, it is not possible for the administrator to view or edit these policy settings. To work around this issue, administrators must become familiar with the ADM files that are included with each operating system or service pack release before using Group Policy Object Editor on that operating system, keeping in mind that the act of viewing a GPO is enough to update the ADM files in the GPT, when the timestamp comparison determines an update is appropriate.

To plan for this in your environment, Microsoft recommends that you either:

- Define a standard operating system/service pack from which all viewing and editing of GPOs occurs, making sure that the ADM files that are being used include the policy settings for all platforms.

- Use the "Turn off automatic updates of ADM files" policy setting for all Group Policy administrators to make sure that ADM files are not overwritten in the GPT by any Group Policy Object Editor session, and make sure that you are using the latest ADM files that are available from Microsoft.

> [!NOTE]
> The "Always use local ADM files for Group Policy editor" policy is typically used with this policy, when it is supported by the operating system from which Group Policy Object Editor is run.

## Remove ADM files from the Sysvol folder

By default, ADM files are stored in the GPT, and this can significantly increase the Sysvol folder size. Also, frequent editing of GPOs can result in a significant amount of replication traffic. Using a combination of the "Turn off automatic updates of ADM files" and "Always use local ADM files for Group Policy editor" policy settings can greatly reduce the size of Sysvol folder and reduce policy-related replication traffic where a significant number of policy edits occur.

If the size of the Sysvol volume or Group Policy-related replication traffic becomes problematic, consider implementing an environment where the Sysvol does not store any ADM files. Or consider maintaining ADM files on administrative workstations. This process is described in the following section.

To clear the Sysvol folder of ADM files, follow these steps:

1. Enable the "Turn off automatic update of ADM files" policy setting for all Group Policy administrators who will be editing GPOs.
2. Make sure that this policy has been applied.
3. Copy any custom ADM templates to the %windir%\\Inf folder.
4. Edit existing GPOs, and then remove all ADM files from the GPT. To do this, right-click **Administrative Templates**, and then click **Add/Remove Template**.
5. Enable the "Always use local ADM files for Group Policy Object Edit" policy setting for administrative workstations.

## Maintain ADM files on administrative workstations

When you use the "Always use local ADM files for Group Policy editor" policy setting, make sure that each workstation has the latest version of the default and custom ADM files. If all ADM files are not available locally, some policy settings that are contained in a GPO will not be visible to the administrator. Avoid this by implementing a standard operating system and service pack version for all administrators. If you cannot use a standard operating system and service pack, implement a process to distribute the latest ADM files to all administrative workstations.

> [!NOTE]
>
> - Because the workstation ADM files are stored in the %windir%\\Inf folder, any process that is used to distribute these files must run in the context of an account that has administrative credentials on the workstation.
> - Windows XP does not support editing GPOs when there are no ADM files in the Sysvol folder. In a live environment, you must consider this design limitation.
