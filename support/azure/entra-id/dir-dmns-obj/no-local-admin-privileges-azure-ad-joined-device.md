---
title: No local administrator group privileges on Microsoft Entra joined device
description: Resolve a scenario in which you don't receive local administrator group privileges after you sign in to a Microsoft Entra joined device.
ms.date: 07/25/2023
author: ilyalushnikov
ms.author: ilyal
ms.editor: v-jsitser
ms.reviewer: gudlapreethi, jafritts, shhada, v-leedennis
ms.service: entra-id
ms.subservice: users
---
# No local administrator group privileges on Microsoft Entra joined device

This article discusses how to resolve a scenario in which you assign or activate the Azure AD Joined Device Local Administrator role for a user, but the user doesn't receive local administrator group privileges after they sign in to a Microsoft Entra joined device.

## Cause 1: User was assigned the Azure AD Joined Device Local Administrator role while using a cached PRT

You assigned the Azure AD Joined Device Local Administrator role to a user who was still using a cached primary refresh token (PRT) on their local device.

#### Check for the presence of a PRT

To check whether an active [PRT](/azure/active-directory/devices/concept-primary-refresh-token) exists, run the following [dsregcmd](/azure/active-directory/devices/troubleshoot-device-dsregcmd) command at a command prompt:

```cmd
dsregcmd /status
```

In the command output, locate the [SSO State](/azure/active-directory/devices/troubleshoot-device-dsregcmd#sso-state) section. (`SSO` stands for "single sign-on.") The time at which the PRT was previously updated is shown in the `AzureAdPrtUpdateTime` field.

## Cause 2: Privileged Identity Management (PIM) was activated for a user who has a cached PRT

You used [Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure) (PIM) to activate a user into the Microsoft Entra joined device local administrator role, but they have a cached PRT on their local device.

For instructions to determine whether a PRT is active, see [Check for the presence of a PRT](#check-for-the-presence-of-a-prt).

## Solution 1: Wait until the PRT is renewed

The Cloud Authentication Provider (CloudAP) plug-in renews the PRT every four hours. If the user waits out the time interval of up to four hours before the CloudAP plug-in renews the PRT, they can then sign in and receive the local administrator group privileges, as expected.

## Solution 2: Get a new PRT

If you want to fix the missing privileges issue immediately so that the user doesn't have to wait, use a new PRT. Getting a new PRT is a multipart process.

> [!NOTE]  
> If the missing privileges issue was caused by explicitly assigning the role instead of activating PIM, skip Part 1. Instead, start at [Part 2: Check for local administrator permissions](#part-2-check-for-local-administrator-permissions).

### Part 1: (PIM users only) Activate PIM and verify that the role activation was completed

Follow the instructions in [Activate a Microsoft Entra role in PIM](/azure/active-directory/privileged-identity-management/pim-how-to-activate-role) to activate the [Azure AD Joined Device Local Administrator](/azure/active-directory/roles/permissions-reference#azure-ad-joined-device-local-administrator) role for the user. Then, follow these steps in the Azure portal to verify that the role activation was completed for that user:

1. In the [Azure portal](https://portal.azure.com), search for and select **Microsoft Entra Privileged Identity Management**.

1. In the PIM navigation pane, locate the **Tasks** heading, and then select **My roles**.

1. In the **My roles | Microsoft Entra roles** page, select the **Active assignments** tab.

1. In the **Role** column, make sure that the **Azure AD Joined Device Local Administrator** role appears.

### Part 2: Check for local administrator permissions

Have the user follow these steps to check for local administrator permissions:

1. Sign in to the Windows client computer.
1. Select **Start**, enter *cmd*, and then select **Command Prompt** in the search results.
1. Run the following [whoami](/windows-server/administration/windows-commands/whoami) command:

   ```cmd
   whoami /all
   ```

1. In the command output, locate the `GROUP INFORMATION` section, and then check whether the `BUILTIN\Administrators` group is shown in the `Group Name` column. The following example output doesn't list this group in the group information. This means that a cached PRT was obtained before the PIM activation or explicit assignment of the **Azure AD Joined Device Local Administrator** role occurred.

   ```output
   USER INFORMATION
   ----------------

   User Name             SID
   ===================== ==================================================
   someuser\contoso.corp S-1-12-3687709483-1112055202-2756941246-4106396469


   GROUP INFORMATION
   -----------------

   Group Name                                Type             SID          Attributes
   ========================================= ================ ============ ==================================================
   Mandatory Label\Medium Mandatory Level    Label            S-1-16-8192
   Everyone                                  Well-known group S-1-1-0      Mandatory group, Enabled by default, Enabled group
   BUILTIN\Remote Desktop Users              Alias            S-1-5-32-555 Mandatory group, Enabled by default, Enabled group
   BUILTIN\Users                             Alias            S-1-5-32-545 Mandatory group, Enabled by default, Enabled group
   NT AUTHORITY\REMOTE INTERACTIVE LOGON     Well-known group S-1-5-14     Mandatory group, Enabled by default, Enabled group
   NT AUTHORITY\INTERACTIVE                  Well-known group S-1-5-4      Mandatory group, Enabled by default, Enabled group
   NT AUTHORITY\Authenticated Users          Well-known group S-1-5-11     Mandatory group, Enabled by default, Enabled group
   NT AUTHORITY\This Organization            Well-known group S-1-5-15     Mandatory group, Enabled by default, Enabled group
   LOCAL                                     Well-known group S-1-2-0      Mandatory group, Enabled by default, Enabled group
   NT AUTHORITY\Cloud Account Authentication Well-known group S-1-5-64-36  Mandatory group, Enabled by default, Enabled group

   PRIVILEGES INFORMATION
   ----------------------

   Privilege Name                Description                          State
   =======================       ==================================== ========
   SeShutdownPrivilege           Shut down the system                 Disabled
   SeChangeNotifyPrivilege       Bypass traverse checking             Enabled
   SeUndockPrivilege             Remove computer from docking station Disabled
   SeIncreaseWorkingSetPrivilege Increase a process working set       Disabled
   SeTimeZonePrivilege           Change the time zone                 Disabled
   ```

   If the `BUILTIN\Administrators` group is missing, continue to Part 3 to refresh the PRT.

### Part 3: Refresh the PRT and verify that the expected role was received

Have the user follow these steps to refresh the PRT and verify that they now have the expected role:

1. Schedule a refresh of the PRT by running the following `dsregcmd` command:

   ```cmd
   dsregcmd /refreshprt
   ```

   The following message appears:

   > `PRT refresh scheduled. Check AAD event logs for details.`

1. Wait one to two minutes for the token refresh to occur.
1. Sign out of the Windows session, and then sign back in.
1. Run the following `whoami` command:

   ```cmd
   whoami /groups
   ```

1. Check whether the `BUILTIN\Administrators` group is shown in the `Group Name` column. As the following example output shows, that group should now appear in the list of groups:

   ```output
   GROUP INFORMATION
   -----------------

   Group Name                                Type             SID                                                 Attributes
   ========================================= ================ =================================================== ==================================================
   Mandatory Label\Medium Mandatory Level    Label            S-1-16-8192
   Everyone                                  Well-known group S-1-1-0                                             Mandatory group, Enabled by default, Enabled group
   BUILTIN\Remote Desktop Users              Alias            S-1-5-32-555                                        Mandatory group, Enabled by default, Enabled group
   BUILTIN\Users                             Alias            S-1-5-32-545                                        Mandatory group, Enabled by default, Enabled group
   BUILTIN\Administrators                    Alias            S-1-5-32-544                                        Group used for deny only
   NT AUTHORITY\REMOTE INTERACTIVE LOGON     Well-known group S-1-5-14                                            Mandatory group, Enabled by default, Enabled group
   NT AUTHORITY\INTERACTIVE                  Well-known group S-1-5-4                                             Mandatory group, Enabled by default, Enabled group
   NT AUTHORITY\Authenticated Users          Well-known group S-1-5-11                                            Mandatory group, Enabled by default, Enabled group
   NT AUTHORITY\This Organization            Well-known group S-1-5-15                                            Mandatory group, Enabled by default, Enabled group
   LOCAL                                     Well-known group S-1-2-0                                             Mandatory group, Enabled by default, Enabled group
                                             Unknown SID type S-1-12-1-788341310-1134859379-3309005462-3346259773 Mandatory group, Enabled by default, Enabled group
   NT AUTHORITY\Cloud Account Authentication Well-known group S-1-5-64-36                                         Mandatory group, Enabled by default, Enabled group
   ```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
