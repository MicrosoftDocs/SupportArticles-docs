---
title: Use Group Policy settings to control printers
description: Describes the policies specific to managing printers and how to enable or disable printer management by using the Local Group Policy Editor.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:management-and-configuration:-printers-via-group-policy, csstroubleshoot
---
# Use Group Policy settings to control printers in Active Directory

This article describes the policies specific to managing printers and how to use Group Policy settings to manage printers in Active Directory.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 234270

## Summary

Active Directory printer-related settings can be enabled or disabled by using Group Policy settings. All Group Policy settings are contained in Group Policy Objects that are associated with Active Directory containers (sites, organizational units, and domains). This structure maximizes and extends Active Directory.

This article describes the policies specific to managing printers and how to enable or disable printer management by using the Local Group Policy Editor.

There are two kinds of configurations that can be set for printers in a Group Policy setting:

- Computer Configuration
- User Configuration

## Configure printer-specific settings for computers

1. Select **Start**, point to **Programs**, point to **Administrative Tools**, and then select **Active Directory Users and Computers**.

2. Select the Active Directory container of the domain that you want to manage (an organizational unit or a domain). Right-click that container, and then select **Properties**.

3. Select the **Group Policy** tab, and then select **New** to create a new Group Policy setting.

4. In the Local Group Policy Editor, expand the following folders:

   - **Computer Configuration**
   - **Administrative Templates**
   - **Printers**

The following settings can be enabled under **Computer Configuration**:

- **Allow Printers to be published:** Enables or disables the publishing of printers in the directory.

- **Allow Print Spooler to accept client connections:** Controls whether the print spooler will accept client connections. When the policy isn't configured, the spooler won't accept client connections until a user shares out a local printer or opens the print queue on a printer connection. At this point, the spooler will start accepting client connections automatically.

- **Allow pruning of published printers:** Determines whether the domain controller can prune (delete from Active Directory) the printers that are published by this computer. By default, the pruning service on the domain controller prunes printer objects from Active Directory if the computer that published them doesn't respond to contact requests. When the computer that published the printers restarts, it republishes any deleted printer objects.

- **Automatically publish new printers in the Active Directory:** By default, this setting is turned on. It can be turned off so that only shared printers that are selected are put in the directory.

- **Check published state:** Used to verify that published printers are published in Active Directory. By default, the published state isn't verified.

- **Custom Support URL in Printers folder's left pane:**  This policy bit is designed for administrators to add customized support URLs for the server. If this bit isn't selected, the navigation pane of the Printers folder displays URLs for selected printer plus a vendor support URL if it's available. If this bit is selected and the customized support URL is provided, the previously mentioned two support URLs are replaced by the customized URL. The default isn't selected, which means no customized support URL.

- **Computer Location:** Specifies the default location criteria that are used when searching for printers. This setting is a component of the Location Tracking feature of Windows printers. To use this setting, enable Location Tracking by enabling the **Pre-populate printer search location text** setting. When Location Tracking is enabled, the system uses the specified location as a criterion when users search for printers. The value that you type here overrides the actual location of the computer that is conducting the search.

    Type the location of the user's computer. When users search for printers, the system uses the specified location (and other search criteria) to find a printer nearby. You can also use this setting to direct users to a particular printer or group of printers that you want them to use.

- **Directory pruning interval:** The pruning interval determines the period of time that the pruner sleeps between checks for abandoned `PrintQueue` objects. The pruner reads the pruning interval value every hour.

- **Directory pruning retry:** Sets the number of times that the `PrintQueue` pruner tries to contact the print server before it deletes an abandoned `PrintQueue` object.

- **Directory pruning priority:** Sets the thread priority of the pruning thread. The pruning thread runs only on domain controllers and is responsible for deleting stale printers from the directory. Valid values are -2, -1, 0, 1, and 2, corresponding to THREAD_PRIORITY_LOWEST through THREAD_PRIORITY_HIGHEST. The default value is 0.

- **Disallow installation of printers using kernel-mode drivers:** Determines whether printers that use kernel-mode drivers may be installed on the local computer. Kernel-mode drivers have access to system-wide memory. Therefore, poorly written kernel-mode drivers can cause stop errors.

- **Log directory pruning retry events:** Specifies whether to log events when the pruning service on a domain controller tries to contact a computer before it prunes the computer's printers.

    The pruning service periodically contacts computers that have published printers to verify that the printers are still available for use.

    If a computer doesn't respond to the contact attempt, the attempt is retried a specified number of times, at a specified interval. The **Directory pruning retry** setting determines the number of times that the attempt is retried. The default value is two retries. The **Directory Pruning Interval** setting determines the time interval between retries. The default value is eight hours. If the computer hasn't responded by the last contact attempt, its printers are pruned from the directory

- **Pre-populate printer search location text:** Enables the physical Location Tracking setting for Windows printers.

   Use Location Tracking to design a location scheme for your enterprise and assign computers and printers to locations in the scheme. Location Tracking overrides the standard method that is used to locate and associate computers and printers. The standard method uses a printer's IP address and subnet mask to estimate its physical location and proximity to computers. If you enable this setting, users can browse for printers by location without knowing the printer's location or location naming scheme.

   Enabling Location Tracking adds a **Browse** button in the following locations:

  - The **Add Printer** wizard's **Printer Name and Sharing Location** screen
  - The **General** tab in the **Printer Properties** dialog box

   By default, if you enable the Group Policy Computer location setting, the default location that you entered appears in the **Location**  field.

- **Printer Browsing:** If you enable this setting, the print subsystem announces shared printers for printer browsing. Disable this setting if you don't want the print subsystem to add shared printers to the browse list. If this setting isn't configured, shared printers aren't added to the browse list if a Directory service is available. They're added if a Directory service is unavailable.

- **Prune printers that are not automatically republished:** This setting determines whether printers can be pruned from the directory. It's best to leave this setting unconfigured. However, if you find that printers are being pruned even though the computer from which they are published is functioning and on the network, you can enable this policy to prevent the pruning service from deleting the published printers during network outages or situations in which dial-up links that are up only intermittently are used. To prevent printers from being removed from Active Directory, enable this policy, and retain the default selection of **Never** in the **Prune non-republishing printers** list.

- **Web-based printing:** This policy bit is designed for administrators to disable Internet printing entirely. When this policy bit is selected, none of the shared printers on the server are published to the web. And none of the shared printers are able to accept incoming jobs from other clients by using HTTP. The default is not selected.

### New additional Group Policy Objects in Windows Server 2008 R2

1. On the domain controller, select **Start**, select **Administrative Tools**, and then select **Group Policy Management**. Or, select **Start**, select **Run**, type `GPMC.MSC`, and then press **Enter**.
2. Expand the forest and then domains.
3. Under your domain, select the OU where you want to create this policy.
4. Right-click the OU, and then select **Create a GPO in this domain, and link it here**.
5. Give the GPO a name, and then select **OK**. Right-click the newly created Group Policy Object, and then select **Edit** to open Group Policy Management Editor.
6. In Group Policy Management Editor, expand the following folders:
   - **Computer Configuration**
   - **Policies**
   - **Administrative Templates**
   - **Control Panel**
   - **Printers**

The following extra settings can be enabled under **Computer Configuration**:

- **Add Printer wizard** - Network scan page (Managed network): This policy sets the maximum number of printers of each type that the Add Printer wizard will display on a computer on a managed network when the computer can reach a domain controller. For example, a domain-joined laptop on a corporate network.

- **Add Printer wizard - Network scan page (Unmanaged network)**: This policy sets the maximum number of printers of each type that the Add Printer wizard will display on a computer on an unmanaged network when the computer can't reach a domain controller. For example, a domain-joined laptop on a home network.

- **Always render print jobs on the server**: When printing through a print server, determines whether the print spooler on the client will process print jobs itself or pass them on to the server to do the work. This policy setting affects printing to a Windows print server only.

- **Execute print drivers in isolated processes**: This policy setting determines whether the print spooler will execute print drivers in an isolated or separate process. When print drivers are loaded in an isolated process or isolated processes, a print driver failure won't cause the print spooler service to fail.

- **Extend Point and Print connection to search Windows Update**: This policy setting allows you to manage where client computers search for Point and Print drivers. If you enable this policy setting, the client computer will continue to search for compatible Point and Print drivers from Windows Update after it fails to find the compatible driver from the local driver store and the server driver cache.

- **Only use Package Point and print**: This policy restricts client computers to use package point and print only. If this setting is enabled, users will be able to point and print only to printers that use package-aware drivers. When using package point and print, client computers will check the driver signature of all drivers that are downloaded from print servers.

- **Override print driver execution compatibility setting reported by print driver**: This policy setting determines whether the print spooler will override the Driver Isolation compatibility that's reported by the print driver. It enables executing print drivers in an isolated process even if the driver does not report compatibility.

If you enable this policy setting, the print spooler will ignore the Driver Isolation compatibility flag value that is reported by the print driver.

- **Package Point and print - Approved servers**: Restricts package point and print to approved servers. This policy setting restricts package point and print connections to approved servers. This setting applies only to Package Point and Print connections and is independent from the **Point and Print Restrictions** policy that governs the behavior of non-package point and print connections.

    Client that's running Windows Vista or a later version of Windows will try to make a non-package point and print connection anytime that a package point and print connection fail. This includes attempts that are blocked by this policy. Administrators may have to set both policies to block all print connections to a specific print server.

    If this setting is enabled, users will be able to package point and print only to print servers that are approved by the network administrator. When using package point and print, client computers will check the driver signature of all drivers that are downloaded from print servers.

- **Point and Print Restrictions**: This policy setting controls the client Point and Print behavior, including the security prompts for Windows Vista computers. The policy setting applies only to non-Print Administrator clients, and only to computers that are members of a domain.

    When the policy setting is enabled, the following conditions obtain:

  - Windows XP and later clients will only download print driver components from a list of explicitly named servers. If a compatible print driver is available on the client, a printer connection will be made. If a compatible print driver is not available on the client, no connection will be made.

  - You can configure Windows Vista clients so that security warnings and elevated command prompts do not appear when users Point and Print, or when printer connection drivers need to be updated.

    When the policy setting is not configured, the following conditions obtain:

  - Windows Vista client computers can point and print to any server.

  - Windows Vista computers will show a warning and an elevated command prompt when users create a printer connection to any server using Point and Print.

  - Windows Vista computers will show a warning and an elevated command prompt when an existing printer connection driver needs to be updated.

  - Windows Server 2003 and Windows XP client computers can create a printer connection to any server in their forest using Point and Print.

    When the policy setting is disabled, the following conditions obtain:

  - Windows Vista client computers can create a printer connection to any server by using Point and Print.

  - Windows Vista computers will not show a warning or an elevated command prompt when users create a printer connection to any server by using Point and Print.

  - Windows Vista computers will not show a warning or an elevated command prompt when an existing printer connection driver has to be updated.

  - Windows Server 2003 and Windows XP client computers can create a printer connection to any server by using Point and Print.

  - The **Users can only point and print to computers in their forest** setting applies only to Windows Server 2003 and Windows XP SP1 (and later service packs).

    For more information about Point and Print, see the following article:

    [Windows Hardware Dev Center Archive](/previous-versions/windows/hardware/download/dn550976(v=vs.85))

## Configure printer-specific settings for users

1. Select **Start**, point to **Programs**, point to **Administrative Tools**, and then select **Active Directory Users and Computers**.
2. Select the Active Directory container of the domain you want to manage (an Organizational Unit or a domain). Right-click that container, and then select **Properties**.
3. Select **New** to create a new Group Policy.
4. In Group Policy editor, expand the following folders:

    - **User Configuration**
    - **Administrative Templates**
    - **Control Panel**
    - **Printers**

The following settings can be configured under **User Configuration**:

- **Disable the deletion of printers**: Prevents users from deleting local and network printers. If a user tries to delete a printer, such as by using the **Delete** command in the Printers tool in Control Panel, Windows displays a message that explains that the action is prevented by a policy. However, this policy does not prevent users from running programs to delete a printer.

- **Disable the addition of printers**: Prevents users from using familiar methods to add local and network printers. This policy removes the Add Printer wizard from the **Start** menu and from the **Printers** folder in Control Panel. Also, users cannot add printers by dragging a printer icon to the **Printers** folder. If they try to use this method, a message appears that explains that the action is disabled by a policy.

    This policy does not prevent users from using the Add/Remove Hardware wizard to add a printer. Nor does it prevent users from running programs to add printers. This policy does not delete printers that users have already added. However, if users have not added a printer when this policy is applied, they cannot print.

    > [!NOTE]
    > You can use printer permissions to restrict the use of printers without setting a policy. In the **Printers** folder, right-click a printer, click **Properties**, and then click the **Security** tab.

- **Display the down level page in the Add Printer wizard**: Permits users to browse the network for shared printers in the Add Printer wizard. If you enable this policy, when users click **Add a network printer** but do not enter the name of a particular printer, the Add Printer wizard displays a list of all shared printers on the network and prompts users to choose a printer. If you disable this policy, users cannot browse the network. Instead, they must enter a printer name.

    This policy affects the Add Printer wizard only. It does not prevent users from using other tools to browse for shared printers or to connect to network printers.

- **Default Active Directory path when searching for printers**: Specifies the Active Directory location in which searches for printers begin.

    The Add Printer wizard gives users the option of searching Active Directory for a shared printer. If you enable this policy, these searches begin at the location that you specify in the **Default Active Directory path** box. Otherwise, searches begin at the root of Active Directory.

    This policy provides a starting point for Active Directory searches for printers. It does not restrict user searches through Active Directory.

- **Enable browsing for Internet printers**: Adds the path to an Internet or intranet webpage to the Add Printer wizard.

    You can use this policy to direct users to a webpage from which they can install printers.

    If you enable this policy and enter an Internet or intranet address in the text box, Windows adds a **Browse** button to the **Locate Your Printer** page in the Add Printer wizard. The **Browse** button appears beside the **Connect to a printer on the Internet or your Company's Intranet** option. When users click **Browse**, Windows opens an Internet browser and navigates to the specified address to display the available printers.

    This policy makes it easy for users to find the printers that you want them to add.

## References

For more information about these policy settings, click the **Explain** tab for each policy setting.
