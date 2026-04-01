---
title: Fix Edge Video Playback Problems
description: Fix Microsoft Edge video playback problems such as audio-only output, missing codecs, and autoplay blocks. Use this step-by-step checklist to get videos working again.
ms.date: 03/31/2026
ms.reviewer: Johnny.Xu, dili, v-shaywood
ms.custom: 'sap:Web Platform and Development\Graphics and Media: including WebRTC'
---

# Troubleshoot video playback problems in Microsoft Edge

## Summary

This article helps you troubleshoot common video playback problems in Microsoft Edge. You might experience symptoms such as videos not playing, audio playing without video, videos not autoplaying, or error messages that are related to unsupported formats or decoders. The possible causes of this problem include:
- Disabled hardware acceleration
- Invalid or missing codec extensions
- Misconfigured autoplay policies
- Security controls that block encrypted media modules
- Restrictive WebRTC policies

This article provides a step-by-step troubleshooting checklist that covers these common causes.

## Symptoms

You experience one or more of the following problems:

- Videos on websites don't play in Microsoft Edge.
- A video plays audio but shows no image.
- Videos play in other browsers such as Chrome but fail in Microsoft Edge.
- When you play DRM-protected media, you receive a "Playback of protected content is not enabled" error message.
- In a WebRTC-based conferencing application, the remote party can't see your video stream, but you can see theirs.
- Media content doesn't autoplay on the new tab page or in kiosk mode as expected.

## Solution

Work through the following checks in the given order. After each section, test whether the problem is resolved before you proceed to the next method.

### Verify video codec and file format support

Microsoft Edge doesn't natively support all video codecs. If the media format isn't supported, Edge might play audio without video, or it might not play the whole file. For example, XAVC isn't supported by the built-in playback stack on Windows 10 and Windows 11.

Follow these steps:

1. Open `edge://media-internals` in a new tab, and then reproduce the problem.
1. Examine the player properties, and identify the codec from entries such as `kVideoTracks` and the decoder information.
1. Compare the file behavior across players. If the same media also fails in the built-in Windows player, the issue is more likely a format support issue than an Edge setting.

The following table lists common codecs and their support status in Edge.

| Codec          | Support in Edge                                      | Notes                                                                  |
| -------------- | ---------------------------------------------------- | ---------------------------------------------------------------------- |
| H.264 (AVC)    | Supported                                            | Common web video codec. Often shown as `codec: h264` or `codec: avc1`. |
| H.265 (HEVC)   | Conditionally supported                              | Requires a valid HEVC Video Extension and a working HEVC decoder path. |
| VP8 / VP9      | Supported                                            | Common on web streaming sites.                                         |
| AV1            | Supported                                            | Hardware decode support depends on the device and GPU.                 |
| XAVC / XAVC HS | Not supported by the built-in Windows playback stack | Can cause audio-only playback or full playback failure.              |

If the video uses an unsupported or narrowly supported format, convert it to a widely supported format. Convert the file to H.264 video that uses AAC audio in an MP4 container, and then test playback again in Edge.

> [!TIP]
> Open `edge://gpu` and review the **Video Acceleration Information** section to determine which codecs are hardware-accelerated on the current device.

### Check H.264 video decoding and hardware acceleration

H.264 (AVC) is the most widely used video codec on the web. Edge uses a layered decoder selection strategy for H.264 on Windows:

- **Media Foundation H264 Decoder (DXVA VDA)**: Edge's default path that uses Windows platform hardware acceleration
- **D3D11 Video Decode Accelerator**: An alternative hardware path that some configurations use
- **Chromium SW H264 Decoder (FFmpeg)**: Software fallback if hardware acceleration is disabled or unsupported

If you disable hardware acceleration or the GPU driver doesn't support the required H.264 decode profile, Edge falls back to the FFmpeg software decoder. If that fallback path also fails, H.264 videos don't play correctly.

Verify that the failing video uses H.264:

1. Open `edge://media-internals` while the video is playing.
1. Look for `codec: h264` or `codec: avc1` in the player properties.
1. Check the `kVideoDecoderName` value:
   - `D3D11VideoDecoder` or `MediaFoundationVideoDecoder` indicates hardware acceleration.
   - `FFmpegVideoDecoder` indicates software decoding.

Follow these steps to verify and enable hardware acceleration:

1. Open Microsoft Edge and go to `edge://settings/system`.
1. Make sure **Use graphics acceleration when available** is turned on. If you manage this setting through Group Policy, see [HardwareAccelerationModeEnabled](/deployedge/microsoft-edge-browser-policies/hardwareaccelerationmodeenabled).
1. Restart Microsoft Edge.
1. Open `edge://gpu`, and verify that **Video Decode** shows **Hardware accelerated**.
1. Check `edge://media-internals` again while you reproduce the issue. Determine which decoder path is being used.

The following example shows the output in `edge://gpu` if hardware acceleration is enabled:

```text
Video Decode: Hardware accelerated
Video Encode: Hardware accelerated
```

If hardware acceleration is enabled, but H.264 playback still fails, try the following actions:

- Update the GPU driver from the device manufacturer.
- Toggle the graphics acceleration setting off and on again, and then restart Edge.
- Recheck `edge://media-internals` to determine whether the decoder path changed.

### Check the HEVC Video Extension

For HEVC (H.265) media, Edge relies on the Windows platform `MediaFoundationVideoDecoder` path. If the installed HEVC Video Extension has an invalid license, Edge can't decode HEVC media even though Chrome plays the same content by using a different decoder path.

You can verify this problem by checking the following diagnostic information:

- `edge://gpu` shows `Failed to create HEVC decoder instance, License check for app failed (0xC00DB3B3)`.
- `edge://media-internals` shows that decoder initialization failed or that the HEVC configuration is unsupported.

Follow these steps:

1. Open PowerShell as an administrator, and check the installed HEVC package:

   ```powershell
   Get-AppxPackage -AllUsers *HEVC* | Select-Object Name, PackageFullName
   ```

1. If an HEVC package is installed, uninstall it, and then remove any provisioned copy:

   ```powershell
   Get-AppxPackage *HEVC* | ForEach-Object { Remove-AppxPackage -Package $_.PackageFullName }

   Get-AppxProvisionedPackage -Online |
     Where-Object DisplayName -like "*HEVC*" |
     ForEach-Object { Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName }
   ```

1. Restart the computer.
1. Install the official HEVC Video Extension from the Microsoft Store: [HEVC Video Extensions](https://apps.microsoft.com/detail/9n4wgh0z6vhq).

> [!NOTE]
> This issue might occur if the HEVC extension is installed from a third-party platform instead of the Microsoft Store. In this case, the license might be invalid.

### Check encrypted media (DRM) playback

If you see the "Playback of protected content is not enabled"  error message on sites such as Spotify, the user profile might block the Widevine Content Decryption Module from loading. This problem occurs when `widevinecdm.dll` is read from `%LOCALAPPDATA%` but isn't loaded into `msedge.exe`. `widevinecdm.dll` should be read and loaded from the Edge application folder, instead.

Follow these steps:

1. Open Microsoft Edge, and go to `edge://components`. Verify that **Widevine Content Decryption Module** is present.
1. If you use Process Monitor, check whether `widevinecdm.dll` is read from `%LOCALAPPDATA%` but not loaded into `msedge.exe`.
1. If your environment uses AppLocker or similar controls that block DLL loading from user-profile folders, disable [ComponentUpdatesEnabled](/deployedge/microsoft-edge-browser-policies/componentupdatesenabled) so that Edge falls back to the Widevine module under `C:\Program Files (x86)\Microsoft\Edge\Application\<Version>\WidevineCdm`.
1. Delete the user-profile Widevine folder by running the following PowerShell command:

   ```powershell
   Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Edge\User Data\WidevineCdm" -Recurse -Force
   ```

1. Restart Microsoft Edge, and test playback again on the affected protected-content site.

> [!NOTE]
> If AppLocker restricts DLL execution under user profiles, other Dynamics Edge components under `%LOCALAPPDATA%\Microsoft\Edge\User Data\` can also be affected.

### Check the WebRTC video streaming policy

If you experience one-directional video in a WebRTC-based conferencing application, the [WebRtcLocalhostIpHandling](/deployedge/microsoft-edge-browser-policies/webrtclocalhostiphandling) policy might block the local network interface that's required for peer-to-peer media flows.

Follow these steps:

1. Open Microsoft Edge, and go to `edge://policy`.
1. Search for `WebRtcLocalhostIpHandling`.
1. If the value is `default_public_interface_only`, change it to `default_public_and_private_interfaces`.
1. Restart Microsoft Edge, and test the same conferencing application again.

### Check autoplay policies

If videos don't autoplay as expected, this problem could have one of the following causes:

- The launch configuration blocks kiosk-mode autoplay.
- [AutoplayAllowList](/deployedge/microsoft-edge-browser-policies/autoplayallowlist) doesn't match the actual navigation type. Therefore, the new tab page autoplay feature is blocked.

#### Kiosk mode

If an audible alert fails in kiosk mode, and JavaScript reports `play() failed because the user didn't interact with the document first`, update the Edge launch command to include the autoplay flag.

Use a launch command that resembles the following example:

```text
"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --kiosk --autoplay-policy=no-user-gesture-required <URL> --edge-kiosk-type=fullscreen
```

#### New tab page autoplay

This problem occurs because the new tab page is a special navigation type, and the address bar URL doesn't match the site URL in the way that the allowlist expects.

If the site autoplays when you enter the full URL directly into the address bar, but doesn't autoplay when the same site is configured as the new tab page, check the effective [AutoplayAllowed](/deployedge/microsoft-edge-browser-policies/autoplayallowed) and [AutoplayAllowList](/deployedge/microsoft-edge-browser-policies/autoplayallowlist) policies.

1. Open Microsoft Edge and go to `edge://policy`.
1. Search for `AutoplayAllowList`.
1. If the problem occurs only on the new tab page, add `edge://newtab` to the allowlist.
1. Restart Microsoft Edge, and test the new tab page again.

## Data collection

If you have to contact Microsoft Support for more help, collect the following diagnostic information, and include it in your support request.

- **Microsoft Edge version**: Go to `edge://settings/help`, and note the full version number.
- **GPU report**: Go to `edge://gpu`, and save the full report.
- **Media playback logs**: Go to `edge://media-internals` while you reproduce the issue, and save the player properties.
- **Video format details**: Use a media-inspection tool to verify the codec and container of the video file.
- **Active policies**: Go to `edge://policy`, and export the policy list.
- **HEVC extension status**: If HEVC playback fails, run `Get-AppxPackage -AllUsers *HEVC*` in PowerShell, and save the output.
- **Widevine component status**: If DRM playback fails, go to `edge://components`, and note the Widevine module status. Include any Process Monitor evidence, if available.

## Related content

- [Configure Microsoft Edge kiosk mode](/deployedge/microsoft-edge-configure-kiosk-mode)
- [Microsoft Edge browser policy reference](/deployedge/microsoft-edge-policies)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
