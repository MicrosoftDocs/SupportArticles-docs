---
title: Windows 10 20H1/20H2/21H1/21H2 is not responding with input control.
description: This article discusses a problem when Windows 10 stops responding with input control because Windows can't receive the messages required to process the Text Services Framework (TSF).  
ms.date: 12/20/2021
ms.prod-support-area-path: Windows 10
ms.reviewer: hihayak
ms.technology: windows-dev-apps-networking-dev
---

# Windows 10 20H1/20H2/21H1/21H2 is not responding with input control

This article helps you resolve the problem when Windows 10 stops responding with input control because Windows can't receive the messages required to process the Text Services Framework (TSF).

_Applies to:_ &nbsp; Windows 10, version 2004, Windows 10, version 20H2, Windows 10, version 21H1, Windows 10, version 21H2

_Original KB number:_ &nbsp; 

## Symptoms

Windows 10 20H1/20H2/21H1/21H2 is not responding with input control.

## Cause

Windows 10 20H1/20H2/21H1/21H2 adds Windows messages used by the text input systems or Text Services Framework (TSF).
If the PeekMessage API or GetMessage API has removed the Windows messages that the TSF uses and Windows can't receive the messages required to process the TSF, input control and Windows may stop responding.

This problem may occur if you run commands similar to the following example, which dispatch `WM_LBUTTONUP` messages only and remove other messages.

```powershell
----

while(::PeekMessage(&msg,NULL,0,0,PM_REMOVE))
{
::TranslateMessage(&msg);

// Dispatch only specific messages.
if (msg.message == WM_LBUTTONUP) {
::DispatchMessage(&msg);
}
}
-----
```

## Workaround 1

Run the following command to process the required messages only and to dispatch other messages through the DispatchMessage API:

```powershell
-----
while(::PeekMessage(&msg,NULL,0,0,PM_REMOVE))
{
::TranslateMessage(&msg);

if (msg.message == WM_ WM_LBUTTONDOWN) {

}
else {
// Dispatches all non-filtered messages
::DispatchMessage(&msg);
}
}
-----
```

## Workaround 2

Turn on the **Compatibility** option to enable the previous version of Microsoft IME by performing the following steps:

1. In the search box on the taskbar, type *language settings*, and then select **Language settings** from the results.

:::image type="content" source="media/win10-and-input-control-are-not-responding/win10-input-not-responding-language-settings.png" alt-text="Search language settings in the search box." border="true":::

1. Select the language of your Microsoft IME, and then click **Options**.

:::image type="content" source="media/win10-and-input-control-are-not-responding/win10-input-not-responding-language-options.png" alt-text="Select language options." border="true":::

1. Select the IME you're using, and then click **Options**.

:::image type="content" source="media/win10-and-input-control-are-not-responding/win10-input-not-responding-ime-options.png" alt-text="Select IME options." border="true":::

1. Select **General**.

:::image type="content" source="media/win10-and-input-control-are-not-responding/win10-input-not-responding-ime-general.png" alt-text="Select General." border="true":::

1. Turn on the **Use previous version of \<YourIME\>** toggle, and then click **OK** to confirm.

:::image type="content" source="media/win10-and-input-control-are-not-responding/win10-input-not-responding-turn-on-compatibility.png" alt-text="Turn on the compatibility mode and confirm the IME version change." border="true":::

> [!NOTE]
>  We recommend that you use the compatibility setting as a temporary workaround.