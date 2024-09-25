---
title: Video resolution limit for H.264 and stabilization
description: H.264 support in Windows 8 and Windows RT is limited to 2048x2048 pixels, and 16k for the DirectX2D based Video Stabilization.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Windows Desktop and Shell Experience\DPI and Display Issues, csstroubleshoot
---
# Video resolution limits for H.264 and Video Stabilization in Windows 8 and Windows RT

This article describes video resolution limits for H.264 and video stabilization.

_Applies to:_ &nbsp; Windows 8  
_Original KB number:_ &nbsp; 2829223

## Summary

H.264 support in Windows 8 and Windows RT is limited to 2048x2048 pixels for Encoding and Decoding. Sample Frames used by the Video Stabilization DSP are limited to 16k pixels by DirectX 2D.

## More information

### Encoder/Decoder

The H.264 standard only recognizes resolutions up to 2048x2048. The Microsoft H.264 (MP4) decoder/encoder is designed to only support video content up to the H.264 standard. The Microsoft H.264 (MP4) encoder/decoder supports any custom or standard resolution up to the 2048x2048 limit. The Microsoft H.264 (MP4) encoder/decoder supports any custom or standard aspect ratio.

Commonly supported resolutions and aspect ratios include:  

- 854 x 480 (16:9 480p)
- 1280 x 720 (16:9 720p)
- 1920 x 1080 (16:9 1080p)
- 640 x 480 (4:3 480p)
- 1280 x 1024 (5:4)
- 1920 x 1440 (4:3)

### Video Stabilization DSP

The Video Stabilization Digital Signal Processor (DSP) used by Windows 8 and Windows RT is based on a DirectX 2D implementation. DirectX 2D defines a 16k limit for the width of a buffer. The Video Stabilization DSP makes a DirectX 2D buffer that represents multiple frames; the contents of each row is a sample frame, and each row is the history of sample frames. Each row (sample frame) contains the pixels of 1/16th of a source frame (Width/16 x Height/16). Due to DirectX 2D's 16k limit per row, the effective maximum standard resolution supported for 16:9 and 4:3 are:  

- 16:9 - 2560 x 1440 (Source Frame) = 160 x 90 (Sample Frame) = 14,400 pixels per row
- 4:3 - 2304 × 1728 (Source Frame) = 144 x 108 (Sample Frame) = 15,552 pixels per rowNote these Source Frame resolutions are both greater than the H.264 2048x2048 limit. Video Stabilization at these higher resolutions can be successfully utilized when not associated with H.264 encoding.

### Camera application

In video mode, the Microsoft Store Camera application will report the error "Something went wrong while recording this video" when the camera's resolution is above the H.624 or Video Stabilization limits - at the time of capture, not at preview. To resolve this error, use a lower resolution or change the aspect ratio.

If the Camera application error is observed, contact the vendor of the camera - unsupported video resolutions should not be listed by the camera's driver. The camera driver can list resolutions higher than the video limit for image capture.
