---
title: Fscanf function doesn't read consecutive lines
description: This article describes a problem that occurs when you read lines of text by using the Fscanf function.
ms.date: 10/27/2020
ms.custom: sap:C and C++ Libraries\C and C++ runtime libraries and Standard Template Library (STL)
---
# The Fscanf function does not read consecutive lines as expected

This article describes a problem that occurs when you read lines of text by using the `Fscanf` function.

_Original product version:_ &nbsp; Visual C  
_Original KB number:_ &nbsp; 60336

## Summary

When a file is open in text mode, an attempt to read lines of text by using the `Fscanf` function may fail and only one line of text is read from the file. The delimiter is set to `[^\n]`. The `Fscanf` function reads up to but does not include the delimiting character. Therefore, the file stream stops at the first `\n` in the file. Subsequent `Fscanf` function calls fail because the file pointer remains at the delimiting character and the `Fscanf` function cannot advance the function pointer past it. To move the file pointer past the delimiting character, use one of the following two methods:

- Update the code to use the following `Fscanf` function call:

    ```c
    fscanf(stream, "%[^\n]%*c", line)
    ```

    The `%*c` format specifier reads one character from the input stream but does not assign it to any of the parameters in the `fscanf` function call.

- Call the `Fgetc` function after the `Fscanf` function call to move the file pointer beyond the `\n` character.

The following code sample demonstrates this problem. The code sample should read and print lines from a text file until it reaches EOF. However, the code sample reads only the first line from the file. Since the end of file character has not been found, the code sample runs in an infinite loop if the file stream contains a `\n` character.

## Code sample

```c
FILE *stream;
char line[80];

while ((fscanf(stream, "%[^\n]", line))!= EOF )
{
    printf("Line = %s \n",line);
}
```

The following code example demonstrates the second method above to work around this problem:

```c
FILE *stream;
char line[80];

while ((fscanf(stream, "%[^\n]", line))!= EOF)
{
    fgetc(stream); // Reads in '\n' character and moves file
    // stream past delimiting character
    printf("Line = %s \n", line);
}
```
