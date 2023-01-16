---
title: DWM drops frame of Direct3D 10 application
description: This article describes that the DWM (Desktop Window Manager) can drop frames of Direct3D 10 applications, which are locked to the VSync without throttling back the application.
ms.date: 03/16/2020
ms.custom: sap:Graphics and multimedia development
ms.technology: windows-dev-apps-graphics-multimedia-dev
---
# The DWM can drop frames of Direct3D 10 applications that are locked to the VSync

This article provides a resolution about DWM (Desktop Window Manager) drops frames of Direct3D 10 applications.

_Original product version:_ &nbsp;  Windows  
_Original KB number:_ &nbsp; 2532720

## Symptoms

The Desktop Window Manager (DWM) can drop frames of Direct3D 10 applications that are locked to the VSync without throttling back the application. This operation can make it so the application doesn't know frames were dropped. For example, you set up your primary monitor to run at 60 Hz or greater. You set up your secondary monitor to run at 30 Hz. In your Direct3D 10 code, you specify that we should sync to the VSync when you call `Present()`. It means we should run at 30 frames per second when on the secondary monitor:

```cpp
pSwapChain->Present( 1, 0 );
```

The application runs at 60 Hz on the primary monitor. However, on the secondary 30-Hz monitor, the application also runs at 60 Hz. It's expected that on the secondary (30 Hz) monitor, the application runs at 30 Hz.

## Resolution

Microsoft is aware of this problem. If you use `D3D9Ex` and `Present()` with `D3D9Ex` and `D3DSWAPEFFECT_FLIPEX`/`D3DPRESENT_INTERVAL_ONE`, then you can work around the issue. You will get 30 frames per second.
