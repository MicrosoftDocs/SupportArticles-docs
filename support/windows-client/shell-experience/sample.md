# Taskbar Calendar does not open

This article provides information about the behavior of the taskbar calendar in Windows 11.

## External Monitor

When using a second monitor, you can control its behavior by navigating to **Settings** > **System** > **Display**.

**Extend these displays**: When this option is selected, you can choose which monitor will be the primary one. Note that the taskbar calendar will only pop up on the primary monitor. This behavior is by design.

**Duplicate these displays**: When this option is selected, you can open the taskbar calendar on any monitor.

## Calendar not opening on Windows 11

If you are using Windows 11 and have disabled the notification center, you will not be able to see the calendar extended when clicking on the taskbar calendar. This is by design, as the calendar in Windows 11 is part of the notification center.

Note: Removing the notification and action center is not the same as turning off notifications, if you turn off notification the notification and action center is still functional, if you click on the taskbar calendar it will pop up

## Check if the notification and action center is disabled

You can check if notification and action center is disabled by policy if you try this

1. Open the Group Policy Editor: Press Win + R to open the Run dialog box, type gpedit.msc, and press Enter.

2. Navigate to the following path:

   User Configuration > Administrative Templates > Start Menu and Taskbar

   OR

   Computer Configuration > Administrative Templates > Start Menu and Taskbar

3. Locate the policy: Find the policy named Remove Notifications and Action Center.

4. Check the policy settings: Double-click on it to open its properties. If the policy is set to Enabled, it means the Notification Center is disabled.

## Check if the "Remove Notification and Action Center" policy is enabled by using Intune

1. On your managed device, go to **Settings** > **Accounts** > **Access work or school**.

2. Select your work or school account, and then select **Info**.

3. At the bottom of the **Settings** page, select **Create report**.

4. A window opens, showing the path to the log files. Select **Export**.

5. In **File Explorer**, navigate to *C:\Users\Public\Documents\MDMDiagnostics* to find the report.

6. Open the report, search for "**Remove Notification** **and Action Center**" and check if the policy is enabled.
