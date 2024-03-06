---
title: IME may crash when processing a window message sent from another thread
description: Describes the scenario where an Input Method Editor (IME) may crash when processing a window message sent from another thread, where the window procedure handling the message calls an Imm* function, such as ImmSetOpenStatus.
ms.date: 12/19/2023
ms.reviewer: koichm, davean
ms.custom: sap:winuser-32-api-windows-messages
ms.subservice: desktop-app-ui-dev
---

# IME crashes when processing a window message sent from another thread

Describes a scenario where an Input Method Editor (IME) crashes while processing a window message sent from another thread, and where the window procedure handling the message calls an `Imm*` function such as `ImmSetOpenStatus`.

## Symptoms

An application using an IME crashes under one of these conditions:

- A user interface (UI) thread calls the `TranslateMessage` function as a part of the message loop.
- Another thread sends a window message to a window owned by the UI thread.
- The window procedure handling the window message sent by the other thread calls an `Imm*` function, such as `ImmSetOpenStatus`.

## Cause

An IME included with Windows 10 may call the `PeekMessage` function when the IME is called by the `TranslateMessage` function to process a keyboard input. `PeekMessage` will process any pending window messages sent by other threads. This can result in a reentrancy issue when the window procedure processing the sent message calls an `Imm*` function and leaves the IME in an unexpected state.

## Workaround

Avoid calling `Imm*` functions while the IME is processing another window message.

## More information

The [`PeekMessage`](/windows/win32/api/winuser/nf-winuser-peekmessagea) documentation contains the following:

During this call, the system delivers pending and non-queued messages sent to windows owned by the calling thread using the [`SendMessage`](/windows/desktop/api/winuser/nf-winuser-sendmessage), [`SendMessageCallback`](/windows/desktop/api/winuser/nf-winuser-sendmessagecallbacka), [`SendMessageTimeout`](/windows/desktop/api/winuser/nf-winuser-sendmessagetimeouta), or [`SendNotifyMessage`](/windows/desktop/api/winuser/nf-winuser-sendnotifymessagea) function. The first queued message matching the specified filter is retrieved. The system may also process internal events. If no filter is specified, messages are processed in this order:

- Sent messages
- Posted messages
- Input (hardware) messages and system internal events
- Sent messages (again)
- [`WM_PAINT`](/windows/desktop/gdi/wm-paint) messages
- [`WM_TIMER`](/windows/desktop/winmsg/wm-timer) messages

> [!NOTE]
> Sent window messages are non-queued messages. The message filter specified when calling PeekMessage call doesn't apply to sent messages.
