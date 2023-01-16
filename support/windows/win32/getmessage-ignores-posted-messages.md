---
title: GetMessage ignores posted messages
description: This article discusses a problem where GetMessage doesn't receive messages posted while a WinEvent callback function is being executed. Provides resolutions.
ms.date: 03/10/2020
ms.custom: sap:Desktop app UI development
ms.reviewer: davean
ms.technology: windows-dev-apps-desktop-app-ui-dev
---
# GetMessage ignores posted messages received during the execution of a WinEvent callback

This article helps you resolve the problem where the `GetMessage` API doesn't receive messages that are posted while a `WinEvent` callback function is being executed.

_Original product version:_ &nbsp; Windows Server 2008, Windows 7, Windows Server 2003 R2, Windows Vista  
_Original KB number:_ &nbsp; 2682659

## Symptoms

`GetMessage` appears not to receive messages that are posted while a `WinEvent` callback function is being executed. If another message enters the queue, both messages will be received and processed.

## Cause

There's a known issue with `GetMessage` and the use of `WinEvent` callbacks that themselves use Windows messages. `GetMessage` ignores a message that is received during the execution of the callback. Therefore, in particular, if the callback function calls `PostThreadMessage`, that message won't register until another message enters the queue (for example, because of a mouse movement); at that point, both the earlier posted message and the new message will register and be processed.

## Resolution

To work around this block, we recommend using `MsgWaitForMultipleObjects` and `PeekMessage` instead of `GetMessage`. It's also necessary to create a new event that can be sent from the WinEvent handler to wake up the message loop.

## More information

Here is a code fragment that includes a generic message loop and a `WinEvent` handler:

```cpp
// Main message loop of thread that called SetWinEventHook while(GetMessage(&msg, NULL, 0, 0))
{
    ... process message here ...
}

void CALLBACK WinEventProc(HWINEVENTHOOK hWinEventHook, DWORD eventId,
HWND hwnd, LONG idObject, LONG idChild, DWORD dwEventThread,
DWORD dwmsEventTime)
{
    ... process winevent here ...
}
```

`GetMessage` can block in the above fragment after failing to register a message sent from `WinEventProc`. Instead, use `MsgWaitForMultipleObjects` and `PeekMessage` together with declaring and using a special wake-up event from the handler back to the message loop, as shown in this fragment:

```cpp
HANDLE ghMessageReadyEvent = NULL; // Event used to wake up the main thread

ghMessageReadyEvent = CreateEvent(NULL, FALSE/*bManualReset*/,
FALSE/*bIntialState*/, NULL);

// Main message loop of thread that called SetWinEventHook
// We can't reliably use GetMessage here. If a posted message is received
// while we're in a reentrant call to WinEventProc, when the WinEventProc
// returns, GetMessage does not recognize that a message has been
// received and just blocks. To avoid this we use
// MsgWaitForMultipleObjects + PeekMessage. Code at the end of the
// WinEventProc checks if a posted message was received during the
// callback using PeekMessage; if so, it sets the event which causes
// MsgWaitForMultipleObjects to wake up.
// Note that MsgWaitForMultipleObjects usually only wakes up if a message
// is received during it. Even with QS_ALLPOSTMESSAGE, it only wakes up
// if a message is received between it and the most recent PeekMessage,
// so we have to call PeekMessage *before* calling it in case there are
// multiple queued-up messages.

for(;;)
{
    BOOL fGot = PeekMessage(&msg, NULL, 0, 0, PM_REMOVE);

    if(!fGot)
    {
        MsgWaitForMultipleObjects(1, &ghMessageReadyEvent,
        FALSE/*bWaitAll*/, INFINITE,
        QS_ALLEVENTS | QS_ALLPOSTMESSAGE);

        fGot = PeekMessage(&msg, NULL, 0, 0, PM_REMOVE);
    }

    if(!fGot)
    {
        continue;
    }
    ... process message here ...
}

void CALLBACK WinEventProc(HWINEVENTHOOK hWinEventHook, DWORD eventId, HWND hwnd, LONG idObject, LONG idChild, DWORD dwEventThread, DWORD dwmsEventTime)
{
    ... process winevent here ...
    // Before we return, check if posted messages were received during this
    // callback. If so, fire the event to ensure that we do process them.
    MSG msg;

    if(PeekMessage(&msg, (HWND)-1, WM_USER + 1, WM_USER + 2, PM_NOREMOVE | PM_QS_POSTMESSAGE))
    {
        SetEvent(ghMessageReadyEvent);
    }
}
```
