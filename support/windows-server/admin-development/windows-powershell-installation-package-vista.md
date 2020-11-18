---
title: Windows PowerShell 1.0 installation package
description: This article contains links and information for the installation packages for Windows PowerShell 1.0 for Windows Vista.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Windows PowerShell
ms.technology: WindowsAdministrationManagementDevelopment
---
# Windows PowerShell 1.0 installation package

This article contains links and information for the installation packages for Windows PowerShell 1.0 for Windows Vista.

_Original product version:_ &nbsp; Windows Vista  
_Original KB number:_ &nbsp; 928439

> [!NOTE]
Support for Windows Vista without any service packs installed ended on April 13, 2010. To continue receiving security updates for Windows, make sure that you're running Windows Vista with Service Pack 2 (SP2). For more information, see the following Microsoft website:
[Support is ending for some versions of Windows](https://windows.microsoft.com/windows/help/end-support-windows-xp-sp2-windows-vista-without-service-packs)  

## Introduction

This article describes the installation package for Microsoft Windows PowerShell 1.0 in Windows Vista. This Release-To-Web (RTW) version of Windows PowerShell 1.0 installs only on the original release versions of Windows Vista.

## More information

Windows PowerShell 1.0 is a new task-based command-line shell and scripting language that is designed specifically for system administration. Built on the Microsoft .NET Framework, Windows PowerShell helps IT professionals and expert users control and automate the administration of the Windows operating system and the applications that run on Windows.  

By using Windows PowerShell, administrators can manage their systems by typing individual commands or by running scripts that automate management tasks. Microsoft Exchange Server 2007, Microsoft System Center Operations Manager 2007, System Center Data Protection Manager V2, and System Center Virtual Machine Manager use Windows PowerShell to improve efficiency and productivity.

Windows PowerShell includes the following:

- One hundred and twenty-nine standard utilities ("cmdlets") for performing common system administration tasks, such as managing the registry, services, processes, and event logs, and for using Windows Management Instrumentation.
- A task-based scripting language and support for existing scripts and command-line tools.
- Consistent design.

    Because Windows PowerShell utilities ("cmdlets") and system data stores use common syntax and naming conventions, data can be shared easily. The output from one utility can be used as the input to another utility without reformatting or manipulation.

- Simplified, command-based navigation of the operating system lets users browse the registry and other data stores by using the same techniques that they use to browse the file system.

- Powerful object manipulation capabilities.

    Objects can be directly manipulated or sent to other tools or databases.
- Extensible interface.

    Independent software vendors and enterprise developers can build custom tools and utilities to manage their software.

For more information about Windows PowerShell, visit the following Microsoft websites:

- [Windows PowerShell website](https://www.microsoft.com/powershell)  

- [Windows PowerShell Blog](https://devblogs.microsoft.com/powershell/)  

- [Windows PowerShell Software Development Kit (SDK)](https://msdn2.microsoft.com/library/aa830112.aspx)  

### System requirements

- Windows Vista (original release version only) Windows PowerShell requires the .NET Framework 2.0. The .NET Framework 2.0 is included in Windows Vista.

### Restart requirements

You don't have to restart the computer after you install Windows PowerShell 1.0 in Windows Vista.

### Language features

This installation package is designed for all language versions of Windows Vista. These include English-language versions, localized versions, and language interface packs.

The Component-Based Servicing installation package for Windows PowerShell 1.0 automatically installs the Windows PowerShell 1.0 language pack that matches the locale that is selected for the operating system.

Windows PowerShell 1.0 is fully localized in the following languages:  

- Chinese-Simplified
- Chinese-Traditional
- English
- French
- German
- Italian
- Japanese
- Korean
- Portuguese (Brazil)
- Russian
- Spanish  

> [!NOTE]
> In locales that are associated with other languages, the Windows PowerShell 1.0 user interface appears in the fallback language or in English.

#### How to uninstall Windows PowerShell

To uninstall Windows PowerShell 1.0 in Windows Vista, follow these steps:  

1. Click **Start**, in the **Start Search** box, type appwiz.cpl, and then press ENTER.
2. In the list of tasks, click **View Installed Updates**.
3. In the **Uninstall an update** list, right-click **Windows PowerShell(TM) 1.0 (KB928439)**, click Uninstall, and then follow the instructions to remove Windows PowerShell 1.0.

To disable Windows PowerShell 1.0, follow these steps:  

1. Click **Start**, in the **Start Search** box, type appwiz.cpl, and then press ENTER.
2. In the list of tasks, click **Turn Windows features on or off**.
3. Click to clear the check box for **Windows PowerShell**.

### Windows PowerShell 1.0 for earlier versions of Windows

For more information about Windows PowerShell 1.0 for earlier versions of Windows, see the following Knowledge Base articles.

#### For Windows Server 2003 and for Windows XP (English-language)

[928439](https://support.microsoft.com/help/928439) Windows PowerShell 1.0 English Language Installation Packages for Windows Server 2003 and for Windows XP  

> [!NOTE]
> Windows PowerShell 1.0 is part of the operating system in Windows Server 2008. No installation is required.

#### Installation folders

Windows PowerShell 1.0 is installed in the following folders. The location of the Windows PowerShell installation folder isn't configurable.

> [!NOTE]
> In the following examples, %windir% represents the Windows system folder. Typically, this folder is C:\Windows. In 32-bit versions of Windows, Windows PowerShell 1.0 is installed in the following folder: %windir%\System32\WindowsPowerShell\V1.0
>
> In 64-bit versions of Windows, Windows PowerShell 1.0 is installed in the following folder: %windir%\Syswow64\WindowsPowerShell\V1.0
>
> Resource files are installed in a locale-specific subfolder of the installation folder. For example, the resource files for the German version of Windows PowerShell 1.0 are installed in the following folder: %windir%\System32\WindowsPowerShell\v1.0\de-DE
>
> Help files are installed in a locale-specific subfolder in the Documents subfolder of the installation folder. For example, the Help files for the Japanese version of Windows PowerShell 1.0 are installed in the following folder: %windir%\System32\WindowsPowerShell\v1.0\Documents\ja-JP

#### Files that are installed

The following files are installed when you install Windows PowerShell 1.0:  

- About_alias.help.txt
- About_arithmetic_operators.help.txt
- About_array.help.txt
- About_assignment_operators.help.txt
- About_associative_array.help.txt
- About_automatic_variables.help.txt
- About_break.help.txt
- About_command_search.help.txt
- About_command_syntax.help.txt
- About_comparison_operators.help.txt
- About_continue.help.txt
- About_core_commands.help.txt

- About_display.xml.help.txt

- About_environment_variable.help.txt

- About_escape_character.help.txt

- About_execution_environment.help.txt

- About_filter.help.txt

- About_flow_control.help.txt

- About_for.help.txt

- About_foreach.help.txt

- About_function.help.txt
- About_globbing.help.txt
- About_history.help.txt
- About_if.help.txt

- About_line_editing.help.txt

- About_location.help.txt

- About_logical_operator.help.txt
- About_method.help.txt

- About_pssnapins.help.txt
- About_namespace.help.txt
- About_object.help.txt
- About_operator.help.txt

- About_parameter.help.txt

- About_parsing.help.txt

- About_path_syntax.help.txt

- About_pipeline.help.txt

- About_property.help.txt

- About_provider.help.txt

- About_quoting_rules.help.txt
- About_redirection.help.txt
- About_ref.help.txt
- About_regular_expression.help.txt
- About_reserved_words.help.txt
- About_scope.help.txt

- About_script_block.help.txt

- About_shell_variable.help.txt

- About_signing.help.txt

- About_special_characters.help.txt

- About_switch.help.txt

- About_system_state.help.txt
- About_types.help.txt
- About_commonparameters.help.txt

- About_where.help.txt

- About_while.help.txt

- About_wildcard.help.txt

- Default.help.txt

- Microsoft.powershell.commands.management.dll

- Microsoft.powershell.commands.management.dll-help.xml
- Microsoft.powershell.commands.utility.dll
- Microsoft.powershell.commands.utility.dll-help.xml
- Microsoft.powershell.consolehost.dll

- Microsoft.powershell.consolehost.dll-help.xml

- Microsoft.powershell.security.dll

- Microsoft.powershell.security.dll-help.xml
- Microsoft.powershell.commands.management.resources.dll
- Microsoft.powershell.commands.utility.resources.dll

- Microsoft.powershell.consolehost.resources.dll

- Microsoft.powershell.security.resources.dll
- System.management.automation.resources.dll

- System.management.automation.dll

- System.management.automation.dll-help.xml
- Dotnettypes.format.ps1xml

- Filesystem.format.ps1xml

- Registry.format.ps1xml

- Certificate.format.ps1xml

- Help.format.ps1xml

- Types.ps1xml

- Powershellcore.format.ps1xml
- Powershelltrace.format.ps1xml
- Pwrshmsg.dll

- Pwrshsip.dll

- Pwrshmsg.dll.mui

- Powershell.exe

- Powershell.exe.mui

- Profile.ps1

- Releasenotes.rtf

- Gettingstarted.rtf

- Userguide.rtf

- Quadfold.rtf
