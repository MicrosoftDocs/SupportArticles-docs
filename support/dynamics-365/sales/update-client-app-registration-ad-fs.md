---
title: Update client app's registration in AD FS
description: This article describes updated mobile applications and additional Redirect URIs.
ms.reviewer: 
ms.topic: article
ms.date: 
---
# Update client app's registration in AD FS (CRM On-Premises)

This article describes updated mobile applications and additional Redirect URIs.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2015, Dynamics CRM 2016, Microsoft Dynamics CRM 2016 Service Pack 1  
_Original KB number:_ &nbsp; 3201236

## Summary

We have updated our mobile applications and additional Redirect URIs have been added. The following updated PowerShell command must be run in your AD FS server to register the tablet and phone apps:

```powershell
Add-AdfsClient -ClientId ce9f9f18-dd0c-473e-b9b2-47812435e20d -Name "Microsoft Dynamics CRM for tablets and phones" -RedirectUri ms-app://s-1-15-2-2572088110-3042588940-2540752943-3284303419-1153817965-2476348055-1136196650/, ms-app://s-1-15-2-1485522525-4007745683-1678507804-3543888355-3439506781-4236676907-2823480090/, ms-app://s-1-15-2-3781685839-595683736-4186486933-3776895550-3781372410-1732083807-672102751/, ms-app://s-1-15-2-3389625500-1882683294-3356428533-41441597-3367762655-213450099-2845559172/, ms-auth-dynamicsxrm://com.microsoft.dynamics,ms-auth-dynamicsxrm://com.microsoft.dynamics.iphone.moca,ms-auth-dynamicsxrm://com.microsoft.dynamics.ipad.good,msauth://code/ms-auth-dynamicsxrm%3A%2F%2Fcom.microsoft.dynamics,msauth://code/ms-auth-dynamicsxrm%3A%2F%2Fcom.microsoft.dynamics.iphone.moca,msauth://code/ms-auth-dynamicsxrm%3A%2F%2Fcom.microsoft.dynamics.ipad.good,msauth://com.microsoft.crm.crmtablet/v%2BXU%2FN%2FCMC1uRVXXA5ol43%2BT75s%3D,msauth://com.microsoft.crm.crmphone/v%2BXU%2FN%2FCMC1uRVXXA5ol43%2BT75s%3D, urn:ietf:wg:oauth:2.0:oob
```

## More information

You will get the following error if you don't run this updated PowerShell command.

> AADSTS50011: The reply address '[msauth URL]' does not match the reply addresses configured for the application: '{Client app ID, which is a GUID}'. More details: not specified.

Your users will encounter a Sign In error saying that **Sorry, but we're having trouble signing you in. We received a bad request**. when they tried to sign in after upgrading their devices.
