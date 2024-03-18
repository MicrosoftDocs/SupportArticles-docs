---
title: Disable contextual tips in Skype for Business 2016
description: Discusses how to disable contextual tips in Skype for Business 2016. Although these tips display helpful suggestions about program features for users, you may want to turn them off.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business 2016
ms.date: 03/31/2022
---

# How to disable contextual tips in Skype for Business 2016

## Summary

Microsoft Skype for Business 2016 users see a new feature that's known as contextual tips. These tips appear in a pop-up window to describe program features that are relevant to the current task. Contextual tips are helpful suggestions that encourage you to try Skype for Business features that you might not have used before.

For a description of contextual tips, see the following Microsoft Office article:

[What's New in Skype For Business 2016](https://support.office.com/article/what-s-new-in-skype-for-business-2016-cece9f93-add1-4d93-9a38-56cc598e5781)

To dismiss the tip, click the **X** character at the top of the tip window. After you close the window, the tip will not display again. However, in some environments, you may want to disable contextual tips for through a client policy.

## More Information

To disable the contextual tips feature, you can use Skype for Business or Lync Server PowerShell. To do this, use the following code to run the Set-CsClientPolicy PowerShell cmdlet:

**To set the policy for all users:**

```powershell
$a = New-CsClientPolicyEntry –Name "EnableContextualMessages" –Value $False

Set-CsClientPolicy –Identity Global –PolicyEntry @{Add=$a}
```

**To set for specific users:**

```powershell
$a = New-CsClientPolicyEntry –Name "EnableContextualMessages" –Value $False
New-CsCLientPolicy -Identity NoContextualMessages

Set-CsClientPolicy –Identity NoContextualMessages–PolicyEntry @{Add=$a}
Grant-CsClientPolicy -Identity userX
```

Users must sign out and back in to the Skype for Business client for the change to take effect.

You can verify in the uccapi logs of the client that the new policy is populated to the client. To do this, run the following search:

```adoc
<propertyEntryList>

<property name="EnableContextualMessages" >False</property>
```

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
