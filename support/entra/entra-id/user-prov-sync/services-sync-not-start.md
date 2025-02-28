---
title: Microsoft Entra Connect services don't start
description: Describes an issue that prevents Microsoft Entra Connect services from starting. Provides a resolution.
ms.date: 02/28/2024
ms.reviewer: riantu, nualex, reviei, v-leedennis
ms.service: entra-id
ms.custom: sap:Microsoft Entra Connect Sync
---
# One or more Microsoft Entra Connect services don't start

This article describes an issue that prevents Microsoft Entra Connect services from starting.

_Original product version:_ &nbsp; Microsoft Entra ID, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2995030

## Symptoms

You discover that one or more Microsoft Entra Connect services don't start. For example, the Microsoft Azure AD Sync service (ADSync) doesn't start.

## Solution 1: Set User Rights Assignment permissions within Group Policy

Make group policy changes if necessary so that the ADSync service account can log on locally, as a service, and as a batch job. Because a domain group policy takes precedence over a local group policy, you need to check the settings for both types of group policies.

1. Select **Start**, enter _gpedit.msc_ in the search box, and then press Enter to open the Local Group Policy Editor snap-in.

1. In the console tree, under **Computer Configuration**, expand **Windows Settings** > **Security Settings** > **Local Policies**, and then select **User Rights Assignment**.

1. Verify that the ADSync service account is added for the following policy settings:

   - **Allow log on locally**
   - **Log on as a batch job**
   - **Log on as a service**

1. For domain group policies, open an administrative command prompt.

1. Run the following [gpresult](/windows-server/administration/windows-commands/gpresult) command, which generates a group policy report:

   ```cmd
   gpresult /H gpresult.htm
   ```

1. Open the resulting group policy report (*gpresult.htm*).

1. If **User Rights Assignment** settings are applied through any domain group policy object (GPO), use the **Group Policy Management** console (*gpmc.msc*) from a domain controller to take one of the following actions:

   - Remove the following policy settings from the **Winning GPO**:
     - **Allow log on locally**
     - **Log on as a batch job**
     - **Log on as a service**

   - Update the **Winning GPO** to include the ADSync service account.

1. If you made any changes to the local group policy or domain group policy, restart the computer to apply the changes.

## Solution 2: Troubleshoot error messages in Event Viewer logs

You can also try to find and fix the problem by scanning the Application and System logs for directory synchronization events. All directory synchronization logging is viewable in Event Viewer. For details, see [Troubleshoot other error messages](installation-configuration-wizard-errors.md#troubleshoot-other-error-messages).

## Solution 3: Check the Microsoft Azure AD Sync (ADSync) service account

If solutions 1 and 2 do not resolve the issue, verify the status of your custom ADSync service account. Ensure that the account is not expired or disabled, does not have "User must change password at next logon" enabled, and that its password is not expired. If the password has been changed, use the Services.msc console to update the ADSync service account password.

For information on other types of Windows service accounts, refer to [ADSync service account](/entra/identity/hybrid/connect/concept-adsync-service-account) documentation.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
