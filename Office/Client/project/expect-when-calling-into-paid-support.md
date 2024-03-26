---
title: Project and Project Server Support Boundaries - What to Expect
description: Explain to customer's what they can expect when they call into paid support for Project and Project Server.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: petewi
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Project Online
  - Project Standard 2013
  - Project Professional 2013
  - Project Server 2013
  - Project Standard 2010
  - Project Professional 2010
  - Project Server 2010
  - Microsoft Office Project Server 2007
  - Project Online Desktop Client
ms.date: 03/31/2022
---
# Project and Project Server Support Boundaries - What to Expect

_Original KB number:_ &nbsp; 2844167

## Summary

The Technical Support Team is tasked with supporting our customers in break/fix scenarios. Meaning if you receive an error message or get unexpected results that you feel are incorrect per your understanding of how the product functions, the product appears to be broken and you need a fix. If you can't find the answer via one of our free resource options, then you can begin a support incident where a support engineer will work to find you the resolution to your issue.

Microsoft Support offers multiple options to customers for getting support. The following link describes the options and provides additional links to support: [https://support.microsoft.com/](https://support.microsoft.com/)

This article discusses specific support boundaries when it comes to paid Technical Support for Project and Project Server.

### SECTION 1: SETUP

The following examples are within guidelines for setup support:

- Assist in the installation of Project or Project Server as explained in the user documentation.
- Verify Setup, at least one user can log into Project and Project Server without error.
- Check distribution media integrity - copy files locally and test install from the local directory.

The following examples are beyond guidelines for setup support:

- Support installation on operating systems not listed on the box if the issue is determined to be operating system specific.
- Support modification of any Setup file or transcript for administered installations.
- Modification of system files such as `*.bat`, `*.sys`, `*.ini`, and `*.dat` files.

### SECTION 2: MACROs, VISUAL BASIC FOR APPLICATIONS (VBA) and Project Data Service (PDS) or Project Server Interface (PSI) coding

Customizations may not fall under the definition of a break/fix issue in many cases. However, the technical support team will work within our support boundaries to help you move forward if you run into issues. However, we may ask you to remove the customization and test to see if the problem persists so we can narrow down the problem. If we do find it is the customization causing the issue we will continue to work with you to determine if the problem is our documentation or a specific programming method that is not functioning as documented. We may need to ask you to isolate the problem down to a few lines of code (no more than 15 lines) that we can reproduce the issue with in order to continue troubleshooting.

Below are examples that are within guidelines for primary Macro/VBA and code support within Project and Project Server.

The support engineer will:

- Explain the syntax or parameters of any built-in VBA or macro command, including examining a problem line of code for correct syntax only.
- Determine if the problem you are experiencing is the result of a bug. Supply any documented workarounds. This does not include troubleshooting programming logic issues that cause a macro to function incorrectly.
- Describe functionality and features of the VBA Editing Environment including the object browser, macro recorder, Help files, debugging, and code management tools.
- Explain basic concepts involved in debugging VBA procedures such as stepping through macro code.
- Determine if the problem can be solved by an existing sample macro.
- Demonstrate how to use the macro recorder to automate simple tasks.
- Demonstrate how to disable Visual Basic for Applications.
- Create and describe up to 15 lines of code that are specific to your problem in a sample macro. This does not include editing or modifying an existing customer macro.

#### Developing customization using PDS or PSI

Understanding your goal - The support engineer will:

- Check so see if the goal can it be accomplished via the Users Interface.
- Test if the goal be accomplished with the ProjTool. The ProjTool code is publicly available in the [Project Server Software Developer Kit](https://msdn.microsoft.com/library/office/gg446880%28v=office.14%29)
- Narrow the problem to a specific method or function for testing. This is where we much need to ask you to isolate the issue before we can move forward.

Additional Developer Resources: [Project Developer Center](https://msdn.microsoft.com/office/aa905469.aspx)

The following examples are beyond guidelines for macro/VBA support (Except as noted above for OD support):

- Debugging customer code, including identifying logic errors.
- Syntax support for API calls is available through the appropriate Software Developer Kit (SDK)
- Write code specific to a customer's application.
- Create custom workarounds to known Bugs.
- Support undocumented commands or command usage.

### SECTION 3: ODBC/OLEDB (Project 2007 and 2010 only)

The following examples are within guidelines for ODBC/OLEDB support:

- Ensure that the ODBC/OLEDB driver is installed properly.
- Determine if the customer can connect with another tool, preferably a non-ODBC tool.
- Identify bugs related to ODBC/OLEDB drivers and connectivity.

The following Examples Are Beyond Guidelines for ODBC/OLEDB Support:

- Troubleshoot connection problems with non-Microsoft supplied ODBC drivers.
- Troubleshoot SQL syntax in ODBC connectivity.

## SECTION 4: INTERNET - WEB - SHAREPOINT

The following examples are within guidelines for Internet, Web, and SharePoint support:

- Demonstrate creation of a hyperlink field in a document.
- Verify that the customer can get to a generic URL (`https://www.microsoft.com`) by typing it in the address line of the customer's browser.
- Assist with installation of SharePoint Server Services. Including extending web sites, setting up configuration and content databases and running Configuration Wizards.
- Creating new web sites and extending them for use with SharePoint.

The following examples are beyond guidelines for Internet, Web, and SharePoint support:

- Troubleshoot problems where the customer modified the registry to create custom links.
- Troubleshoot any HTML or ASP that the customer creates or modifies.
- Troubleshoot the customer's Web server or Internet connection problems.

## SECTION 5: ADD-INS AND THIRD-PARTY

The following examples are within guidelines for Add-ins and Third-Party support:

- Check for known conflicts, bugs, or support contacts for any third-party add-ins.

The following examples are beyond guidelines for Add-ins and Third-Party support:

- All third-party items are supported by the vendor. Consult the application's help file for support contact information.

## More information

Project Server Programming help files can be founding the following location:

- [Project 2013 developer documentation](https://msdn.microsoft.com/library/office/ms512767(v=office.15))
- [Project 2010 SDK Documentation](https://msdn.microsoft.com/library/office/ms512767%28office.14%29)  
- [Project 2007 SDK](https://msdn.microsoft.com/library/office/ms512767%28office.12%29)
