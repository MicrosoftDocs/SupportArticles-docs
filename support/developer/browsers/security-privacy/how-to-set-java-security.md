---
title: Set Java security in Internet Explorer
description: This article provides the steps that help you to set Java security in Internet Explorer.
ms.date: 03/02/2020
ms.reviewer: juanf
---
# How to set Java security in Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This step-by-step article describes how to set Java security in Internet Explorer. You can configure Internet Explorer with default security settings or with custom security settings. The custom security settings explicitly define Java permissions for signed and unsigned applets. The Microsoft Virtual Machine must be installed to configure the custom Java permissions.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 315674

## View and change Java custom settings for each security zone

To configure Java security in Internet Explorer:

1. Start Internet Explorer, and then click **Internet Options** on the **Tools** menu.

2. In the **Internet Options** dialog box, click the **Security** tab.

3. There are four security zones on the Security page:

   - Internet
   - Local intranet
   - Trusted Sites
   - Restricted Sites

   Select the zone on which you want to change the Java security settings.

4. In the Security level for this zone frame, click **Custom Level**. In Internet Explorer, click **Custom Level**, and then click **Settings**.

5. View the Microsoft VM section (the Java section in Internet Explorer)

6. In the list of Java Permissions under the Microsoft VM, click **Custom**.

7. Click **Java Custom Settings**.

8. Click the **View Permissions** tab to view the current Java permissions. The Java permissions are grouped in three main categories:

   - Permissions Given to Unsigned Content  
   Unsigned Java applets that request these permissions can run without bringing up a user prompt.
   - Permissions That Signed Content Are Allowed  
   Signed Java applets that requests these permissions can run without user prompting.
   - Permissions That Signed Content Are Denied  
   Signed Java applets are denied these permissions.

9. Click the **Edit Permissions** tab. Select the option you need for more exact control over Java permissions for the zone. If you do not want to keep the settings that you have made, you can click the **Reset** button to reset permissions to:

   - Saved permissions
   - High Security
   - Medium Security
   - Low Security

10. Click **OK**, and then click **OK** again.

> [!NOTE]
> Use caution when you adjust Java permissions. Some Java-based programs may not work properly after you change permissions. Some changes to Java permissions can make your computer liable to security breaches by hackers. Microsoft recommends that you do not change the default permissions unless you have a specific purpose for doing so.
