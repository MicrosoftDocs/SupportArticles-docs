---
title: Use FoxPro to Check for Existence of a Directory
description: This article describes how to use FoxPro to Check for Existence of a Directory.
ms.date: 09/08/2020
ms.prod-support-area-path: 
ms.prod: visual-studio-family
---
# Using FoxPro to Check for Existence of a Directory

This article describes how to use FoxPro to Check for Existence of a Directory.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 94339

## Summary

There are two ways to check for the existence of a directory on a drive:

- The `FILE()` function can be used to check for the existence of a file on a local drive. `FILE()` only works on network drives under work groups.

    > [!NOTE]
    > The method described below using the `FILE()` function does not work when running FoxPro for Windows or FoxPro for MS-DOS under Windows 3.11. This method can only be used when running FoxPro for MS-DOS directly under MS-DOS versions greater than 3.0, or when running FoxPro for MS- DOS or FoxPro for Windows under Windows NT.

- The `ADIR()` and `ASCAN()` functions can be used together to check for the existence of a file on either a local or network drive.

## More information

`FILE()` attempts to locate a file or directory on disk and returns .T. or .F. based on the results of the search. Specify the filename to search for as a character string argument. To test for the existence of a directory, specify `NUL` as the filename. For example:

```console
?FILE('c:\temp\NUL')
```

The above command checks for the existence of the `C:\FOXPRO2` directory.
> [!NOTE]
> This usage of NUL is not supported by versions of MS-DOS prior to version 3.0.

`ADIR()` places file information in an array. The resulting array contains five columns, containing filenames, sizes, dates, times, and attributes, respectively. `ADIR()` takes up to three arguments:

- \<expC1> indicates the array name.

- \<expC2> is optional and can be used to specify a template filename, such as *C:\FOX** or **.DBF*. Only filenames matching the template will be placed in the array.

- \<expC3> can contain the letters D, H, S, or V to limit the results to directory names, hidden files, system files, or the volume name, respectively.

The `ASCAN()` function can then be used to determine if a matching directory entry was placed in the array. For example:

```console
?ADIR(dirarray,'FOXPRO2','D')
```

The above command creates the array named `dirarray` and creates one row for the directory `FOXPRO2`.

```console
?ASCAN(dirarray,'FOXPRO2')
```

The above command returns .T. or .F. if `FOXPRO2` is contained in the array.

## References

For more information on `FILE()`, `ADIR()`, and `ASCAN()`, see the FoxPro version 2.0 "Commands & Functions" manual or the FoxPro version 2.5 "Language Reference" manual.
