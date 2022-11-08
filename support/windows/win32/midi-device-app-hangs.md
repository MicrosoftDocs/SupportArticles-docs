---
title: MIDI device app hangs when using MIDI API
description: This article describes that you can't use the legacy MIDI API in the MIDI device application, the application may freeze in Windows 10.
ms.date: 03/10/2020
ms.custom: sap:Graphics and multimedia development
ms.reviewer: daleche, davean, jadailey
ms.technology: windows-dev-apps-graphics-multimedia-dev
---
# MIDI device application hangs when you use former MIDI API in Windows 10

This article helps you resolve the problem where MIDI device application hangs in Windows 10 when you use the legacy MIDI API.

_Original product version:_ &nbsp; Windows 10  
_Original KB number:_ &nbsp; 4460006

## Symptoms

Consider the following scenario:

- You develop an application for Windows 10 that controls external MIDI devices.
- The application uses the former Microsoft Windows MIDI API to communicate with external devices.

In this situation, the application may hang. Additionally, you can't terminate the application by using Task Manager or any other method to exit the process. The only way to recover from this scenario is to restart the computer.

See the following example of a call stack from when the application hang occurs:

```console
ntdll!NtWaitForSingleObject+0x14
KERNELBASE!WaitForSingleObjectEx+0x9f
wdmaud!CMIDIOutDevice::WriteEvent+0xa8
wdmaud!CMIDIOutDevice::PlaySysEx+0x6d
wdmaud!HwModMessage+0x11a
wdmaud!CDigitalAudio::Init+0x37ac
winmmbase!midiMessage+0xa6
winmmbase!midiOutLongMsg+0xbc
MidiAppDriver!CMidiController::WriteTextToLCD+0x1f1
MidiAppDriver!CMidiController::KeepAlive+0x12a
MidiAppDriver!TimerThread+0x46
kernel32!BaseThreadInitThunk+0x14
ntdll!RtlUserThreadStart+0x21
```

## Cause

This issue may occur after a Plug and Play (PnP) removal event, because the former Microsoft Windows MIDI API implementation does not correctly handle that removal in Windows 10.

## Resolution

To fix this issue, use the new Windows Runtime (WinRT) API functions to replace the former API.

> [!NOTE]
> Important notes about WinRT API functions:
>
> - The API functions are primarily available to be called from a modern/UWP app.
> - Such modern APPs can be developed by using C++ language.
> - There's an option to develop classic user-mode desktop application that consumes WinRT APIs by using the `DualApiPartitionAttribute` attribute. For example, the [MidiInPort Class](/uwp/api/Windows.Devices.Midi.MidiInPort#Windows_Devices_Midi_MidiInPort_GetDeviceSelector) lists it.

## Status

Microsoft has confirmed that this is a problem in Windows 10.

## References

- [Calling Windows 10 APIs From a desktop application](https://blogs.windows.com/buildingapps/2017/01/25/calling-windows-10-apis-desktop-application/#7EtM8fwQgUA9Q1fd.97)

- [MIDI enhancements in Windows 10](https://blogs.windows.com/buildingapps/2016/09/21/midi-enhancements-in-windows-10/)

- [Windows.​Devices.​Midi Namespace](/uwp/api/windows.devices.midi)

- [How to enumerate MIDI devices and send and receive MIDI messages from a UWP app](/windows/uwp/audio-video-camera/midi)

- [A MIDI sample shows how to use the Windows.Devices.Midi API in a Windows Runtime app](https://github.com/Microsoft/Windows-universal-samples/tree/master/Samples/MIDI)

- [Building great music creation apps for Windows Store](https://channel9.msdn.com/Events/Build/2014/3-548)
