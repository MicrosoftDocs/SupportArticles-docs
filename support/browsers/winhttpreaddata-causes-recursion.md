---
title: Recursion if WinHttpReadData behaves synchronously
description: Describes a by design behavior that WinHttpReadData can behave synchronously even for asynchronous requests, which leads to a recursive behavior.
ms.date: 03/16/2020
ms.prod-support-area-path: Internet Explorer
ms.reviewer: pphadke, macox
---
# WinHttpReadData can behave synchronously even for asynchronous requests leading to recursion

This article discusses a by design behavior that recursion occurs if WinHttpReadData can complete synchronously for asynchronous requests.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 2427068

## Summary

You are developing an application using the WinHttp API and following the recommended procedure as explained in the **Asynchronous Completion in WinHTTP** section of the article [Asynchronous Completion in WinHTTP](https://docs.microsoft.com/previous-versions//aa383138(v=vs.85)).

When the WinHttp API is operating asynchronously, the functions WinHttpQueryDataAvailable and WinHttpReadData can complete either synchronously or asynchronously each time they are called.

If the function behaves synchronously and you use a debugger to observe the callstack, you will notice a recursive behavior, where each call to WinHttpReadData will recurse itself.

This behavior is by design.

## More Information

The recursion of the WinHttpReadData function is bounded, which means that although the WinHttpReadData is acting synchronously and it tends to recurse, it will only recurse for a specified maximum number of times after which it will continue the completions on another thread. This other thread can also have recursion up to the amount specified.

The number of times WinHttpReadData will recurse depends on the operating system you are running your WinHttp application on. The information is as follows:

|Operating System|Maximum number of recursions|
|---|---|
|Windows XP SP2 and above<br/>Windows 2003 and the service packs<br/>Windows Vista, 2008 and the service packs|64|
|Windows 7, Windows 2008 R2|2|
||

WinHttpReadData can behave synchronously if there is enough data buffered at the local socket, where no further wait is needed and the data is available immediately.

This recursive behavior is seen for a large file transfer over the localhost server or a high-speed network connection.

Using WinHttp API logging, you will see the below behavior that explains the recursion:

```console
HH:MM:SS:ZZZ ::*000000n*:: WinHttpQueryDataAvailable(0xdb0000, 0x0, 0x124fa7c)
HH:MM:SS:ZZZ ::*000000n*:: WinHttpReadData(0xdb0000, 0xc75e20, 455, 0x0)
HH:MM:SS:ZZZ ::*000000n*:: WinHttpQueryDataAvailable(0xdb0000, 0x0, 0x124eac8)
.........
.........
HH:MM:SS:ZZZ ::*000000n*:: WinHttpReadData(0xdb0000, 0xc76018, 8192, 0x0)
HH:MM:SS:ZZZ ::*000000n*:: WinHttpQueryDataAvailable(0xdb0000, 0x0, 0x124db14)
HH:MM:SS:ZZZ ::*000000n*:: WinHttpQueryDataAvailable() returning TRUE
HH:MM:SS:ZZZ ::*000000n*:: WinHttpReadData() returning TRUE
HH:MM:SS:ZZZ ::*000000n*:: WinHttpQueryDataAvailable() returning TRUE
HH:MM:SS:ZZZ ::*000000n*:: WinHttpReadData() returning TRUE
HH:MM:SS:ZZZ ::*000000n*:: WinHttpQueryDataAvailable() returning TRUE
```

If you control the stack size of each thread and set the maximum thread stack size to a low value, you will experience a stack overflow due to the 64 levels of recursive behavior on operating systems earlier than Windows 7 and Windows 2008 R2. Therefore care should be taken when designing applications and prevent allocating too little of the default thread stack size available for each application thread.

For more information on thread stack size and how to control it, see [Thread Stack Size](https://docs.microsoft.com/windows/win32/procthread/thread-stack-size).
