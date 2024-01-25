---
title: ClickOnce apps fail to install or launch
description: When the ampersand special character is used within the folder structure of the published ClickOnce application, the installation and launching will fail. You'll receive the Application cannot be started error and the Value does not fall within the expected range log.
ms.date: 05/06/2020
ms.custom: sap:Installation
---
# ClickOnce installation fails with the Application cannot be started error message

This article helps you resolve the **Application cannot be started** error when you install and launch a published ClickOnce application.

_Original product version:_ &nbsp; Microsoft .NET Framework 3.5 Service Pack 1  
_Original KB number:_ &nbsp; 2647493

## Symptoms

A ClickOnce application can be published successfully. However when you attempt to install and launch, you see the following error message and log:

- Error message:

    > Cannot Start Application  
    > Application cannot be started. Contact the application vendor.

- Log snippet:

    > ERROR SUMMARY  
    > Below is a summary of the errors, details of these errors are listed later in the log.  
    > An exception occurred while determining trust. Following failure messages were detected:  
    > Value does not fall within the expected range.

## Cause

When the ampersand special character is used within the folder structure of the published ClickOnce application, the installation and launching will fail. Other special characters such as the backslash (\), slash (/), question mark (?), asterisk (*), less than sign (<) and greater than sign (>) are blocked by the operating system. Others such as the plus sign (+), back quote (`), semicolon (;), brace left ({), bracket left ([), brace right (}), bracket right (]), number sign (#), exclamation point (!), at sign (@), dollar sign ($), percent (%), caret (^), opening or closing parenthesis can be used successfully. However it's always advisable not to use any special characters in file or folder names.

## Resolution

Avoid using the ampersand (&) special character in the folder names for ClickOnce published locations.
