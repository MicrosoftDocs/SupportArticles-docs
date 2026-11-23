---
title: Fix HTTP Error 500.19 in IIS Configuration Files
description: Fix HTTP error 500.19 in IIS by matching the HRESULT code to its cause. Diagnose malformed XML, locked sections, permissions, and missing modules.
ms.date: 09/09/2026
ms.custom: sap:Site Behavior and Performance\Runtime errors and exceptions, including HTTP 400 and 50x errors
ms.reviewer: hugo.durana, v-shaywood, jaws
ai-usage: ai-assisted
---
# HTTP error 500.19 - Internal Server Error in IIS

_Original product version:_ &nbsp; Internet Information Services 7.0 and later versions  
_Original KB number:_ &nbsp; 942055

## Summary

You receive HTTP error 500.19 - Internal Server Error when a website's configuration is invalid in Internet Information Services (IIS) 7.0 and later versions. Common causes include malformed XML, locked configuration sections, insufficient permissions, duplicate entries, and missing modules.

To fix this error, find the HRESULT code in the error message, and check the matching section. For ASP.NET Core applications, see [Missing hosting bundle for ASP.NET Core](#missing-hosting-bundle-for-aspnet-core).

## HRESULT code 0x8007000d

> Server Error in Application "\<ApplicationName>"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x8007000d  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

### Cause

This error occurs when IIS encounters **malformed or unrecognized XML elements** in the `ApplicationHost.config` or `Web.config` file.  
Typical reasons include:

- A module or handler is defined in the configuration file, but the **corresponding IIS component or extension isn't installed** (for example, the [IIS URL Rewrite module](/iis/extensions/url-rewrite-module/using-the-url-rewrite-module) or _Request Filtering_).  
- A **syntax error** or missing tag in the configuration file (for example, an unclosed element or extra angle bracket).  
- Manual edits or merges of configuration files from different environments that introduce incompatible XML entries.

### Diagnose configuration errors

1. **Check Event Viewer logs**
   - Open **Event Viewer** > **Windows Logs** > **Application**.  
   - Look for **WAS** or **IIS-W3SVC** events around the time of the error.  
   - The event details often specify the **line number and XML element** causing the issue.

1. **Use IIS Configuration Editor**
   - Open **IIS Manager** > `<SiteName>` > **Configuration Editor**.  
   - Try to open the configuration section mentioned in the error.  
   - If it fails to load, it indicates a malformed or unrecognized section.

1. **Validate XML syntax**
   - Open the configuration file in a code editor (for example, Visual Studio Code).  
   - Enable XML validation and look for red squiggly lines or unmatched tags.

1. **Identify missing modules**
   - Check for unrecognized section names like `<rewrite>`, `<compression>`, or `<authentication>`.  
   - Verify whether you installed the corresponding features or modules.
   - Check for module references in `C:\Windows\System32\inetsrv\Config\ApplicationHost.config`.

### Solution

Choose the option that applies to your situation. You don't need to complete all the options.

#### Option 1: fix malformed XML

- Open the file and review the **line number** mentioned in the error (if specified).  
- Ensure all XML tags are **properly closed**, **nested**, and **spelled correctly**.  
- Validate the syntax in a code editor like Visual Studio Code.

#### Option 2: install missing IIS modules

If the error references an **unrecognized section** (for example, `<rewrite>`, `<dynamicCompression>`, or `<urlCompression>`), install the corresponding IIS module.

#### Option 3: temporarily remove or comment out unrecognized entries

If the referenced module isn't required or isn't available on the server:

1. Open the `Web.config` or `ApplicationHost.config` file.  
1. Locate the **unrecognized section** (for example, `<rewrite>` or `<customModule>`).  
1. Comment out or remove that section.

#### Option 4: validate configuration with IIS tools

Use either of the following methods to test or validate configuration integrity.

- Check configuration sections for issues.

   ```console
   %windir%\system32\inetsrv\appcmd list config /section:system.webServer
   ```

- Or open **Configuration Editor** in IIS Manager and verify the sections manually.

#### Option 5: redeploy or recreate configuration

If the other applicable options don't fix the issue, choose one of the following actions:

- Copy a known-good version of the configuration file from a working environment.  
- Or redeploy your web application by using a deployment tool (for example, **Web Deploy**) to overwrite corrupted configurations.

## HRESULT code 0x80070021

> Server Error in Application "\<ApplicationName>"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x80070021  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

### Cause

This error occurs when IIS encounters a **locked configuration section** that can't be overridden at a lower level (for example, in a site's `Web.config` file).  
You can **lock** IIS configuration sections at higher levels such as:

- `ApplicationHost.config` (server-level)  
- `root Web.config` (framework-level)

When you lock a section, you prevent child configuration files from redefining or customizing it.  
This lock usually happens when a global IIS policy enforces settings centrally for security or consistency.

### Solution

Choose the option that applies to your situation. You don't need to complete all the options.

For more information about configuration locking, see [How to Use Locking in IIS 7.0 Configuration](/iis/get-started/planning-for-security/how-to-use-locking-in-iis-configuration).

#### Option 1: unlock the configuration section

Choose one of the following methods to unlock the section. You don't need to use both.

##### Method 1: use the command line

```console
%windir%\system32\inetsrv\appcmd unlock config /section:handlers
```

##### Method 2: use IIS Manager

1. Open **IIS Manager**.  
1. Select the **server node** (top level).  
1. Double-click **Configuration Editor**.  
1. From the drop-down list, select the **section** (for example, `system.webServer/handlers`).  
1. In the **Actions** pane, click **Unlock Section**.

- **Result:**  
This action makes the section editable at lower configuration levels (such as per-site or per-application).

#### Option 2: remove or change the conflicting section in Web.config

If you can't unlock the section (for policy reasons), remove or comment out the section in your `Web.config` file.
Then, reapply the configuration at the **server level** or **site root** where the section is allowed.

#### Option 3: change lock settings in ApplicationHost.config

> [!CAUTION]
> Changes to `ApplicationHost.config` affect all IIS sites. Back up the file before you edit it.

If the lock is defined explicitly, you can modify it manually.

1. Open the following file in a text editor with administrator rights.

   ```text
   C:\Windows\System32\inetsrv\Config\ApplicationHost.config
   ```

1. Search for a locked section entry like the following one.

   ```xml
   <section name="handlers" overrideModeDefault="Deny" />
   ```

1. Change the entry to the following value.

   ```xml
   <section name="handlers" overrideModeDefault="Allow" />
   ```

1. Save the file and restart IIS.

#### Option 4: review configuration policy

If you're in an enterprise environment, configuration locking might be **intentional** (for security or standardization).  
In that case:

- Consult your IIS administrator or infrastructure policy owner before unlocking sections.  

## HRESULT code 0x80070005

> Server Error in Application "\<ApplicationName>"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x80070005  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

### Cause

This problem occurs for one of the following reasons:

- The website uses Universal Naming Convention (UNC) pass-through authentication to access a remote UNC share.
- The `IIS_IUSRS` group doesn't have the appropriate permissions for the `ApplicationHost.config` file, the `Web.config` file, or the virtual or application directories of IIS.

### Solution

Use one of the following methods:

- Don't configure the website to use UNC pass-through authentication to access the remote UNC share. Instead, specify a user account that has the appropriate permissions to access the remote UNC share.

- Grant the Read permission to the IIS_IUSRS group for the `ApplicationHost.config` or `Web.config` file:

    1. In Windows Explorer, locate the folder that contains the `ApplicationHost.config` file that's associated with the website, or locate the virtual directories or application directories that contain the `Web.config` file that's associated with the website.

       > [!NOTE]
       > The `Web.config` file might not be in the virtual directories or application directories in IIS. Even in this situation, follow these steps:

    1. Right-click the folder that contains the `ApplicationHost.config` file, or right-click the virtual or application directories that might contain the `Web.config` file.

    1. Select **Properties**.

    1. Select the **Security** tab, and then select **Edit**.

    1. Select **Add**.

    1. In the **Enter the object names to select** box, type `<ComputerName>\IIS_IUSRS`, select **Check Names**, and then select **OK**.

    1. Select the **Read** checkbox, and then select **OK**.

    1. In the **Properties** dialog for the folder, select **OK**.

        > [!NOTE]
        > Ensure that the folder properties are inherited by the `ApplicationHost.config` and `Web.config` files so that IIS_IUSRS has the _Read_ permission for those files.

## HRESULT code 0x800700b7

> Server Error in Application "\<ApplicationName>"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x800700b7  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

### Cause

A duplicate entry exists for the specified configuration section setting at a higher level in the configuration hierarchy (for example, the `ApplicationHost.config` or `Web.config` file in a parent site or folder`). The error message shows the location of the duplicate entries.

### Solution

Check the specified configuration file and compare it with its parent `ApplicationHost.config` or `Web.config` file to look for duplicate entries. Either remove the duplicate entry or make the entry unique. For example, this problem might occur because the `ApplicationHost.config` file has a duplicate entry for the following code:

```xml
<add accessType="Allow" users="*" />
```

To fix this problem, delete the duplicate entry in the `ApplicationHost.config` file for the authorization rule:

1. Open **Notepad** as an administrator.

1. On the **File** menu, select **Open**, enter `%windir%\System32\inetsrv\config\ApplicationHost.config` in the **File name** field, and then select **Open**.

1. In the `ApplicationHost.config` file, delete the duplicate entry that resembles the following code:

    ```xml
    <add accessType="Allow" users="*" />
    ```

## HRESULT code 0x8007007e

> Server Error in Application "\<ApplicationName>"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x8007007e  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

### Cause

The `ApplicationHost.config` or `Web.config` file references a module or a DLL that's invalid or doesn't exist.

### Solution

In the `ApplicationHost.config` or `Web.config` file, locate the invalid module reference or DLL reference, and then remove the reference. To determine which module reference is incorrect, enable [Failed Request Tracing](../health-diagnostic-performance/troubleshoot-failed-requests-using-tracing-in-iis-85.md), and then reproduce the problem.

## HRESULT code 0x800700c1

> Server Error in Application "\<ApplicationName>"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x800700c1  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

### Cause

The bitness of the specified module differs from the application pool that hosts the application. For example, you try to load a 32-bit component into a 64-bit application pool. This problem might also occur if the specified module is corrupted.

### Solution: match module and application pool bitness

Ensure that the specified module's bitness matches the hosting application pool. Also, ensure that the module isn't corrupted.

## HRESULT code 0x8007010b

> Server Error in Application "\<ApplicationName>"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x8007010b  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

### Cause

The specified content directory can't be accessed.

### Solution

- Check that the file path exists.
- Check that the file path is correctly named.
- Check that the file path has the correct file-level permissions set.
- Check that the file path points to a valid file system type.

If you're not sure what the file path is, use [Process Monitor](/sysinternals/downloads/procmon) or [Failed Request Tracing](../health-diagnostic-performance/troubleshoot-failed-requests-using-tracing-in-iis-85.md) to identify it.

## HRESULT code 0x8007052e

> Server Error in Application "\<ApplicationName>"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x8007052e  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

### Cause

The default process identity in IIS doesn't have sufficient permissions to open the `Web.config` file on a remote share.

### Solution

Check that the application pool identity account of this web application has sufficient permissions to open the `Web.config` file.

## HRESULT code 0x80070003

> Server Error in Application "\<ApplicationName>"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x80070003  
> Description of HRESULT  
> Cannot read configuration file.

### Cause

This error is caused by insufficient permissions or by a physical path that doesn't match the path for the virtual directory. For example, no `Web.config` file exists under the web app's physical root path.

### Solution

- Check that the `Web.config` path exists and has correct permissions set.
- Collect [Process Monitor](/sysinternals/downloads/procmon) logs to get more information about the error.

## Missing hosting bundle for ASP.NET Core

If this error occurs for an ASP.NET Core application, the ASP.NET Core Hosting Bundle for the .NET version that your application targets likely isn't installed. Download and install the correct version of the [.NET Hosting Bundle](/aspnet/core/host-and-deploy/iis/hosting-bundle).

## Prevent configuration file issues during Windows updates

As a general safety measure, back up all configuration files (not only IIS) before you install any update. If you use virtual machines, take a snapshot before you update. This guidance applies to all updates, not only Windows updates.

## Related content

- [HTTP status codes in IIS](../health-diagnostic-performance/http-status-code.md)
- [Introduction to ApplicationHost.config](/iis/get-started/planning-your-iis-architecture/introduction-to-applicationhostconfig)
- [Getting Started with Configuration in IIS](/iis/get-started/planning-your-iis-architecture/getting-started-with-configuration-in-iis-7-and-above)
