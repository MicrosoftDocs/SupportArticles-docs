---
title: Obtain a Console Window Handle
description: Describes how to obtain a Console Window Handle (HWND).
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, kayda
ms.custom: sap:performance-monitoring-tools, csstroubleshoot
---
# How to obtain a Console Window Handle (HWND)

This article describes how to obtain a Console Window Handle (HWND).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 124103

## Summary

It may be useful to manipulate a window associated with a console application. The Win32 API provides no direct method for obtaining the window handle associated with a console application. However, you can obtain the window handle by calling `FindWindow()`. This function retrieves a window handle based on a class name or window name.

Call `GetConsoleTitle()` to determine the current console title. Then supply the current console title to `FindWindow()`.

## More information

Because multiple windows may have the same title, you should change the current console window title to a unique title. Which will help prevent the wrong window handle from being returned. Use `SetConsoleTitle()` to change the current console window title. Here is the process:

1. Call `GetConsoleTitle()` to save the current console window title.

2. Call `SetConsoleTitle()` to change the console title to a unique title.

3. Call Sleep(40) to ensure the window title was updated.

4. Call `FindWindow`(NULL, uniquetitle), to obtain the HWND this call returns the HWND--or NULL if the operation failed.

5. Call `SetConsoleTitle()` with the value retrieved from step 1, to restore the original window title.

You should test the resulting HWND. For example, you can test to see if the returned HWND corresponds with the current process by calling `GetWindowText()` on the HWND and comparing the result with `GetConsoleTitle()`.

The resulting HWND isn't guaranteed to be suitable for all window handle operations.

## Sample Code

The following function retrieves the current console application window handle (HWND). If the function succeeds, the return value is the handle of the console window. If the function fails, the return value is NULL. Some error checking is omitted, for brevity.

```c++
HWND GetConsoleHwnd(void)
   {
       #define MY_BUFSIZE 1024 // Buffer size for console window titles.
       HWND hwndFound;         // This is what is returned to the caller.
       char pszNewWindowTitle[MY_BUFSIZE]; // Contains fabricated
                                           // WindowTitle.
       char pszOldWindowTitle[MY_BUFSIZE]; // Contains original
                                           // WindowTitle.

       // Fetch current window title.

       GetConsoleTitle(pszOldWindowTitle, MY_BUFSIZE);

       // Format a "unique" NewWindowTitle.

       wsprintf(pszNewWindowTitle,"%d/%d",
                   GetTickCount(),
                   GetCurrentProcessId());

       // Change current window title.

       SetConsoleTitle(pszNewWindowTitle);

       // Ensure window title has been updated.

       Sleep(40);

       // Look for NewWindowTitle.

       hwndFound=FindWindow(NULL, pszNewWindowTitle);

       // Restore original window title.

       SetConsoleTitle(pszOldWindowTitle);

       return(hwndFound);
   }
```
