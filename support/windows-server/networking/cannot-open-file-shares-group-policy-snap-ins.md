---
title: Fail to open file shares or Group Policy snap-ins
description: Describes how to resolve a problem that occurs when SMB signing is disabled for the Workstation or Server service on a domain controller, but SMB signing is required for the Server or Workstation service on the same domain controller. This problem occurs in Windows Small Business Server 2003, Windows Server 2003, and Windows 2000 Server.
ms.date: 12/10/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-sanair
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# You cannot open file shares or Group Policy snap-ins on a domain controller

This article describes how to resolve a problem that occurs when SMB signing is disabled for the Workstation or Server service on a domain controller.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 839499

## Summary

You cannot open file shares or the Group Policy snap-ins on a Windows Server 2003 domain controller or on a Windows 2000 Server domain controller. When you log on to the domain controller locally and then try to open shares on the domain controller, you receive repeated password prompts, and you cannot open the shares. You can resolve this problem by changing the registry.

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.  

## Symptoms

### Scenario 1 - Server Message Block (SMB) signing is disabled for the Workstation service on a domain controller, but SMB signing is required for the Server service on the same domain controller

Windows Server 2003

When you try to open Group Policy snap-ins on the domain controller, you receive an error message that resembles the following:  
> You do not have permission to perform this operation. Access is denied.  

The domain controller logs the following events in the application event log every five minutes:

Windows 2000 Server

When you try to open Group Policy snap-ins on the domain controller, you receive an error message that resembles the following:  
>You do not have permission to perform this operation.
>
> Access is denied.
The domain controller logs the following event in the application event log:

When you log on to the domain controller locally and then try to open shares on the domain controller, you receive repeated password prompts, and you cannot open the shares.

### Scenario 2 - SMB signing is disabled for the Server service on a domain controller, but SMB signing is required for the Workstation service on the same domain controller

Windows Server 2003

> Failed to open the Group Policy Object. You may not have the appropriate rights.
>
> The account is not authorized to log in from this station.  

In a network trace, if SMB signing is enabled and required at the client and is disabled at the server, the connection to the TCP session is gracefully closed after the Dialect Negotiation, and the client receives the following error:
> 1240 (ERROR_LOGIN_WKSTA_RESTRICTION)  

The domain controller logs the following events in the application event log every five minutes:
When you log on to the domain controller locally and then try to open file shares on the domain controller, you receive an error message that resembles the following:  
> \\\\*Server_Name*\\*Share_Name* is not accessible. You might not have permission to use this network resource. Contact the administrator of this server to find out if you have access permissions.
>
> The account is not authorized to log in from this station.

> [!NOTE]
> In a network trace, if SMB signing is enabled, and if SMB signing is required at the client and is disabled at the server, the connection to the TCP session is gracefully closed after the dialect negotiation. Also, the client receives the following error message:
1240 (ERROR_LOGIN_WKSTA_RESTRICTION)

Windows 2000 Server

When you try to open Group Policy snap-ins on the domain controller, you receive an error message that is similar to the following:  
> Failed to open the Group Policy Object. You may not have the appropriate rights.
>
> The account is not authorized to log in from this station.  

The domain controller logs the following event in the application event log:
When you log on to the domain controller locally and then try to open file shares on the domain controller, you receive an error message that is similar to the following:  
> \\\\*Server_Name*\\*Share_Name* is not accessible.
>
> The account is not authorized to log in from this station.

> [!NOTE]
> In a network trace, if SMB signing is enabled, and if SMB signing is required at the client and is disabled at the server, the connection to the TCP session is gracefully closed after the dialect negotiation. Also, the client receives the following error message:
1240 (ERROR_LOGIN_WKSTA_RESTRICTION)

## Resolution

To resolve this behavior, follow these steps:

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows XP](https://support.microsoft.com/help/322756).

Step 1 - Change the registry

Change the value of the enablesecuritysignature registry entry. To do this, follow these steps:

1. On the domain controller, click **Start**, and then click **Run.**  
2. Copy and then paste (or type) the regedit command in the Open box, and then press Enter.

    :::image type="content" source="media/cannot-open-file-shares-group-policy-snap-ins/type-regedit.png" alt-text="Screenshot of the Run window with regedit typed in the Open box.":::

3. Locate and then click the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters`  

4. In the right pane, double-click **enablesecuritysignature**, type 1 in the **Value data** box, and then click **OK**.
5. Double-click **requiresecuritysignature**, type 1 in the **Value data** box, and then click **OK**.
6. Locate and then click the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lanmanworkstation\parameters`  

7. In the right pane, double-click **enablesecuritysignature**, type 1 in the **Value data** box, and then click **OK**.
8. Double-click **requiresecuritysignature**, type 0 in the **Value data** box, and then click **OK**.

Step 2 - Restart the Server service and the Workstation service
After you change the registry values, restart the Server service and the Workstation service.  

> [!IMPORTANT]
> Do not restart the domain controller, because this action may cause Group Policy to change the registry values back to the earlier values.

To restart the Server service and the Workstation service, follow these steps:  

1. Click **Start**, point to **Administrative Tools**, and then click **Services**.
2. Right-click **Server**, and then click **Restart**.

    :::image type="content" source="media/cannot-open-file-shares-group-policy-snap-ins/restart-server-service.png" alt-text="Screenshot of the Services window with Server selected, and a menu with Restart selected.":::
3. Right-click **Workstation**, and then click **Restart**.

> [!NOTE]
> If you are prompted to restart other services, click **Yes.**  

Step 3 - Update the Sysvol share

Update the domain controller's Sysvol share. To do this, follow these steps:

1. Open the domain controller's Sysvol share. To do this, click **Start**, click **Run**, type \\\\**Server_Name**\\Sysvol in the **Open** box, and then press Enter.
2. If the Sysvol share does not open, repeat Step 1 - Change the registry and Step 2 - Restart the Server and Workstation services .
3. Repeat Step 1 - Change the registry and Step 2 - Restart the Server and Workstation services on each affected domain controller to make sure that each domain controller can access its own Sysvol share.

Step 4 - Set up the SMB policy settings

After you connect to the Sysvol share on each domain controller, open the Domain Controller Security Policy snap-in, and then set up the SMB signing policy settings. To do this, follow these steps:

1. Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Domain Controller Security Policy**.
2. In the left pane, expand **Local Policies**, and then click **Security Options**.
3. In the right pane, double-click **Microsoft network server: Digitally sign communications (always)**.

    > [!NOTE]
    > In Windows 2000 Server, the equivalent policy setting is **Digitally sign server communication (always)**.

    > [!IMPORTANT]
    > If you have client computers on the network that do not support SMB signing, you must not enable the **Microsoft network server: Digitally sign communications (always)**  policy setting. If you enable this setting, you must have SMB signing for all client communication, and client computers that do not support SMB signing will not be able to connect to other computers. For example, clients that are running Apple Macintosh OS X or Microsoft Windows 95 do not support SMB signing. If your network includes clients that do not support SMB signing, set this policy to disabled.

    :::image type="content" source="media/cannot-open-file-shares-group-policy-snap-ins/click-security-option.png" alt-text="Screenshot of the Default Domain Controller Security Settings window with Security Options selected.":::

4. Click to select the **Define this policy setting** check box, click **Enabled**, and then click **OK**.

    :::image type="content" source="media/cannot-open-file-shares-group-policy-snap-ins/select-enable-for-define-this-policy-settings.png" alt-text="Screenshot of the Microsoft network server window with the Define this policy setting selected and enabled.":::

5. Double-click **Microsoft network server: Digitally sign communications (if client agrees)**.

    > [!NOTE]
    > For Windows 2000 Server, the equivalent policy setting is **Digitally sign server communication (when possible)**.  

6. Click to select the **Define this policy setting** check box, and then click **Enabled**.
7. Click **OK**.
8. Double-click **Microsoft network client: Digitally sign communications (always)**.
9. Click to clear the **Define this policy setting** check box, and then click **OK**.

    :::image type="content" source="media/cannot-open-file-shares-group-policy-snap-ins/clear-define-this-polity-setting-checkbox.png" alt-text="Screenshot of the Microsoft network server window with the Define this policy setting check box cleared.":::

10. Double-click **Microsoft network client: Digitally sign communications (if server agrees)**.
11. Click to clear the **Define this policy setting** check box, and then click **OK**.

Step 5 - Run the Group Policy Update utility

Run the Group Policy Update utility (Gpupdate.exe) with the force switch. To do this, follow these steps:

1. Click **Start**, and then click **Run**.
2. Copy and paste (or type) the cmd command in the Open box, and then press Enter.
  
    :::image type="content" source="media/cannot-open-file-shares-group-policy-snap-ins/type-cmd.png" alt-text="Screenshot of the Run window with cmd typed in the Open box.":::

3. At the command prompt, type `gpupdate /force`, and then press Enter.

    > [!NOTE]
    > The Group Policy Update utility does not exist in Windows 2000 Server. In Windows 2000 Server, the equivalent command is `secedit /refreshpolicy machine_policy /enforce`.

Step 6 - Check the application event log

After you run the Group Policy Update utility, check the application event log to make sure that the Group Policy settings were updated successfully. After a successful Group Policy update, the domain controller logs Event ID 1704. To open the Application log in Event Viewer, follow these steps:

1. Click **Start**, point to **Administrative Tools**, and then click **Event Viewer**.
2. In the left pane, click **Application**.

    :::image type="content" source="media/cannot-open-file-shares-group-policy-snap-ins/click-application-event-viewer.png" alt-text="Screenshot of the Event Viewer window with Application selected.":::

3. Double-click event ID 1704 and confirm that the Group Policy setting was applied successfully.

    > [!NOTE]
    > The source of the event is SceCli.

    :::image type="content" source="media/cannot-open-file-shares-group-policy-snap-ins/event-properties-id-1704.png" alt-text="Screenshot of the Event Properties window for event ID 1704.":::

Step 7 - Check the registry values

Check the registry values that you changed in Step 1 - Change the registry to make sure that the registry values have not changed.

> [!NOTE]
> This step makes sure that a conflicting policy setting is not applied at another group or organizational unit (OU) level. For example, if the Microsoft network client: Digitally sign communications (if server agrees) policy is configured as "Not Defined" in Domain Controller Security Policy, but this same policy is configured as disabled in Domain Security Policy, SMB signing will be disabled for the Workstation service.

Step 8 - Check the SMB signing policy settings by using the Resultant Set of Policy (RSoP) snap-in

If the registry values have changed after you run the Group Policy Update utility, check the SMB signing policy settings by using the RSoP snap-in in Windows Server 2003. To do this, follow these steps:

1. Click **Start**, click **Run**, type rsop.msc in the **Open** box, and then click **OK**.

    :::image type="content" source="media/cannot-open-file-shares-group-policy-snap-ins/type-rsop-msc.png" alt-text="Screenshot of the Run window with rsop.msc typed in the Open box.":::

2. In the RSoP snap-in, the SMB signing settings are located in the following path: **Computer Configuration/Windows Settings/Security Settings/Local Policies/Security Options**  

    > [!NOTE]
    > If you are running Windows 2000 Server, install the Group Policy Update utility from the Windows 2000 Server Resource Kit, and then type the following at the command prompt: `gpresult /scope computer /v`  

3. After you run this command, the **Applied Group Policy Objects**  list appears. This list shows all Group Policy Objects that are applied to the computer account. Check the SMB signing policy settings for all these Group Policy Objects.

## Additional resources

This behavior occurs if the SMB signing settings for the Workstation service and for the Server service contradict each other. When you configure the domain controller in this way, the Workstation service on the domain controller cannot connect to the domain controller's Sysvol share. Therefore, you cannot start Group Policy snap-ins. Also, if SMB signing policies are set by the default domain controller security policy, the problem affects all the domain controllers on the network. Therefore, Group Policy replication in the Active Directory directory service will fail, and you will not be able to edit Group Policy to undo these settings.

### Scenario 1 - If you run the domain controller diagnostic tool (DcDiag.exe), you receive errors that are similar to the following for Windows 2000 Server and for Windows Server 2003

> Starting test: MachineAccount  
Could not open pipe with [SERVERNAME]:failed with 5: Access is denied.  
Could not get NetBIOSDomainName  
Failed cannot test for HOST SPN  
Failed cannot test for HOST SPN  
\* Missing SPN :(null)  
\* Missing SPN :(null)  
......................... SERVERNAME failed test MachineAccount  
Starting test: Services  
Could not open Remote ipc to [SERVERNAME]:failed with 5: Access is denied.  
......................... SERVERNAME failed test Services  
Starting test: ObjectsReplicated  
......................... SERVERNAME passed test ObjectsReplicated  
Starting test: frssysvol  
[SERVERNAME] An net use or LsaPolicy operation failed with error 5, Access is denied..  
......................... SERVERNAME failed test frssysvol  
Starting test: frsevent  
......................... SERVERNAME failed test frsevent  
Starting test: kccevent  
Failed to enumerate event log records, error Access is denied.  
......................... SERVERNAME failed test kccevent  
Starting test: systemlog  
Failed to enumerate event log records, error Access is denied.  
......................... SERVERNAME failed test systemlog

### Scenario 2 - If you run the domain controller diagnostic tool, you receive errors that are similar to the following for Windows 2000 Server and for Windows Server 2003

> Testing server: Default-First-Site-Name\SERVERNAME  
Starting test: Replications  
......................... SERVERNAME passed test Replications  
Starting test: NCSecDesc  
......................... SERVERNAME passed test NCSecDesc  
Starting test: NetLogons  
[SERVERNAME] An net use or LsaPolicy operation failed with error 1240, The account is not authorized to log in from this station..  
......................... SERVERNAME failed test NetLogons  
Starting test: Advertising  
......................... SERVERNAME passed test Advertising  
Starting test: KnowsOfRoleHolders  
......................... SERVERNAME passed test KnowsOfRoleHolders  
Starting test: RidManager  
......................... SERVERNAME passed test RidManager  
Starting test: MachineAccount  
Could not open pipe with [SERVERNAME]:failed with 1240: The account is not authorized to log in from this station.  
Could not get NetBIOSDomainName  
Failed cannot test for HOST SPN  
Failed cannot test for HOST SPN  
\* Missing SPN :(null)  
\* Missing SPN :(null)  
......................... SERVERNAME failed test MachineAccount  
Starting test: Services  
Could not open Remote ipc to [SERVERNAME]:failed with 1240: The account is not authorized to log in from this station.  
......................... SERVERNAME failed test Services  
Starting test: ObjectsReplicated  
......................... SERVERNAME passed test ObjectsReplicated  
Starting test: frssysvol  
[SERVERNAME] An net use or LsaPolicy operation failed with error 1240, The account is not authorized to log in from this station..  
......................... SERVERNAME failed test frssysvol  
Starting test: frsevent  
......................... SERVERNAME failed test frsevent  
Starting test: kccevent  
Failed to enumerate event log records, error The account is not authorized to log in from this station. .........................   SERVERNAME failed test kccevent  
Starting test: systemlog  
Failed to enumerate event log records, error The account is not authorized to log in from this station. .........................   SERVERNAME failed test systemlog
