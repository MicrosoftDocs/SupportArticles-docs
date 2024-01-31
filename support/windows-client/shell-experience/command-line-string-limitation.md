---
title: Command prompt line string limitation
description: This article describes about limiting the maximum string length at the command prompt, and provides solutions to fix the limitation.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, djanson
ms.custom: sap:desktop-shell, csstroubleshoot
ms.subservice: shell-experience
---
# Command prompt (Cmd. exe) command-line string limitation

This article discusses the limitation to the length of the strings that you use from the command prompt in Command Prompt (Cmd.exe). It also provides methods that you can use to work around this limitation.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 830473

## More information

The maximum length of the string that you can use at the command prompt is 8191 characters.

This limitation applies to:

- the command line
- individual environment variables that are inherited by other processes, such as the PATH variable
- all environment variable expansions

If you use Command Prompt to run batch files, this limitation also applies to batch file processing.

### Examples

The following examples show how this limitation applies to commands that you run in Command Prompt, and commands that you use in a batch file.

- In Command Prompt, the total length of the following command line can't contain more than 8191 characters:

  ```console
  cmd.exe /k ExecutableFile.exe parameter1, parameter2... parameterN
  ```

- In a batch file, the total length of the following command line can't contain more than 8191 characters:

  ```console
  cmd.exe /k ExecutableFile.exe parameter1, parameter2... parameterN
  ```

  This limitation applies to command lines that are contained in batch files when you use Command Prompt to run the batch file.

- In Command Prompt, the total length of `EnvironmentVariable1` after you expand `EnvironmentVariable2` and `EnvironmentVariable3` can't contain more than 8191 characters:

  ```console
  c:> set EnvironmentVariable1 = EnvironmentVariable2 EnvironmentVariable3
  ```

- In a batch file, the total length of the following command line after you expand the parameters can't contain more than 8191 characters:

  ```console
  ExecutableFile.exe parameter1 parameter2
  ```

- Even though the Win32 limitation for environment variables is 32,767 characters, Command Prompt ignores any environment variables that are inherited from the parent process and are longer than its own limitations of 8191 characters (as appropriate to the operating system). For more information about the `SetEnvironmentVariable` function, see [SetEnvironmentVariableA function](/windows/win32/api/processenv/nf-processenv-setenvironmentvariablea).

## How to work around the limitation

To work around the limitation, use one or more of the following methods, as appropriate to your situation:

- Modify programs that require long command lines so that they use a file that contains the parameter information, and then include the name of the file in the command line.

  For example, instead of using the `ExecutableFile.exe Parameter1 Parameter2... ParameterN` command line in a batch file, modify the program to use a command line that is similar to the following command line, where *ParameterFile* is a file that contains the required parameters (parameter1 parameter2... ParameterN):

  ```console
  ExecutableFile.exe c:\temp\ParameterFile.txt
  ```

- Modify programs that use large environment variables so that the environment variables contain less than 8191 characters.

  For example, if the PATH environment variable contains more than 8191 characters, use one or more of the following methods to reduce the number of characters:

  - Use shorter names for folders and files.
  - Reduce the depth of folder trees.
  - Store files in fewer folders so that fewer folders are required in the PATH environment variable.
  - Investigate possible methods that you can use to reduce the dependency of PATH for locating .dll files.
