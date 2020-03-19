---
title: Profile cannot be deleted after signing out IE
description: Provides a workaround to solve the issue that roaming profiles does not work even though you have configured.
ms.date: 03/16/2020
ms.prod-support-area-path: Internet Explorer
ms.reviewer: heikom
---
# Enabling Deploy default Accelerators causes profile data to not be deleted at signing out

This article describes an issue that profile data cannot be deleted after a user signs out even if you have enabled the Deploy Default Accelerators policy in Internet Explorer 8.

_Original product version:_ &nbsp; Internet Explorer 8  
_Original KB number:_ &nbsp; 2485866

## Symptoms

You have configured roaming profiles in Internet Explorer 8, which you expect should be deleted after a user signs out.

When you enable the Deploy Default Accelerators policy, the Accelerators are deployed, but when a user signs out, the profile cannot be unloaded completely.

## Cause

When the Accelerator is deployed it typically includes a path for its icon-file for the given server, for example `http://www.bing.com/favicon.ico`. During the deployment, this icon-file is downloaded within winlogon.exe. The download itself initiates open file handles to Cookies, Temporary Internet Files, and History. These handles will stay open when the user signs out, and therefore winlogon.exe cannot remove the profile completely.

## Resolution

Download the icon-file manually and store it on a file server. Then, edit the XML file of the Accelerator and change the location in the \<icon>-tag to point to the file share.

Following is an example with the Accelerator of Bing Maps:

This is the section of the original Accelerator that you plan to deploy, and which you have saved to a UNC location, for example, \\server\share\accelerator\bing-maps.xml:

```html
<display>
 <name>Bing Maps</name>
 <icon>http://www.bing.com/favicon.ico</icon>
</display>
```

1. Download `http://www.bing.com/favicon.ico` and save it to \\server\share\accelerator\bing.ico.
2. Modify your accelerator file accordingly:

   ```html
   <icon>\\server\share\accelerator\bing.ico</icon>
   ```
