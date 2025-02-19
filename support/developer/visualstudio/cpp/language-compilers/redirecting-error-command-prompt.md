---
title: Redirecting error from Command Prompt
description: This article describes redirecting error messages from Command Prompt.
ms.date: 10/28/2020
ms.custom: sap:Language or Compilers\C++
---
# Redirecting error messages from Command Prompt: STDERR/STDOUT

This article describes redirecting error messages from Command Prompt.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 110930

## Summary

When redirecting output from an application using the `>` symbol, error messages still print to the screen. This is because error messages are often sent to the Standard Error stream instead of the Standard Out stream.

Output from a console (Command Prompt) application or command is often sent to two separate streams. The regular output is sent to Standard Out (STDOUT) and the error messages are sent to Standard Error (STDERR). When you redirect console output using the `>` symbol, you are only redirecting STDOUT. In order to redirect STDERR, you have to specify `2>` for the redirection symbol. This selects the second output stream that is STDERR.

## Example

The command `dir file.xxx` (where file.xxx does not exist) will display the following output:

> Volume in drive F is Candy Cane Volume Serial Number is 34EC-0876  
File Not Found

If you redirect the output to the NUL device using `dir file.xxx > nul`, you will still see the error message:

> File Not Found

To redirect the error message to NUL, use the following command:

```console
dir file.xxx 2> nul
```  

Or, you can redirect the output to one place, and the errors to another.

```console
dir file.xxx > output.msg 2> output.err
```  

You can print the errors and standard output to a single file by using the `&1` command to redirect the output for STDERR to STDOUT and then sending the output from STDOUT to a file:

```console
dir file.xxx 1> output.msg 2>&1
```
