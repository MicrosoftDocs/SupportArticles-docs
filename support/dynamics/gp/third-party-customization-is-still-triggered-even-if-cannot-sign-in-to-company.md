---
title: Third-party customization is triggered even if cannot sign in
description: Describes a problem in which a third-party customization is still triggered although a user is unable to sign in to the company in Microsoft Dynamics GP. A resolution is provided.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# A third-party customization is still triggered even if a user cannot sign in to the company in Microsoft Dynamics GP

This article provides a resolution for the issue that a third-party customization is still triggered even if a user cannot sign in to the company in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 943959

## Symptoms

When a user selects **OK** in the Company Login window in Microsoft Dynamics GP, the user cannot sign in to the company. However, a third-party customization is still triggered. For example, if a company is already logged on to, users cannot log on to the company. However, a trigger can unexpectedly access tables in the company database.

> [!NOTE]
> If you are a developer, you can register the trigger after you change the OK Button script for the Switch Company window of the Switch Company form.

## Resolution

To resolve this problem, use the following global procedures in the script:

- Add_Successful_Login_Record
- Add_Successful_Logout_Record

For example, you can use both global procedures in the following script:

```console
pragma(disable warning LiteralStringUsed);
{ Log in and Log out Triggers }
if Trigger_RegisterProcedure(script 'Add_Successful_Login_Record', TRIGGER_AFTER_ORIGINAL, script Set_Environment) <> SY_NOERR then
warning "Log on procedure trigger registration failed.";
end if;
if Trigger_RegisterProcedure(script 'Add_Successful_Logout_Record', TRIGGER_AFTER_ORIGINAL, script Set_Environment_POST) <> SY_NOERR then
warning "Log off procedure trigger registration failed.";
end if;
pragma(enable warning LiteralStringUsed);
```
