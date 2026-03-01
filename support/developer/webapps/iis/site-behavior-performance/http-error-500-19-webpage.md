---
title: HTTP Error 500.19 on Internet Information Services (IIS) webpages
description: Resolves the HTTP 500.19 error that occurs when you visit a website that is hosted on IIS 7.0 and later versions.
ms.date: 04/17/2025
ms.custom: sap:Site Behavior and Performance\Runtime errors and exceptions, including HTTP 400 and 50x errors
ms.reviewer: mlaing
---
# HTTP Error 500.19 - internal server error when you open an IIS Webpage

This article resolves a problem in which you receive an "HTTP 500.19" error message on a web application in Internet Information Services (IIS) 7.0 and later versions.

_Original product version:_ &nbsp; Internet Information Services 7.0 and later versions  
_Original KB number:_ &nbsp; 942055

To resolve this error, check the following sections for the appropriate error code information.

## HRESULT code 0x8007000d

Error message:

> Server Error in Application "application name"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x8007000d  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

Cause

This error occurs when IIS encounters **malformed or unrecognized XML elements** in the `ApplicationHost.config` or `Web.config` file.  
Typical reasons include:

- A module or handler is defined in the configuration file, but the **corresponding IIS component or extension is not installed** (for example, *URL Rewrite Module* or *Request Filtering*).  
- A **syntax error** or missing tag in the configuration file (for example, an unclosed element or extra angle bracket).  
- Manual edits or merges of configuration files from different environments that introduce incompatible XML entries.

How to Diagnose

1. **Check Event Viewer Logs**
   - Open **Event Viewer → Windows Logs → Application**.  
   - Look for **WAS** or **IIS-W3SVC** events around the time of the error.  
   - The event details often specify the **line number and XML element** causing the issue.

2. **Use IIS Configuration Editor**
   - Open **IIS Manager → Your Site → Configuration Editor**.  
   - Try to open the configuration section mentioned in the error.  
   - If it fails to load, it indicates a malformed or unrecognized section.

3. **Validate XML Syntax**
   - Open the configuration file in a code editor (for example, Visual Studio Code).  
   - Enable XML validation and look for red squiggly lines or unmatched tags.

4. **Identify Missing Modules**
   - Check for unrecognized section names like `<rewrite>`, `<compression>`, or `<authentication>`.  
   - Verify whether the corresponding features or modules are installed
   - Also check for module references under:
     ```
     C:\Windows\System32\inetsrv\Config\ApplicationHost.config
     ```
Resolution

**Option 1: Fix Malformed XML**

- Open the file and review the **line number** mentioned in the error (if specified).  
- Ensure all XML tags are **properly closed**, **nested**, and **spelled correctly**.  
- Validate the syntax in a code editor like Visual Studio Code.

**Option 2: Install Missing IIS Modules**

If the error references an **unrecognized section** (for example, `<rewrite>`, `<dynamicCompression>`, or `<urlCompression>`), install the corresponding IIS module.

**Option 3: Temporarily Remove or Comment Out Unrecognized Entries**

If the referenced module is not required or unavailable on the server:

1. Open the `Web.config` or `ApplicationHost.config` file.  
2. Locate the **unrecognized section** (for example, `<rewrite>` or `<customModule>`).  
3. Comment out or remove that section.

**Option 4: Validate Configuration Using IIS Tools**

Use the following methods to test or validate configuration integrity.

- Check configuration sections for issues:

      %windir%\system32\inetsrv\appcmd list config /section:system.webServer

- Or open **Configuration Editor** in IIS Manager and verify the sections manually.

**Option 5: Redeploy or Recreate Configuration**

If none of the above works:

- Copy a known-good version of the configuration file from a working environment.  
- Or redeploy your web application using a deployment tool (for example, **Web Deploy**) to overwrite corrupted configurations.

## HRESULT code 0x80070021

Error message:

> Server Error in Application "application name"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x80070021  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

Cause

This problem occurs when IIS encounters a **locked configuration section** that cannot be overridden at a lower level (for example, in a site's `Web.config` file).  
IIS configuration sections can be **locked** at higher levels such as:

- `ApplicationHost.config` (server-level)  
- `root Web.config` (framework-level)

When a section is locked, it cannot be redefined or customized in child configuration files.  
This usually happens when a global IIS policy enforces settings centrally for security or consistency.

Resolution

**Option 1: Unlock the Configuration Section**

Unlock the required section in the **ApplicationHost.config** file or using the **appcmd** utility.

- **Using Command Line:**

    %windir%\system32\inetsrv\appcmd unlock config /section:handlers

- **Using IIS Manager:**

1. Open **IIS Manager**.  
2. Select the **server node** (top level).  
3. Double-click **Configuration Editor**.  
4. From the drop-down list, select the **section** (for example, `system.webServer/handlers`).  
5. In the **Actions** pane, click **Unlock Section**.

- **Result:**  
This makes the section editable at lower configuration levels (such as per-site or per-application).

**Option 2: Remove or Modify the Conflicting Section in Web.config**

If you cannot unlock the section (for policy reasons), remove or comment out the section in your `Web.config`.
Then, re-apply the configuration at the **server level** or **site root** where the section is allowed.

**Option 3: Adjust Locking Behavior in ApplicationHost.config**

If the lock is defined explicitly, you can modify it manually.

1. Open the following file in a text editor (with admin rights):  
       C:\Windows\System32\inetsrv\Config\ApplicationHost.config

2. Search for the locked section entry, for example:

       <section name="handlers" overrideModeDefault="Deny" />

3. Change it to:

       <section name="handlers" overrideModeDefault="Allow" />

4. Save the file and **restart IIS**:

> **Caution:** Editing `ApplicationHost.config` directly affects all IIS sites. Always back up the file before changes.

**Option 4: Review Configuration Policy**

If you are in an enterprise environment, configuration locking might be **intentional** (for security or standardization).  
In that case:
- Consult your IIS administrator or infrastructure policy owner before unlocking sections.  

## HRESULT code 0x80070005

Error message:

> Server Error in Application "application name"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x80070005  
> Description of HRESULT  
The requested page cannot be accessed because the related configuration data for the page is invalid.

Cause

This problem occurs for one of the following reasons:

- You're using IIS on a computer that is running Windows. Additionally, you configure the website to use Universal Naming Convention (UNC) pass-through authentication to access a remote UNC share.
- The IIS_IUSRS group doesn't have the appropriate permissions for the ApplicationHost.config file, the Web.config file, or the virtual or application directories of IIS.

Resolution

Use one of the following methods:

- Don't configure the website to use UNC pass-through authentication to access the remote UNC share. Instead, specify a user account that has the appropriate permissions to access the remote UNC share.

- Grant the Read permission to the IIS_IUSRS group for the ApplicationHost.config or Web.config file. To do it, follow these steps:

    1. In Windows Explorer, locate the folder that contains the ApplicationHost.config file that is associated with the website, or locate the virtual directories or the application directories that contain the Web.config file that is associated with the website.

        > [!NOTE]
        > The Web.config file may not be in the virtual directories or the application directories in IIS. Even in this situation, you have to follow these steps.

    1. Right-click the folder that contains the ApplicationHost.config file, or right-click the virtual or application directories that may contain the Web.config file.

    1. Select **Properties**.

    1. Select the **Security** tab, and then Select **Edit**.

    1. Select **Add**.

    1. In the **Enter the object names to select** box, type **<*computername*>\IIS_IUSRS**, select **Check Names**, and then select **OK**.

        > [!NOTE]
        > <*Computername*> is a placeholder for the computer name.

    1. Select the **Read** check box, and then select **OK**.

    1. In the **Properties** dialog box for the folder, select **OK**.

        > [!NOTE]
        > Make sure that the folder properties are inherited by the ApplicationHost.config and Web.config files so that IIS_IUSRS has the Read permission for those files.

## HRESULT code 0x800700b7

Error message:

> Server Error in Application "application name"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x800700b7  
> Description of HResult  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

Cause

This problem may occur if there's a duplicate entry for the specified configuration section setting at a higher level in the configuration hierarchy (for example, ApplicationHost.config or Web.config file in a parent site or folder). The error message itself points out the location of the duplicate entries.

Resolution

Examine the specified configuration file, and compare it with its parent ApplicationHost.config or Web.config file to check for duplicate entries, as suggested by the error message. Either remove the duplicate entry, or make the entry unique. For example, this problem may occur because the ApplicationHost.config file has a duplicate entry for the following code:

```xml
<add accessType="Allow" users="*" />
```

To resolve this problem, delete the duplicate entry in the ApplicationHost.config file for the authorization rule. To do it, follow these steps:

1. Select **Start**, type **Notepad** in the **Start Search** box, right-click **Notepad**, and then select **Run as administrator**.

    > [!NOTE]
    > If you're prompted for an administrator password or for a confirmation, type the password, or select **Continue**.

2. On the **File** menu, select **Open**, type **%windir%\System32\inetsrv\config\applicationHost.config** in the **File name** box, and then select **Open**.

3. In the ApplicationHost.config file, delete the duplicate entry that resembles the following code:

    ```xml
    <add accessType="Allow" users="*" />
    ```

## HRESULT code 0x8007007e

Error message:

> Server Error in Application "application name"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x8007007e  
> Description of HResult  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

Cause

This problem occurs because the ApplicationHost.config or Web.config file references a module or a DLL that is invalid or doesn't exist.

Resolution

In the ApplicationHost.config or Web.config file, locate the module reference or the DLL reference that is invalid, and then fix the reference. To determine which module reference is incorrect, enable Failed Request Tracing, and then reproduce the problem.

## HRESULT code 0x800700c1

Error message:

> Server Error in Application "application name"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x800700c1  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

Cause

This problem can occur if the bitness of the specified module is different than that of the application pool hosting the application. For example, you're trying to load a 32-bit component into a 64-bit application pool. This problem may also occur if the specified module is corrupted.

Resolution

Make sure that the specified module's bitness is the same as that of the hosting application pool. Also, make sure that the module is not corrupted.

## HRESULT code 0x8007010b

Error message:

> Server Error in Application "application name"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x8007010b  
> Description of HRESULT  
> The requested page cannot be accessed because the related configuration data for the page is invalid.

Cause

This problem can occur if the specified content directory cannot be accessed.

Resolution

- Verify that the file path exists.
- Verify that the file path is correctly named.
- Verify that the file path has the correct file-level permissions set.
- Verify that the file path is pointing to a valid file system type.

If you aren't sure what the file path is, use the Process Monitor or Failed Request Tracing tool to identify it.

## HRESULT code 0x8007052e

Error message:

> Server Error in Application "application name"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x8007052e  
> Description of HRESULT  
The requested page cannot be accessed because the related configuration data for the page is invalid.

Cause

The default process identity in IIS doesn't have sufficient permissions to open the Web.config file on a remote share.

Resolution

Verify that the application pool identity account of this web application has sufficient permissions to open the *Web.config* file.

## HRESULT code 0x80070003

Error message:

> Server Error in Application "application name"  
> HTTP Error 500.19 – Internal Server Error  
> HRESULT: 0x80070003  
> Description of HRESULT  
> Cannot read configuration file.

Cause

This error is caused by a lack of permission or by a physical path that doesn't match the path for the virtual directory. For example, no *Web.config* exists under the web app physical root path.

Resolution

- Verify that the *Web.config* path exists and has correct permissions set.
- Collect Process Monitor logs to get more information about the error.

## Fix IIS Configuration File Breaks After Windows Update

As a general safety rule, all configuration files (not limited to IIS) should be backup before installing any update. If you use Virtual Machines, take a snapshot of the Virtual Machine before you update it. This advice isn’t limited to Windows updates.
