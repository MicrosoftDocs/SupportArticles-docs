---
title: Cannot access new fields from an alternate window
description: When you create alternate forms in Dexterity, you can refer to new fields that are added to the windows. This article describes how to prevent the error message when you refer to the new fields that are added to the windows.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# "Illegal Address for field 'field name' in script 'script name'" error when you access new fields from an alternate window

This article provides methods to solve the error **Illegal Address for field 'field name' in script 'script name'** that may occur when accessing new fields from an alternate window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 941327

## Symptoms

When you create alternate forms in Dexterity for Microsoft Dynamics GP or for Microsoft Business Solutions - Great Plains, you can refer to new fields that are added to the windows. However, if you try to access the new fields, and the alternate window is not being used, you will receive the following error message:

> Illegal Address for field **field name** in script **script name**

> [!NOTE]
> The *field name* placeholder represents the name of the field. The *script name* placeholder represents the name of the script.

This article describes how to prevent this error message when you refer to the new fields that are added to the windows.

## Workaround

This problem occurs if security is not granted to the alternate form. To prevent the error message, use one of the following methods.

### Method 1 - Use exception handling

You can use exception handling in Dexterity to prevent the error message that is mentioned in the Symptoms section. If you use this method, the exception is caught if security is not granted to the alternate form. This method is the easiest method of preventing this problem.

The following code is an example of a trigger handling script.

```console
{Script Example_Trigger_Handling_Script}

{Start the exception handling block.}
try
{Try to set the value of the custom field in the SOP Entry window.}
'MyField' of window SOP_Entry of form SOP_Entry = 1;

{Catch "Illegal Address" errors. Do not display a message because this result is expected if security is
not granted.}
catch [EXCEPTION_CLASS_SCRIPT_ADDRESSING]

else
{A different error occurred. Rethrow the exception to display the error message to the user.}
throw;

end if;
```

### Method 2 - Check for security access to the alternate form before you access the custom data

This method is used to verify access to the alternate form when you access the custom fields in the window. You can use a `Check_Security_Alternate` function to verify access to the alternate form. The following code is an example of a `Check_Security_Alternate` function.

```console
{Function Check_Security_Alternate}

function returns boolean Check_Security_Alternate;

in string FormTechnicalName;
optional in boolean CheckForTestMode = false;

local integer requestdictid,DictionaryID;
local integer has_access,FormResID;

{Obtain the Resource ID for the requested form.}
FormResID = Resource_GetID(DYNAMICS,FORMTYPE,FormTechnicalName);

{Set the requestdictid value to 0 to check access to the base Microsoft Dynamics GP form.}
requestdictid = DYNAMICS; 

{Set the product Dictionary ID to the current dictionary context.}
DictionaryID = Runtime_GetCurrentProductID();

{
If the user has access to the form, and the returned Dictionary ID
is the ID that is passed into the procedure, the user has access to the alternate form.

The Security function call is aware that Integration Manager is running. Therefore, if Integration Manager runs 
an integration, this function uses DYNAMICS as the requestdictid value. Therefore, the function should return a false value.

The checks in this section also work for the Dexterity test mode, because the Runtime_GetCurrentProductID 
function call returns a value of 0 in the test mode. Therefore, if security is set to an alternate window in the test
mode, the Microsoft Dynamics GP window will not open. However, if you use the optional "CheckForTestMode = true" parameter, 
the function will return a value of true if the user has access to the original form and is in the Dexterity test mode.
}

has_access = Security(requestdictid,FORMTYPE,FormResID);

if ( has_access = OKAY ) and (((requestdictid = DictionaryID) or 
((CheckForTestMode = true) and isTestMode() of form LibSystem ))) then
Check_Security_Alternate = true;
else
Check_Security_Alternate = false;
end if;
```

The trigger handling script can call the security function. The trigger handling script can also determine whether the custom fields can be accessed in the alternate window. The easiest method is to call this function every time that the trigger handling script is run. However, for performance reasons, you can check security access as soon as the form opens. Then, you can create a global Boolean variable for each alternate window. To do this, add `Before FORM_PRE` triggers to all the forms, as shown in the following example. In this example, the alternate window is the SOP Entry window.

```console
{ FORM PRE trigger 
The SOP Entry Alternate global variable is a new Boolean global variable that is created by the developer to track 
access to the alternate form.} 
'SOP Entry Alternate' of globals = Check_Security_Alternate(technicalname(form 'SOP Entry')); 
```

Then, in all the trigger scripts for the alternate window, add the following code at the top of the script.

```console
if not 'SOP Entry Alternate' of globals then 
abort script; 
end if;
```
