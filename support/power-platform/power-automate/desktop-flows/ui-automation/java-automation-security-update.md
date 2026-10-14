---
title: Security Update for Java Automation in Power Automate for Desktop
description: Provides security updates for the Java automation component in Microsoft Power Automate for desktop.
ms.reviewer: nimoutzo, iopanag
ms.date: 09/09/2026
ms.custom: sap:Desktop flows\UI or browser automation
ai-usage: ai-assisted
---

# Security update for the Java automation component in Power Automate for Desktop

## Summary

If you use Power Automate for desktop versions 2.54 through 2.68, a Java automation security vulnerability might affect your machine. Learn how to protect your machine by installing a patched version or disabling the Power Automate Java sync service.

Machines with affected versions of Power Automate for desktop installed could allow a local Windows user to execute code with elevated privileges. Microsoft has issued a [CVE-2026-77897](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2026-77897) for this issue.

> [!IMPORTANT]
> If you disable the Power Automate Java sync service, you're not affected.

## Solution

Choose one of the following two mitigations. Installing a patched version is the recommended option because it keeps Java automation fully functional.

### Install patched versions of Power Automate for desktop (recommended)

Install one of the following patched versions of Power Automate for desktop:

- [Latest](https://go.microsoft.com/fwlink/?linkid=2102613)
- [2.68.260.26243](https://download.microsoft.com/download/f4eb73e6-3203-49df-aded-e56f6206209b/Setup.Microsoft.PowerAutomate.exe)
- [2.67.153.26243](https://download.microsoft.com/download/54cc2eae-f487-4c9f-a7cf-7526397b8a5f/Setup.Microsoft.PowerAutomate.exe)
- [2.66.169.26243](https://download.microsoft.com/download/a5d3ccef-b603-4979-862e-c61b071501ea/Setup.Microsoft.PowerAutomate.exe)

> [!NOTE]
> Versions 2.69 and later of Power Automate for desktop aren't vulnerable. For more information about how to keep installations current, see [Automatic updates for Power Automate for desktop](/power-automate/desktop-flows/auto-update) and [Install Power Automate for desktop](/power-automate/desktop-flows/install).

### Disable the Java automation sync service

If you must stay on an unpatched version of Power Automate for desktop, disable the Power Automate Java sync service through Windows services (`services.msc`):

1. Sign in to the machine as a local administrator.
1. Select **Start**, enter `services.msc`, and then open the **Services** console.
1. In the list of services, locate **Power Automate Java sync service** (service name `PADJavaSyncService`).
1. Right-click the service, and then select **Properties**.
1. Set **Startup type** to **Disabled**.
1. If the service status is **Running**, select **Stop**.
1. Select **OK**.

After you disable the service, Java automation might not work correctly if the Java JRE or JDK on the machine is updated. If that happens, you might have to manually run `PAD.Java.Installer.Host.exe` from the Power Automate for desktop installation folder, which is located at `C:\Program Files (x86)\Power Automate Desktop\dotnet` by default.

## Related content

- [Automate Java applications](/power-automate/desktop-flows/how-to/java)
- [Power Automate for desktop released versions](/power-platform/released-versions/power-automate-desktop)
- [Install Power Automate for desktop](/power-automate/desktop-flows/install)

