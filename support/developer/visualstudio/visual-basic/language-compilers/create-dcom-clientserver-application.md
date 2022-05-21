---
title: Create a DCOM client server application
description: This article describes how to create, package, and deploy a Distributed Component Object Model (DCOM) client/server application by using Visual Basic.
ms.date: 10/12/2020
ms.custom: sap:Language or Compilers
ms.topic: how-to
---
# Create a DCOM Client/Server Application by Using Visual Basic

This article describes how to create, package, and deploy a Distributed Component Object Model (DCOM) client/server application by using Visual Basic.

_Original product version:_ &nbsp; Visual Basic  
_Original KB number:_ &nbsp; 266717

## Summary

This article shows you how to create, package, and deploy a DCOM client/server application by using Visual Basic. To create a DCOM client/server application, you need the Enterprise Edition of Visual Basic. Microsoft assumes that the reader is already familiar with creating client/server applications that run on the same computer.

## More information

You do not need to change your code to enable a client application to instantiate a remote server by using DCOM. The difference is the way in which you package and deploy the client. In addition, there are some security settings you need to make after the client and the server are installed. You can make these settings by using a utility called *Dcomcnfg*.

The following steps show you how to distribute and configure a client/server application. Name the server *DCOMDemo_Svr*, and name the client *DCOMDemo_Cli*. Create a separate folder for each of them. For the purpose of this article, call these folders `c:\DCOMDemo\Server and c:\DCOMDemo\Client`.

## Create the Server

1. Start a new **Visual Basic Project**. On the **New Project** dialog box, select **ActiveX EXE**, and then click **Open**. Class1 is created by default.

2. Add the following code to the Class1 module:

    ```vbnet
    Public Function ServerTime() As String
        ServerTime = Time
    End Function
    ```

3. On the **Project** menu, click the **Project Properties** option, and then select the **General** tab.
4. In the **Project Name** field, type in *DCOMDemo_Svr*.
5. On the **Project Description** field, type in *DCOMDemo_Svr - Server*. Check the **Unattended Execution** option.

    > [!NOTE]
    > This option should always be checked in servers that don't have any UI to assure that no dialog boxes of any type are displayed while the server is running. If you have any type of user interaction while your server is running under an identity that is not the Interactive User, your server may appear to hang.

6. Select the **Component** tab, and check the **Remote Server Files** option.

    > [!NOTE]
    > Checking this option makes the Visual Basic compiler generate the VBR and TLB files needed for packaging the client applications that use this server. These files contain registry entries that need to be included on the client computer.

7. Close the **Project Properties** dialog box.
8. On the **File** menu, select **Save As**, and then save this project to the `c:\DCOMDemo\Server folder`.
9. On the **File** menu, select **Make DCOMDemo_Svr** and compile the server.
10. On the **Project** menu, select the **Project Properties** option, and then select the **Component** tab.
11. On the **Component** tab, select **Version Compatibility**, select the **Binary Compatibility** option, and then make the project binary compatible with the server's executable file you created (DCOMDemo_Svr.exe). By selecting this option, you are assuring that all GUIDs are kept the same if you recompile the server.

## Create the Client

1. On the **File** menu, select the **New Project** option, select **Standard EXE**, and then click **OK**. Form1 is created by default.
2. On the **Project** menu, click the **Project Properties** option, and then select the **General** tab.
3. In the **Project Name** field, type in *DCOMDemo_Cli*.
4. In the **Project Description** field, type in *DCOMDemo_Cli Project - Client*.
5. On the **Project** menu, select **References**. From the list of available references, select **DCOMDemo_Svr - Server**.
6. Place a command button on Form1, and change the button's caption to **Run**.
7. Place the following code in the button's click event:

    ```vbnet
    Dim MyObj As DCOMDemo_Svr.Class1

    On Error GoTo err1

    Set MyObj = CreateObject("DCOMDemo_Svr.Class1")
    MsgBox "Server Time=" & MyObj.ServerTime & " Client Time=" & Time

    Exit Sub
    err1:
    MsgBox "Connection failed: Error " & Err.Number & " - " & Err.Description
    ```

8. On the **File** menu, select **Save As**, and then save the project to the client's folder `c:\DCOMDemo\Client`.
9. Press the **F5** key to run the client in the IDE and test it out.
10. On the **File** menu, select **Make DCOMDemo_Cli** to compile the client, and then close Visual Basic.

## Package the Server

Use the Package and Deployment Wizard to package your server for distribution as usual. The server is instantiated by a remote client using DCOM. While creating the package for your server, you get a dialog box asking you if this server will be used as a Remote Automation server and if you want to include support files for this purpose. Just click the **No** button, because DCOM is not Remote Automation. Remote Automation is an older technology that was replaced by DCOM.

## Package the Client

When packaging the client there are some specific steps that need to be taken, considering that the server does not run on the same computer as the client. The changes made to the client's package assure that just the type library (.tlb file) is installed and some additional registry entries are included instead of the server's executable, which is not necessary on the client's computer because it's not going to run there.

Package the client by using the following steps:

1. Start **Package and Deployment Wizard**, and then select the Client's project.
2. Click the **Package** button. In the **Package Type** dialog box, select **Standard Setup Package**, and then click **Next**.
3. In the **Package Folder** dialog box, select the folder to store the package, and then click **Next**. In this case, it is **c:\DCOMDemo\Client\Package**.

    > [!NOTE]
    > You may get a dialog box saying that there is no dependency information for the server. Click **OK** because this server doesn't have any dependencies.

   You should now be in the Included Files dialog box.

4. Deselect the server's executable file, DCOMDemo_Svr.exe, because you don't want to distribute the server's executable, and then click the Add button.
5. Change the Files of Type combo box to Remote Server Files (*.vbr).
6. Point to the folder where you have your Server's project (in this case `c:\DCOMDemo\Server`), and select the related VBR file, *DCOMDemo_Svr.VBR*. Click **Open**, and the **Add File** dialog box closes.

    > [!NOTE]
    > That two files are included, *DCOMDemo_Svr.VBR* and *DCOMDemo_Svr.TLB*. Click the **Next** button. In the **Remote Servers** dialog box you can define the name of the computer (Net Address) where the server is running. Usually you keep this field blank because you may not know in advance where the server will be installed. If you keep it blank, you are prompted for it when you install the client. For this sample, keep it blank.

7. Click **Next** to proceed. You can now proceed with the standard procedures for Package and Deployment Wizard. In this case, just click **Next** to all remaining dialog boxes.

## Install the Server

Install the server on the computer on which you would like to run it, using the distribution package you created earlier. If you want to use your development computer to run the server, you don't need to install it because Visual Basic makes the registration for you when it compiles the server.

## Install the Client

Install the Client on the computer on which you would like to run it, using the distribution package you created earlier. Because this client uses a DCOM server and you left the actual location of the server blank when you created the distribution package, you now need to provide this location. When Setup prompts you for this location, provide the name of the computer where you installed the server.

## Set the Server's Security

If you installed the server on a Windows NT or Windows 2000 computer, you need to configure security for it. Do this by using Dcomcnfg, as shown in the following steps, which assume that both client and server computers are part of a domain, and the user logged on to the client computer is logged on as a domain user. The suggested settings are just one possible configuration. They are generic and give wide access to the server. Remember that this is just an example. When you deploy your real applications, and security is a concern for your environment, you should select more restrictive options. Also, if the computer you are using to test this example server is used to run other servers, make a note of the current settings before you make the following changes, and return to the original settings as soon as you are done with your tests.

1. On the server computer, click the **Start** button, and then select **Run**. In the **Run** dialog box, type *Dcomcnfg*, and then click **OK**. You need to have Administrator rights to be able to run Dcomcnfg.
2. Select the **Default Properties** tab, and verify that Enable Distributed COM on this computer is checked.
3. Set the **Default Authentication Level** to **Connect**, and set the **Default Impersonation Level** to **Identify**.
4. Select the **Default Security** tab.
5. Click the **Edit Default** button in the **Default Access Permissions** panel.
6. Verify that Everyone and System are included in the list with Allow Access rights. If they are not, you can use the **Add** button to add them to the list. Click **OK** when the list is complete.
7. Click the **Edit Default** button in the **Default Launch Permissions** panel.
8. Verify that Everyone and System are included in the list with Allow Launch permissions. If they are not, use the **Add** button to add them to the list. Click **OK** when the list is complete.
9. Select the **Applications** tab, highlight your server, DCOMDemo_Svr.Class1, and then click the **Properties** button.
10. Select the **General** tab, set the **Authentication Level** to **Default**, and then select the **Location** tab. The only option that is checked should be Run application on this computer.
11. Select the **Security** tab and verify that the Use default access permissions and the Use default launch permissions options are checked.
12. Select the **Identity** tab, check the **launching user** option, click **OK** to close the Server's Properties dialog box, and then click **OK** again to close **Dcomcnfg**. As you can see, the test server uses all of the default settings. When deploying your own servers, you should define settings specific to your application. All custom settings take precedence over the default ones.

You are now ready to test your server. On the client computer, launch the client, and then click the **Run** button. You should see a message box indicating the server's time. If you are unable to test this sample successfully, please see the troubleshooting article, Q269330, listed in the "References" section.
