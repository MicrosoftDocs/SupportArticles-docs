---
title: WPF render thread failures
description: This document discusses failures in WPF's render thread, with particular attention to those that cause an exception in SyncFlush or NotifyPartitionIsZombie or that cause applications to hang in WaitForNextMessage or SynchronizeChannel.
ms.date: 07/07/2025
ms.reviewer: tatkins, sambent, davean
ms.topic: troubleshooting-general
ms.custom: sap:Common Language Runtime (CLR)

#customer intent: As a developer, I want to learn about the causes of failures in WPF's render thread so that I can troubleshoot hangs and errors in my application.
---
# Troubleshoot WPF render thread failures

This document discusses failures in WPF's render thread, with particular attention to those that cause an exception in `SyncFlush` or `NotifyPartitionIsZombie` or that cause applications to hang in `WaitForNextMessage` or `SynchronizeChannel`.

Each WPF application may have one or more UI threads running their own message pump (`Dispatcher.Run`). Each UI thread is responsible for processing window messages from the thread's message queue and dispatching them to windows owned by that thread. Each WPF application has just one render thread. It's a separate thread that communicates with DirectX/D3D (and/or GDI if the software rendering pipeline is being used). For WPF content, each UI thread sends detailed instructions to the render thread on what to draw. The render thread then takes those instructions and renders the content.

_Original product version:_ .NET Framework 4.8

## Failures in SyncFlush, WaitForNextMessage, SynchronizeChannel, and NotifyPartitionIsZombie

Developers often face problems related to render thread failures with Windows Presentation Foundation (WPF) applications. Users may report their application throws exceptions such as:

- System.Runtime.InteropServices.COMException: UCEERR_RENDERTHREADFAILURE (Exception from HRESULT: 0x88980406)  
- System.InvalidOperationException: An unspecified error occurred on the render thread.  
- System.OutOfMemoryException: Insufficient memory to continue the execution of the program.  

The exception's call stack starts at `SyncFlush` or `NotifyPartitionIsZombie`. For example:

```console
   at System.Windows.Media.Composition.DUCE.Channel.SyncFlush()  
   at System.Windows.Interop.HwndTarget.UpdateWindowSettings(Boolean enableRenderTarget, Nullable\`1 channelSet)  
   at System.Windows.Interop.HwndTarget.UpdateWindowSettings(Boolean enableRenderTarget)  
   at System.Windows.Interop.HwndTarget.UpdateWindowPos(IntPtr lParam)  
   at System.Windows.Interop.HwndTarget.HandleMessage(WindowMessage msg, IntPtr wparam, IntPtr lparam)  
```

```console
   at System.Windows.Media.MediaContext.NotifyPartitionIsZombie(Int32 failureCode)  
   at System.Windows.Media.MediaContext.NotifyChannelMessage()  
   at System.Windows.Interop.HwndTarget.HandleMessage(Int32 msg, IntPtr wparam, IntPtr lparam)  
```

The application may also hang in `WaitForNextMessage` or `SynchronizeChannel`, with a call stack such as:

```console
   ntdll.dll!NtWaitForMultipleObjects
   kernelbase.dll!WaitForMultipleObjectsEx
   kernelbase.dll!WaitForMultipleObjects
   wpfgfx_v0400.dll!CMilChannel::WaitForNextMessage
   wpfgfx_v0400.dll!MilComposition_WaitForNextMessage
   presentationcore.dll!System.Windows.Media.MediaContext.CompleteRender
```

```console
   kernelbase.dll!WaitForSingleObject
   wpfgfx_v0400.dll!CMilConnection::SynchronizeChannel
   wpfgfx_v0400.dll!CMilChannel::SyncFlush
   presentationcore.dll!System.Windows.Media.Composition.DUCE+Channel.SyncFlush
   presentationcore.dll!System.Windows.Media.MediaContext.CompleteRender
   presentationcore.dll!System.Windows.Interop.HwndTarget.OnResize
   presentationcore.dll!System.Windows.Interop.HwndTarget.HandleMessage
```

These are symptoms of a failure in the render thread. This is a challenging problem to diagnose because the exceptions and call stacks received are generic. Render thread failures will generate one of the calls stacks shown above (or a minor variation thereof) regardless of the root cause. This makes diagnosing the problem, or even recognizing when two crashes or hangs stem from the same root cause, especially difficult.

### Causes of the failures in SyncFlush, WaitForNextMessage, SynchronizeChannel, and NotifyPartitionIsZombie

The exceptions and hangs previously mentioned occur in a UI thread as a consequence of the WPF render thread encountering a fatal error. There are several possible causes for these errors, but the render thread doesn't share that information with the UI thread. Since these exceptions and hangs don’t stem from a single root bug or issue, there's no specific way to fix them.

WPF's render thread checks the return value for success or failure when it makes a call into another component such as DirectX/D3D, User32, or GDI32. When a failure is detected, WPF "zombies" the render partition and notifies the UI thread of the failure when the two threads get synchronized. The render thread will attempt to map the failure it receives to an appropriate managed exception. For example, if the WPF render thread failed due to an out of memory condition, then it will map the failure to a `System.OutOfMemoryException` and that will be the exception displayed on the UI thread. The render thread only synchronizes with the UI thread in a few locations, so the call stacks above typically appear where you notice the problem, not where it actually occurred. They most commonly synchronize in locations where a window's settings are updated (size, position, etc.) or where the UI thread handles a "channel" message from the render thread.

By design, the exceptions and call stacks on the UI thread aren't helpful to diagnose the problem. This is because by the time the exception is thrown, the render thread has already passed the point of failure. The render thread’s critical state would help us understand where and why the failure occurred, but it’s already lost. This makes it practically impossible for someone writing a WPF application to know why the failure occurred or how to avoid it. For Microsoft, it's only slightly better to debug this in a postmortem user dump file. The render thread keeps a circular buffer of the failing call stack, which we can reconstruct internally by means of a proprietary debugger extension and private debug symbols to show the approximate initial point of failure. However, we don't have access to the critical state such as locals, stack variables, and heap objects at the time of failure. We generally run the application again to look for failures on the calls we suspect are involved.

## Failures with video hardware or drivers

The most common bucket of WPF render thread failures is associated with video hardware or driver problems. When WPF queries the video driver for capabilities via DirectX, the driver might misreport its capabilities, causing WPF to take a code path that ends up causing some DirectX/D3D failures. Sometimes, the driver doesn't misreport its capabilities but it wasn't implemented correctly. The majority of render thread failures are caused by WPF attempting to utilize the hardware rendering pipeline in a way that exposes some flaw in the driver. This may happen on modern versions of Windows with modern graphics devices and drivers, although it's not as common as it was in the early days of WPF. This is why one of our first suggestions to test and/or work around a render thread failure is to disable hardware acceleration in WPF.

It is also possible that a failure is caused by an app asking to render a scene that’s too complex for the driver (or DirectX) to handle. This isn’t common with modern drivers, but every device has limits, and it's not impossible to exceed them.

Another historical source of render thread failures is the use of the [Window.AllowsTransparency](/dotnet/api/system.windows.window.allowstransparency) or [Popup.AllowsTransparency](/dotnet/api/system.windows.controls.primitives.popup.allowstransparency) properties in WPF, which will cause [layered windows](/windows/win32/winmsg/window-features#layered-windows) to be used.  Older versions of Windows had problems with layered windows, but most of them have been addressed with the introduction of the Desktop Window Manager (DWM) in Windows Vista.

If a render thread failure manifests as a `System.OutOfMemoryException`, the render thread was probably a victim of the process exhausting of some resource. The render thread called into a `Win32/DX` API that attempted to allocate some resource, but failed. WPF maps return values like `E_OUTOFMEMORY` or `ERROR_NOT_ENOUGH_MEMORY` to a `System.OutOfMemoryException`. Although the exception refers to "memory", the failure could refer to any kind of resource, such as GDI object handles, other system handles, GPU memory, normal RAM memory, etc.

### Remarks on resource allocation failures

Two remarks apply to `System.OutOfMemoryException` failures, and to any resource-allocation failure.

- The root cause may not lie in the code that encounters the failure. Instead, there may be other code in the process that over-consumes the resource, leaving none left for a normally successful request.

- If the request is unusually large, the failure could occur despite a resource that appears plentiful. A `System.OutOfMemoryException` could occur even when the system has plenty of memory, if there's a request for a large amount of (contiguous) memory. Here’s a real-world example: A Visual Studio plugin was preparing to restore its window from a state saved in a previous session. It adjusted incorrectly for the difference in DPI between the previous and current monitors, which compounded with adjustments from several layers of WPF, WindowsForms, and VS window-hosting components to set its window's size 16 times larger than it should have been. The render thread tried to allocate a back-buffer 256 times larger than needed, and failed even though there was more than enough memory available for the expected allocation.

## General recommendations

1. Disable Hardware rendering, using the **DisableHWAcceleration** registry value discussed in [Disable Hardware Acceleration Option](/dotnet/desktop/wpf/graphics-multimedia/graphics-rendering-registry-settings#disable-hardware-acceleration-option). This will affect all WPF applications on your machine;  do this only as a way to test if your problem is related to graphics hardware or drivers. If that's the case, you can work around the problem by programmatically disabling hardware acceleration at a more granular level. This can be done on a **per-window** basis by using the [HwndTarget.RenderMode](/dotnet/api/system.windows.interop.hwndtarget.rendermode) property, or on a **per-process** basis by using the [RenderOptions.ProcessRenderMode](/dotnet/api/system.windows.media.renderoptions.processrendermode) property.

2. Update your video drivers, and/or try different video hardware in the problem machine(s).

3. Upgrade to the latest version and service pack level of the .NET available for your target platform.

4. Upgrade to the latest operating system.

5. Disable the use of `Windows.AllowsTransparency` and `Popup.AllowsTransparency` in your application.

6. If `System.OutOfMemoryExceptions` are being reported, monitor the process's memory usage in Performance Monitor; particularly the Process\\Virtual Bytes, Process\\Private Bytes, and .NET CLR Memory\\\# Bytes in All Heaps counters. Monitor the User Objects and GDI Objects for the process in Windows Task Manager as well. If you determine that a specific resource is being exhausted, then troubleshoot the application to fix the excessive resource consumption. Bear in mind the two remarks above about resource-allocation issues.

7. If you have a reproducible scenario that occurs across platforms or on different video hardware/driver combinations, you might have a WPF bug. Be sure to collect enough information to allow investigation prior to reporting the issue to Microsoft. A call stack is not enough. Microsoft needs more detailed information, such as:

    - A full VS solution with steps to reproduce the issue, including description of the environment - OS, .NET, and graphics.
    - A [Time-Travel Debugging trace](/windows-hardware/drivers/debugger/time-travel-debugging-record) of the issue.
    - A full crash dump.
