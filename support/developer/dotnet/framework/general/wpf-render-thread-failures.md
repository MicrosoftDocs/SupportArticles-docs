---
title: WPF Render Thread Failures
description: This article discusses failures in WPF's render thread, particularly exceptions in SyncFlush or NotifyPartitionIsZombie, and faiures in WaitForNextMessage or SynchronizeChannel.
ms.date: 07/07/2025
ms.reviewer: tatkins, sambent, davean
ms.topic: troubleshooting-general
ms.custom: sap:Common Language Runtime (CLR)

#customer intent: As a developer, I want to learn about the causes of failures in WPF's render thread so that I can troubleshoot errors in my application.
---
# Troubleshoot WPF render thread failures

This article discusses failures in the Windows Presentation Foundation (WPF) render thread. This article focuses on exceptions that occur in `SyncFlush` or `NotifyPartitionIsZombie` and hang situations that occur in `WaitForNextMessage` or `SynchronizeChannel`.

WPF applications might have one or more UI threads that are running their own message pump (`Dispatcher.Run`). Each UI thread is responsible for processing window messages from the thread's message queue and dispatching them to windows that the thread owns. Each WPF application has only one render thread. That separate thread communicates with Microsoft DirectX D3D (or GDI, if the software rendering pipeline is used). For WPF content, each UI thread sends detailed instructions to the render thread on what to draw. The render thread then follows those instructions to render the content.

_Applies to:_ .NET Framework 4.8

## Failures in SyncFlush, WaitForNextMessage, SynchronizeChannel, and NotifyPartitionIsZombie

Developers often encounter problems that are related to render thread failures that occur in WPF applications. Users might report that their application throws an exception, such as:

- System.Runtime.InteropServices.COMException: UCEERR_RENDERTHREADFAILURE (Exception from HRESULT: 0x88980406)  
- System.InvalidOperationException: An unspecified error occurred on the render thread.  
- System.OutOfMemoryException: Insufficient memory to continue the execution of the program.  

The related call stack starts at `SyncFlush` or `NotifyPartitionIsZombie`. For example:

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

The application might stop responding in `WaitForNextMessage` or `SynchronizeChannel` and generate a call stack, such as:

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

These call stacks are symptoms of a failure in the render thread. This is a challenging problem to diagnose because the exceptions and call stacks are generic. Render thread failures generate one of the calls stacks that are listed here (or a minor variation of the call stacks) regardless of the root cause. Therefore, it can be difficult to diagnose the problem or recognize a situation in which separate incidents of non-response have the same root cause.

### Causes of the failures in SyncFlush, WaitForNextMessage, SynchronizeChannel, and NotifyPartitionIsZombie

Exceptions and situations in which the software stops responding occur in a UI thread if the WPF render thread experiences a fatal error. These errors have several possible causes, but the render thread doesn't share that information together with the UI thread. Because these errors are not related to a single root bug or issue, they have no specific solution.

WPF's render thread checks the return value for success or failure when it makes a call into another component, such as DirectX D3D, User32, or GDI32. When a failure is detected, WPF "zombies" the render partition and notifies the UI thread of the failure when the two threads are synchronized. The render thread tries to map the failure it receives to an appropriate managed exception. For example, if the WPF render thread failed because of an out-of-memory condition, it maps the failure to a `System.OutOfMemoryException`. That exception is displayed on the UI thread. The render thread synchronizes with the UI thread in only a few locations. Therefore, the call stacks that are mentioned in the previous section typically appear where you notice symptoms of the problem, not where the problem actually occurs. Synchronization  most commonly occurs in locations where a window's settings are updated (size, position, and so on) or where the UI thread handles a "channel" message from the render thread.

By design, the exceptions and call stacks on the UI thread aren't useful resources to help you diagnose the problem. By the time the exception is thrown, the render thread is already past the point of failure. The render thread’s critical state would help you understand where and why the failure occurred, but it’s already lost. Because of this situation, the author of a WPF application can't know why the failure occurred or how to avoid it. Instead of analyzing exceptions and call stacks, we debug the problem in a postmortem user dump file. Although this method is only slightly more useful, the render thread keeps a circular buffer of the failing call stack. We can reconstruct the buffer internally by using a proprietary debugger extension and private debug symbols to show the approximate initial point of failure. However, we don't have access to the critical state, such as locals, stack variables, and heap objects at the time of failure. We generally run the application again to look for failures on the calls that we suspect are involved.

## Failures with video hardware or drivers

The most common bucket of WPF render thread failures is associated with video hardware or driver problems. When WPF queries the video driver for capabilities through DirectX, the driver might misreport its capabilities. This action causes WPF to take a code path that causes some DirectX D3D failures. The driver might also be implemented incorrectly. Most render thread failures occur because WPF tries to use the hardware rendering pipeline in a manner that exposes some flaw in the driver. This condition might occur on modern versions of Windows that use modern graphics devices and drivers, although as commonly as it occurred in the early days of WPF. For this reason, when you start to test or work around a render thread failure, we recommend that you first disable hardware acceleration in WPF.

A failure might also occur if an app requests a scene that’s too complex for the driver (or DirectX) to render. This situation isn’t common for modern drivers. However, every device has limits that can be exceeded.

Another historical source of render thread failures are the [Window.AllowsTransparency](/dotnet/api/system.windows.window.allowstransparency) or [Popup.AllowsTransparency](/dotnet/api/system.windows.controls.primitives.popup.allowstransparency) properties in WPF. These properties cause [layered windows](/windows/win32/winmsg/window-features#layered-windows) to be used. Layered windows caused problems in older versions of Windows. However, most of these problems were resolved by the introduction of the Desktop Window Manager (DWM) in Windows Vista.

If a render thread failure manifests as a `System.OutOfMemoryException`, that error typically indicates that the process exhausted some resource. In this situation, the render thread called into a `Win32/DX` API that tried unsuccessfully to allocate some resource. WPF maps return values such as `E_OUTOFMEMORY` or `ERROR_NOT_ENOUGH_MEMORY` to a `System.OutOfMemoryException`. Although the exception entry refers to "memory," this mention could refer to any kind of resource, such as GDI object handles, other system handles, GPU memory, standard RAM memory, and so on.

### Remarks on resource allocation failures

The following remarks apply to `System.OutOfMemoryException` failures and any resource-allocation failure:

- The root cause might not be related to the code that experiences the failure. Other code in the process can over-consume the resource and leave none for code that would otherwise run successfully.

- If the request is unusually large, the failure could occur despite a resource that appears to be plentiful. A request for a large amount of (contiguous) memory could casue a `System.OutOfMemoryException` even if the system has plenty of memory. Here’s a real-world example: A Visual Studio add-in prepares to restore its window from a state that was saved in a previous session. The add-in adjusts incorrectly for the difference in DPI between the previous and current monitors. Because this error is compounded by adjustments from several layers of WPF, WindowsForms, and VS window-hosting components, the add-in sets its window size to 16 times larger than the correct size. Then, the render thread tries to allocate a back-buffer that's 256 times larger than necessary. Therefore, the process fails even though there's sufficient available memory for the expected allocation.

## General recommendations

1. Disable Hardware rendering. Use the **DisableHWAcceleration** registry value that's discussed in [Disable Hardware Acceleration Option](/dotnet/desktop/wpf/graphics-multimedia/graphics-rendering-registry-settings#disable-hardware-acceleration-option). This action affects all WPF applications on your computer. Take this step only to test whether your problem is related to graphics hardware or drivers. If it is, you can work around the problem by programmatically disabling hardware acceleration at a more granular level. This step can be done on a **per-window** basis by using the [HwndTarget.RenderMode](/dotnet/api/system.windows.interop.hwndtarget.rendermode) property, or on a **per-process** basis by using the [RenderOptions.ProcessRenderMode](/dotnet/api/system.windows.media.renderoptions.processrendermode) property.

2. Update your video drivers, or try different video hardware on the problem computers.

3. Upgrade to the latest version and service pack level of Microsoft .NET Framework that's available for your target platform.

4. Upgrade to the latest operating system.

5. Disable the ability to use `Windows.AllowsTransparency` and `Popup.AllowsTransparency` in your application.

6. If `System.OutOfMemoryExceptions` are reported, monitor the process memory usage in Performance Monitor. In particular, monitor the Process\\Virtual Bytes, Process\\Private Bytes, and .NET CLR Memory\\\# Bytes in All Heaps counters. Also monitor the User Objects and GDI Objects for the process in Windows Task Manager. If you determine that a specific resource is being exhausted, troubleshoot the application to fix the excessive resource consumption. As a guideline, follow the two remarks in the previous section about resource-allocation issues.

7. If you have a reproducible scenario that occurs across platforms or in different video hardware or driver combinations, you might have a WPF bug. Make sure that you collect enough information to enable an investigation before you report the issue to Microsoft. A call stack by itself is not sufficient. We need more detailed information, such as:

    - A full VS solution that includes steps to reproduce the issue, including a description of the environment (OS, .NET, and graphics).
    - A [Time-Travel Debugging trace](/windows-hardware/drivers/debugger/time-travel-debugging-record) of the issue.
    - A full crash dump file.
