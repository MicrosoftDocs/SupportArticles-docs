---
title: Error when you instantiate ActiveX component 
description: This article provides resolutions for the error that occurs when you attempt to run an Active Server Pages that use Server.CreateObject to instantiate an ActiveX component.
ms.date: 08/07/2020
ms.prod-support-area-path: Site Behavior and Performance
ms.reviewer: kerryre
ms.prod: iis
---
# Server Object Error ASP 0177:80040154

This article helps resolve the error that occurs when you attempt to run an Active Server Pages that use `Server.CreateObject` to instantiate an ActiveX component.

_Original product version:_ &nbsp; Microsoft Active Server Pages  
_Original KB number:_ &nbsp; 175804

## Symptoms

When attempting to run an Active Server Pages (ASP) page that uses `Server.CreateObject` to instantiate an ActiveX component, the following error message appears:

```console
Server object error 'ASP 0177:80040154'
Server.CreateObject Failed
/<path>/<yourasp.asp><line #>
The call to Server.CreateObject failed. The request object instance Cannot be created.
```

## Cause

Here are some of the typical causes of this error:

- Your control is not registered correctly.

- The **Logged On User**, usually the anonymous account does not have adequate permissions to run the control. In many cases, the anonymous login account (`IUSR_<machine>`) does not have appropriate permissions on certain `Directories/Files` or the specific component and its dependencies. While less frequent, if the registry permissions for certain keys are not set correctly, it causes the control to fail to initialize.

- The **Everyone** group has been removed from having **READ** permissions on certain registry keys due to the mistaken notion that **Everyone** means **ANYONE**, when in actuality it simply means all validated users on the `Domain/machine`.

- In the case of a file database, such as Access or FoxPro, the directory containing the database files does not provide sufficient permissions for the authenticated user.

## Resolution

> [!WARNING]
> The following assumes a familiarity with Internet Information Server and editing the registry. It is always advised that you back up the Registry prior to making any changes.

Since this error is associated with incorrect permission settings on files or registry settings, you must complete the following steps:

1. Find out who is the Authenticated User. To determine what user is being authenticated, add the following code to the top of your ASP page:

    ```aspx
     <%
     Response.Write("LOGON_USER: " & _
     Request.ServerVariables("LOGON_USER"))
     %>
    ```

    If the `LOGON_USER` is blank, you are being authenticated as `IUSR_machine`. Otherwise, the `LOGON_USER` displays the `<domain\user>` name of the authenticated user who is attempting to create the object.

2. Confirm that the Authenticated User (or Group) has permission on the necessary directories, files, and registry keys. This requires knowledge of the directories, files, and registry keys specific to the control. Below is a list of the requirements for ActiveX Data Objects.

## Directory/File permissions for ADO-specific case

```console
\InetPub - IUSR_<machine> READ
\InetPub\wwwroot - IUSR_<machine> READ
\Program Files\Common Files\System\ADO - IUSR_<machine> READ
\Program Files\Common Files\System\OLE DB - IUSR_<machine> READ
\Program Files\Common Files\ODBC\Data Sources -IUSR_<machine> READ
\WinNT - IUSR_<machine> CHANGE
\WinNT\System32 - IUSR_<machine> READ
\WinNT\System32\Inetsrv\Asp - IUSR_<machine> READ
\WinNT\System32\Inetsrv\Asp\Cmpnts - IUSR_<machine> READ
\WinNT\Temp - IUSR_<machine> CHANGE
```

## Registry permissions for ADO-specific case

Ensure the following permissions are set on the keys listed below:

Permissions:

```console
<machine>\Administrator      - Full Control  
Creator Owner                - Full Control  
Everyone                     - READ  
INTERACTIVE                  - Special Access (Query Value, Set Value, Create Subkey,
                                               Enumerate Subkeys, Notify, Delete)  
SYSTEM                       - Full Control
```

Keys:

```console
HKEY_CLASSES_ROOT
\LICENCES
\CEDD4F80-B43C-11cf-837C-00AA00573EDE
HKEY_CLASSES_ROOT
\ADODB.Command
\ADODB.Connection
\ADODB.Parameter
\ADODB.Recordset
```

## File and folder permissions for the database case

Make sure the database files and the folders containing the database files provide **Read**, **Write**, and **Execute** permissions for the authenticated user or group.

## General trouble shooting steps

1. Check to see if ASP is installed correctly by running the ADO using `Server.CreateObject` sample in the **Active Server Pages Roadmap\More Samples folder**.
2. Make sure all DLLs are registered with `Regsvr32`.
3. Make sure there are not multiple versions of the DLL registered and the registry entry points to the correct one.
4. Make sure any DLLs are using the Apartment Threading Model and are not Single Threaded (See Note 2 below).
5. Confirm that the Primary Domain Controller (PDC) has given Everyone **Access this computer from the network** rights. If IIS is a PDC assure that the `IUSR_<machine>` also has these rights as well as **Log on Locally** rights.

## Quick permissions check steps

1. Force Anonymous by clearing Basic and NT Challenge and Response (NTCR) in IIS Service Manager.
2. Temporarily add the `IUSR_<machine>` to the Administrators group to see if it makes a difference. If it does, the problem is a permissions problem.
3. Turn on **NT Auditing** (as noted below) and try again.

## Not so quick permissions check steps

1. Force Anonymous by clearing Basic and NT Challenge and Response (NTCR) in IIS Service Manager.
2. Create a new NT User account called *IUSR_Test*.
3. Give *IUSR_Test* Full Control of the root drive and cascade these permissions all the way down. Later, *IUSR_Test* can be deleted, thereby removing them from any directories or files.
4. Turn on NT Auditing (as noted below) and try again.

Enable NT Auditing:

To enable auditing, open **User Manager** and select **Audit** from the **Policies** menu. Select the **File and Object Access** failure. Open **Windows NT Explorer** and select the root of your hard drive. Right-click and select **properties**. Select the **Security** tab and press the **Auditing** button. Add the user of interest (the one returned by the ASP page or `IUSR_machine`) and select all the failure check boxes. Make sure you apply these settings to all folders. Use the **Event Viewer** to see any access failures (select **Security** from the **Log** menu). Make sure you turn auditing off when you are finished making changes.

NOTE 1: Jet uses the `SYSTEM TEMP` and `TMP` environment variables to specify the location of temporary files that are created during JET operations. By default these environment variables are defined for users and are not system-wide settings. To set these up, you can do one of the following two operations.

- Option 1. In the *autoexec.bat*, add something similar to the following two lines:

    ```dos
    Set TEMP=C:\Temp
    Set TMP =C:\Temp
    ```

- Option 2. Right-click **My Computer**:

    1. Click **Properties** and select the **Environment TAB**.
    2. Click an entry in the **System Variables List** box (the one on top).
    3. In the **Variable and Value Edit** control, type the following:

        ```dos
        Variable = Temp
        Value = C:\Temp
        ```

    4. Click **Set**. You will now see `TEMP` has been added to the list of system variable.
    5. Repeat the process for the `TMP` variable.
    6. Reboot the machine for changes to take effect. In addition, it has been found that `IUSR_<machine>` needs **CHANGE** permission to the WinNT directory to create temporary files when using the Access database driver.

NOTE 2: By default ASP creates single-threaded apartment clients, which means that only single-threaded apartment inproc servers are given the desired security context passed on by IIS. All other threading models are run in the SYSTEM context. This means, a DLL using the Single Threading Model will start up in the Security Context of SYSTEM, and not as intended as the Authenticated User.
