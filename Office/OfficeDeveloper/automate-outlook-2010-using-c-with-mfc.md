---
title: How to automate Outlook 2010 by using C++ in Visual Studio 2010 with MFC
description: Discusses how to automate Outlook 2010 by using C++ in Visual Studio 2010 together with MFC.
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# How to automate Outlook 2010 by using C++ in Visual Studio 2010 together with MFC

## Summary

This article contains a step-by-step example of how to create a Microsoft Visual Studio 2010 application that automates Microsoft Outlook 2010 and uses C++ together with Microsoft Foundation Classes (MFC).

## More Information

This article describes how to create a Visual Studio 2010 project that automates Outlook to do the following:

- Create and save a contact   
- Create and save an appointment   
- Create and send a mail message   

Although you can implement all the following sections, you can also omit one or two of these sections so that only one or two kinds of items are created.

> [!NOTE]
> All the following code examples assume file paths that are for a 32-bit operating system. Make sure that you make any necessary changes to the path so that they are valid for your particular operating system and configuration. Also, the code creates Outlook items that have fictitious information, and this includes a fictitious email address. Make sure that you change the email address to one of your valid email addresses for testing.

### Step 1: Create the Project

1. Start Visual Studio 2010.   
2. Click **File**, click **New**, and then click **Project**. In the list of installed templates, expand **C++**, select **MFC**, and then select **MFC Application** project. Name the project as **AutomateOutlookWithMFC**, and then click **OK**.   
3. When the MFC Application Wizard starts, click **Next**.   
4. Leave the settings in the MFC Application Wizard at the default values except in the **Application Type** section. In this section, select **Dialog based**.   
5. Click **Finish** to complete the MFC Application Wizard.   

### Step 2: Include Microsoft Office 14.0 Object Library

1. In the Solution Explorer window, open the stdafx.h file.   
2. At the end of the file, add the following line. Make sure that the path is appropriate for your particular operating system and configuration:
    ```c
    #import "C:\\Program Files\\Common Files\\microsoft shared\\OFFICE14\\mso.dll" no_namespace rename("RGB", "MsoRGB") exclude("IAccessible")
    ```

    **Note** This line directs MIDL to create the header file without the IAccessible interface to avoid potential redefinition errors. Every class file needs this reference. Therefore, it is included in the stdafx.h header file.

### Step 3: Create Outlook's Application object

1. In the Solution Explorer window, select the **AutomateOutlookWithMFCDlg.cpp** file.   
2. Click the **Project** menu, and then click **Class Wizard**.   
3. Click the down arrow on the **Add Class** button, and then click **MFC Class From TypeLib**.   
4. Under **Available type libraries**, select **Microsoft Outlook 14.0 Object Library.**   
5. In the **Interfaces** list box, click **_Application**.   
6. Click the right-arrow button to add **_Application** to the list of **Generated classes**.   
7. Click **Finish** to generate the class, and then click **OK** to close the Class Wizard.   
8. Open the newly created header file, **CApplication.h**. Locate this line:
    ```c
    #import "C:\\Program Files\\Microsoft Office\\Office14\\msoutl.olb" no_namespace
    ```

9. Replace the line that you located in step 8 with the following:
    ```c
    #import "C:\\Program Files\\Microsoft Office\\Office14\\msoutl.olb" no_namespace rename("Folder", "OlkFolder") rename("CopyFile", "OlkCopyFile") rename("GetOrganizer", "GetOrganizerAE")
    ```

10. Open the **AutomateOutlookWithMFCDlg.cpp** file, and then add the following to the list of #include statements:
    ```c
    #include "CApplication.h"
    ```

### Step 4: Add a button to the project

1. Switch to the dialog box.   
2. Use the Control Toolbox to add a button to the dialog box.   
3. To add a handler for the button, double-click the button, and locate this line: 
    ```c
    // TODO: Add your control notification handler code here
    ```

4. Replace the line that you located in step 3 with the following code:
    ```c
    CApplication olApp;
    COleException e;
    if (!olApp.CreateDispatch(_T("Outlook.Application"), &e))
    {
    CString strErr;
    strErr.Format(_T("CreateDispatch() failed w/error 0x%08lx"), e.m_sc);
    AfxMessageBox(strErr, MB_SETFOREGROUND);
    return;
    }
    ```

### Step 5: Create Outlook's Namespace object

1. In the **Project** menu, click **Class Wizard**.   
2. Click the down arrow on the **Add Class** button, and then click **MFC Class From Typelib**.   
3. Under **Available type libraries**, select **Microsoft Outlook 14.0 Object Library**.   
4. In the **Interfaces** list box, click **_Namespace**.   
5. Click the right-arrow button to add **_Namespace** to the list of **Generated classes**.   
6. Click **Finish** to generate the class, and then click **OK** to close the Class Wizard.   
7. Open the newly created header file, **CNamespace.h**. Locate this line:
    ```c
    #import "C:\\Program Files\\Microsoft Office\\Office14\\msoutl.olb" no_namespace
    ```

8. Replace the line that you located in step 7 with the following:
    ```c
    #import "C:\\Program Files\\Microsoft Office\\Office14\\msoutl.olb" no_namespace rename("Folder", "OlkFolder") rename("CopyFile", "OlkCopyFile") rename("GetOrganizer", "GetOrganizerAE")
    ```

9. Switch to the **AutomateOutlookWithMFCDlg.cpp** file, and add the following to the list of #include statements:
    ```c
    #include "CNamespace.h"
    ```

10. In the AutomateOutlookWithMFCDlg::OnBnClickedButton1() function (the button handler code), add this code after the last line:

    ```c
    // Logon. Doesn't hurt if you are already running and logged on... 
    CNameSpace olNs(olApp.GetNamespace(_T("MAPI")));
    COleVariant covOptional((long)DISP_E_PARAMNOTFOUND, VT_ERROR);
    olNs.Logon(covOptional, covOptional, covOptional, covOptional);
    ```

### Step 6: Create and save a ContactItem

1. In the **Project** menu, click **Class Wizard**.   
2. Click the down arrow on the **Add Class** button, and then click **MFC Class From Typelib**.   
3. Under **Available type libraries**, select **Microsoft Outlook 14.0 Object Library**.   
4. In the **Interfaces** list box, click **_ContactItem**.   
5. Click the right-arrow button to add **_ContactItem** to the list of **Generated classes**.   
6. Click **Finish** to generate the class, and then click **OK** to close the Class Wizard.   
7. Open the newly created header file, CContactItem.h. Locate this line:
    ```c
    #import "C:\\Program Files\\Microsoft Office\\Office14\\msoutl.olb" no_namespace
    ```

8. Replace the line that you located in step 7 with the following:
    ```c
    #import "C:\\Program Files\\Microsoft Office\\Office14\\msoutl.olb" no_namespace rename("Folder", "OlkFolder") rename("CopyFile", "OlkCopyFile") rename("GetOrganizer", "GetOrganizerAE")
    ```

9. Switch to the **AutomateOutlookWithMFCDlg.cpp** file, and then add the following to the list of #include statements:
    ```c
    #include "CContactItem.h"
    ```

10. In the AutomateOutlookWithMFCDlg::OnBnClickedButton1() function (the button handler code), add this code after the last line:

    ```c
    // Create and open a new contact
    CContactItem olContactItem(olApp.CreateItem(olContactItem));
    
    olContactItem.put_FullName(_T("John Doe"));
    COleDateTime bdDate;
    bdDate.SetDate(1975, 9, 15);
    olContactItem.put_Birthday(bdDate);
    olContactItem.put_CompanyName(_T("Microsoft"));
    olContactItem.put_HomeTelephoneNumber(_T("KL5-555-1234"));
    olContactItem.put_Email1Address(_T("john.doe@microsoft.com"));
    olContactItem.put_HomeAddress(_T("123 Main Street.\nAnytown, WA 12345"));
    
    // Save the contact
    olContactItem.Save();
    ```

### Step 7: Create and save an AppointmentItem

1. In the **Project** menu, click **Class Wizard**.   
2. Click the down arrow on the **Add Class** button, and then click **MFC Class From Typelib**.   
3. Under **Available type libraries**, select **Microsoft Outlook 14.0 Object Library**.   
4. In the **Interfaces** list box, click **_AppointmentItem**.   
5. Click the right-arrow button to add **_AppointmentItem** to the list of **Generated classes**.   
6. Click **Finish** to generate the class, and then click **OK** to close the Class Wizard.   
7. Open the newly created header file, **CAppointmentItem.h**. Locate this line:
    ```c
    #import "C:\\Program Files\\Microsoft Office\\Office14\\msoutl.olb" no_namespace
    ```

8. Replace the line that you located in step 7 with the following:
    ```c
    #import "C:\\Program Files\\Microsoft Office\\Office14\\msoutl.olb" no_namespace rename("Folder", "OlkFolder") rename("CopyFile", "OlkCopyFile") rename("GetOrganizer", "GetOrganizerAE")
    ```

9. Switch to the **AutomateOutlookWithMFCDlg.cpp** file, and add the following to the list of #include statements:
    ```c
    #include "CAppointmentItem.h"
    ```

10. In the AutomateOutlookWithMFCDlg::OnBnClickedButton1() function (the button handler code), add this code after the last line:

    ```c
    // Create a new appointment
    CAppointmentItem olApptItem(olApp.CreateItem(olAppointmentItem));
    
    COleDateTime apptDate = COleDateTime::GetCurrentTime();
    // Set the Start time to occur 2 minutes from now
    apptDate += DATE(2.0/(24.0*60.0));
    
    olApptItem.put_Start(apptDate);
    
    // Set the duration to be 1 hour
    olApptItem.put_Duration(60);
    
    // Set other appointment info
    olApptItem.put_Subject(_T("Meeting discuss plans"));
    olApptItem.put_Body(_T("Meeting with John to discuss plans"));
    olApptItem.put_ReminderMinutesBeforeStart(1);
    olApptItem.put_ReminderSet(TRUE);
    
    // Save Apptointment
    olApptItem.Save();
    
    ```

### Step 8: Create and save a MailItem

1. In the **Project** menu, click **Class Wizard**.   
2. Click the down arrow on the **Add Class** button, and then click **MFC Class From Typelib**.   
3. Under **Available type libraries**, select **Microsoft Outlook 14.0 Object Library**.   
4. In the **Interfaces** list box, click **_MailItem**.   
5. Click the right-arrow button to add **_MailItem** to the list of **Generated classes**.   
6. Click **Finish** to generate the class, and then click **OK** to close the Class Wizard.   
7. Open the newly created header file, **CMailItem.h**. Locate this line:
    ```c
    #import "C:\\Program Files\\Microsoft Office\\Office14\\msoutl.olb" no_namespace
    ```

8. Replace the line that you located in step 7 with the following:
    ```c
    #import "C:\\Program Files\\Microsoft Office\\Office14\\msoutl.olb" no_namespace rename("Folder", "OlkFolder") rename("CopyFile", "OlkCopyFile") rename("GetOrganizer", "GetOrganizerAE")
    ```

9. Switch to the **AutomateOutlookWithMFCDlg.cpp** file, and add the following to the list of #include statements:
    ```c
    #include "CMailItem.h"
    ```

10. In the AutomateOutlookWithMFCDlg::OnBnClickedButton1() function (the button handler code), add this code after the last line:

    ```c
    // Prepare a new mail message
    CMailItem olMailItem(olApp.CreateItem(olMailItem));
    olMailItem.put_To(_T("john.doe@microsoft.com"));
    olMailItem.put_Subject(_T("About our meeting..."));
    olMailItem.put_Body(
    _T("Hi John,\n\n")
    _T("\tI'll see you in two minutes for our meeting!\n\n")
    _T("btw: I've added you to my contact list!"));
    
    // Send the message
    olMailItem.Send();
    
    AfxMessageBox(_T("All done."), MB_SETFOREGROUND);
    
    ```

### Step 9: Implement the code to log off
In the **AutomateOutlookWithMFCDlg.cpp** file, add the following code at the end of the button handler code:
    
```c
olNs.Logoff();
```

### Step 10: Compile and run the project

1. On the **Build** menu, click **Build Solution**. Make sure that there are no build errors.   
2. Compile and run the code. It should create and save a contact and appointment and then create and send a new email message.   

### Additional Notes

Three methods are being renamed to avoid potential conflicts when compiling. Although the Folder and CopyFile methods generate warnings, the GetOrganizer method will prevent the project from compiling. 

The _Appointment::GetOrganizer method returns an AddressEntry and was renamed to _Appointment::GetOrganizerAE. We renamed this method because _Appointment::Organizer is a property on the same interface, and the duplication causes a conflict. In this case, MIDL creates a helper function for the _Appointment::Organizer property that is called _Appointment::GetOrganizer. Therefore, the helper function becomes an overloaded method that returns different types (for example, BSTR* versus AddressEntry*). Overloaded methods that differ only by the return type are not permitted.