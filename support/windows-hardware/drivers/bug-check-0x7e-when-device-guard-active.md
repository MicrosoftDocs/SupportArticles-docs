---
title: Bug check 0x7E occurs when Device Guard is active
description: This article describes a problem that causes some Windows 10 drivers may to crash with bug check 0x7E if Device Guard is active. This problem affects the way in which different builds of Windows 10 handle allocations that straddle two pages.
ms.date: 09/04/2020
ms.subservice: general
---
# Bug check 0x7E occurs in Windows 10 when Device Guard is active

This article introduces a problem that causes some Windows 10 drivers may to crash with bug check 0x7E if Device Guard is active.

_Original product version:_ &nbsp; Windows 10  
_Original KB number:_ &nbsp; 3194715

## Summary

Assume that you're developing kernel mode device drivers, and you try to load a driver (other than a boot driver) that was built with the **/IntegrityCheck** linker option and signed with page hashes. In this situation, **bug check 0x7E** may be returned in Windows 10 Build 10586 (TH2) when Device Guard is active.

The issue is caused by an OS deficiency that prevents HVCI from promoting a page to EXECUTE privilege, when the image has been previously validated by CI. This behavior may occur when the image is linked with **/IntegrityCheck**, is signed with **/PH** (page hashes), and is mapped into a user mode process before being loaded as a kernel driver.

As of RS1, HVCI checks for this condition and therefore avoids the bug check. However, the driver is still blocked unless it's a boot driver. This behavior occurs when HVCI/Device Guard is active on devices that support Secure Boot (for example, Surface Pro 3 and other modern devices).

When this issue occurs, it may trigger bug check 0x7E with at least an exception error 0xC0000005 occurring in `GsDriverEntry()`.

## More information

Two commands may affect this behavior:

- **/IntegrityCheck** (compiler switch) [/INTEGRITYCHECK (Require Signature Check)](/cpp/build/reference/integritycheck-require-signature-check)

- **/PH** (page hashes for executables) [SignTool.exe (Sign Tool)](/dotnet/framework/tools/signtool-exe)

When both of these commands are enabled, Windows 10 may behave unexpectedly as follows, depending on the build:

- Build 10240: No issue seen.
- Build 10586: Bug check 0x7E. This may occur if there is relocation in the driver that does not straddle two pages. In this case, the scenario that's described in the 'Summary' section occurs.
- Build 14393 (Redstone 1): An entry made in System events but the driver is blocked on load (except at boot time, when the driver will load without a problem).

To resolve this issue in Build 10586, we recommend that you disable page hashes by using the **/NPH** switch with Signtool. Because page hash checking is a performance option, disabling this option has the least effect on security.

This method can also be used in Build 14393 and later to allow the driver to load if the issue is present unless the driver has a relocation that straddles two pages (in which case it still will not load). You can determine this by including the **/MAP** command in the linker and then examining the output. For more information, see [/MAP (Generate Mapfile)](/cpp/build/reference/map-generate-mapfile).

To avoid a relocation that straddles two pages, do not use #pragma pack(1) anywhere in the driver. Default page alignment will not cause a page straddling issue.
