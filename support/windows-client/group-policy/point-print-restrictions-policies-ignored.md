---
title: Point and Print Restrictions policies are ignored in Windows
description: Describes an issue that occurs when a standard user tries to install a network printer. Provides a resolution.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot
---
# Point and Print Restrictions policies are ignored in Windows

This article provides a solution to an issue where the Point and Print Restrictions policies are ignored when a standard user tries to install a network printer.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2307161

## Symptoms

Consider the following scenario:

- You have a computer that is running Windows.
- You apply the Point and Print Restrictions policies.
- A standard user tries to install a network printer.

In this scenario, the Point and Print Restrictions policies are ignored, and the user is prompted for administrative credentials.

## Cause

Windows ignore the Point and Print Restrictions policies when the policies are implemented in the user policy context.

The Point and Print Restrictions policies were previously implemented in the following location:

User Configuration\\Policies\\Administrative Templates\\Control Panel\\Printers

Now, these policies are implemented in the following location:

Computer Configuration\\Policies\\Administrative Templates\\Printers: Point and Print Restrictions

To have a consistent experience, we recommend that you set the policy in both locations if you're dealing with mixed-level clients.

## Resolution

> [!NOTE]
> The following procedure assumes that you're using the version of the Group Policy Management Console (GPMC) that is included with Windows. Otherwise, you must have updated ADMX files in your domain central store in order to see these options. To install the GPMC on Windows, use the Add Features Wizard of Server Manager.

### How to change the Point and Print Restrictions policies setting

1. Open the Group Policy Management Console (GPMC).
2. In the GPMC console tree, navigate to the domain or organizational unit (OU) that stores the user accounts for which you want to modify printer driver security settings.
3. Right-click the appropriate domain or OU, click **Create a GPO in this domain, and Link it here**, type a name for the new GPO, and then click **OK**.
4. Right-click the GPO that you created, and then click **Edit**.
5. In the Group Policy Management Editor window, click **Computer Configuration**, click **Policies**, click **Administrative Templates**, and then click **Printers**.
6. Right-click **Point and Print Restrictions**, and then click **Edit**.

### How to permit users to connect only to specific print servers that you trust

1. In the **Point and Print Restrictions** dialog box, click **Enabled**.

    Computer Configuration\\Policies\\Administrative Templates\\Printers: Point and Print Restrictions  

    Setting: Enabled

2. Click to select the Users can only point and print to these servers check box if it's not already selected.
3. In the text box, type the fully qualified server names to which you want to allow users to connect. Separate each name by using a semicolon (;).
4. In the **When installing drivers for a new connection** box, select **Do not show warning or elevation prompt**.
5. In the **When updating drivers for an existing connection** box, select **Show warning only**.
6. Click **OK**.

## More information

Alternatively, you can disable the driver installation warning messages and elevation prompts by completely disabling the Point and Print Restrictions policies. This action disables the enhanced printer driver installation security.

Computer Configuration\\Policies\\Administrative Templates\\Printers: Point and Print Restrictions  

Setting: Disable
