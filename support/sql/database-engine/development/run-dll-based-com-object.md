---
title: Run a DLL-based COM object
description: This article describes how to run a DLL-based COM object outside the SQL Server process.
ms.date: 09/25/2020
ms.custom: sap:Administration and Management
ms.topic: how-to
---
# Run a DLL-based COM object outside the SQL Server process

This article describes how to run a DLL-based COM object outside the SQL Server process.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 198891

## Summary

Microsoft SQL Server provides the capability to load and run custom Component Object Model (COM) objects through a set of OLE Automation stored procedures or through extended stored procedures. By default, DLL-based COM objects are loaded as in process server, which means that the COM objects are not only loaded within the SQL Server process memory address space, but they also have full access to this memory address space. Therefore, a COM object loaded in the SQL Server process space must adhere to the same rules as any DLL file. There is a potential that a COM object could overwrite memory within the SQL Server process or leak resources, causing instability.

If there is suspicion that a COM object may be affecting the robustness of the SQL Server process, you may want to use the steps in this article to instantiate the COM object outside the SQL Server process space. Implementation of the Distributed Component Object Model's (DCOM) specification of Location Transparency into the operating system has provided the ability to run a DLL-based COM object outside the SQL Server process space.

The process of running a DLL-based COM object outside of the address space of the main application is called remoting. Remoting requires that another executable be a surrogate process in place of the SQL Server executable. The default executable used by the DCOM Service Control Manager (*rpcss.exe*) is named *dllhost.exe*. The DCOM support structure uses the *dllhost.exe* file to load the DLL into its process space and then uses proxy/stub pairs to marshal the requested interface transparently back to the client, which in this case is the SQL Server. This executable can accept multiple interface/method requests concurrently. After the interface use is complete, the DCOM Service Control Manager (SCM) manages the cleanup and unloading of the *dllhost.exe* file. COM objects should not be expected to retain state information in between instantiations.

The following steps can apply to any DLL-based COM object that is being created in the SQL Server process space, whether it is being instantiated through `sp_OACreate` or an extended stored procedure.

## More information

Information about the two basic methods that you can use to instantiate the COM object out of process follows.

## COM client requests remoting of the object

By changing the way that you invoke the COM object, you can request that the object be created outside of the SQL Server address space.

- If the COM object is loaded by using the `sp_OACreate` procedure, by default it is loaded in process. However, there is an optional third parameter to this procedure that may you can use to indicate the context of where to create the object. If this parameter is not specified, the default setting of five (5) is used, which means to run the object either inside or outside of the process. You need to change the parameter to four (4), which indicates to DCOM that this component is to run as a local executable. Use syntax that is similar to the following example to explicitly inform DCOM to run the COM object **out of process** using the `sp_OACreate` stored procedure:

    ```sql
    DECLARE @object int
    DECLARE @hr int
    EXEC @hr = sp_OACreate 'SQLOLE.SQLServer', @object OUT, 4
    ```

- If the COM object is created within an extended stored procedure the third parameter of `CoCreateInstance` or `CoCreateInstanceEx` can be changed to `CLSCTX_LOCAL_SERVER`. This is shown in the following code sample using `CoCreateInstance`:

    ```sql
    HRESULT hr = CoCreateInstance(CLSID_Test, NULL, CLSCTX_LOCAL_SERVER,
    IID_IUnknown, (void**)&piunknown);
    ```

## Modify registry to force remoting of the object

If you can't modify the COM client to request that the object be created out of process, two different methods exist to force the object to be created out of process.

- Use the OLE/COM Object viewer (*oleview.exe*) that's shipped with Visual C++ and locate the ProgID in the form of `OLEComponent.Object` under **All Objects**. Select the COM object, and then from the **Object** menu, select `CoCreateInstance` Flags. Make sure that only `CLSCTX_LOCAL_SERVER` is selected. Next, under the **Implementation** and **Inproc Server** tabs, select **Use Surrogate Process** and leave the **Path to Custom Surrogate** blank, which allows the *dllhost.exe* file to be loaded and the COM DLL brought within its process space.

- Use the following steps to manually update the registry.

    > [!WARNING]
    > Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall your operating system. Microsoft can't guarantee that these problems can be solved. Modify the registry at your own risk.

    1. Obtain the Class Identifier (CLSID) of the COM object. The CLSID is a 128-bit number and considered a Globally Unique Identifier (GUID) that's used to uniquely identify the component, module, or file that contains this COM object. When creating COM objects using the OLE Automation stored procedures, the first parameter to the stored procedure is a programmatic identifier or the ProgID of the OLE object is used to derive the CLSID. This character string describes the class of the OLE object and has the following form:

        ```sql
        OLEComponent.Object
        ```

    2. You can use the programmatic identifier to find the class identifier for a COM object.

        Open the Registry Editor (*regedit.exe*) and under the `HKEY_CLASSES_ROOT` key use the `Find` method to locate a key with the name of your <OLEComponent.Object>. You will find it at other levels, but it should be located at the level directly under the `HKEY_CLASSES_ROOT`. After you locate the key, expand the folder for the key name and you should see a subkey named CLSID. Select that folder to see the values within that key. On the right-hand side of the screen is a title named Default. The data for that key should be in the following form:

        `{59F929A0-74D8-11D2-8CBC-08005A390B09}`

        Make a note of this value or copy it to Notepad. Include the brackets.

    3. Navigate under the `HKEY_CLASSES_ROOT\CLSID` key and find the subkey with this GUID number. After you highlight the `HKEY_CLASSES_ROOT\CLSID` key, you can use the Find function in Registry Editor (under the **Edit** menu) and paste the GUID into the **Find** dialog box. Make sure that you have found the proper interface by inspecting the InprocServer32 subkey under this key, which points to the location of your COM DLL file. If there is a TypeLib key, check this GUID value. This should be different than what you noted in step 1. Otherwise, you have the TypeLib GUID and not the GUID for the COM object. The ProgID subkey will have a value of `OLEComponent.Object.1`. The one on the end is for this sample only and is used for versioning information.

    4. While under the GUID's InprocServer32 subkey, make sure that a `ThreadingModel` value exists and that it is set to either Both or Free to make sure the marshaling understands the threading model of the COM object to enable execution of COM out of SQL Server process space. If there isn't a `ThreadingModel` value or it's set to Apartment, COM object instantiation may not be consistent.

        > [!NOTE]
        > If you add the `ThreadingModel` value, make sure that you test your COM object before implementing.

    5. Highlight the GUID number/subkey under the `HKEY_CLASSES_ROOT\CLSID` key. From the **Edit** menu, select **New**, and then select **String Value**. Under the **Name** column, type *AppID*.

    6. Press <kbd>ENTER</kbd> and then insert the class identifier or GUID number you noted from step 1 as the value. The GUID should be inside the curly brackets as in the following example:

        ```sql
        {59F929A0-74D8-11D2-8CBC-08005A390B09}
        ```

       The application identifier AppID is used by DCOM to associate the DLL with an executable file.

    7. Add a new subkey under the `HKEY_CLASSES_ROOT\AppID` and set its name to the same class identifier or GUID number with the brackets as inserted in the preceding step.

    8. Highlight the GUID name. From the **Edit** menu, select **New**, and then select **String Value**. Under the **Name** column, type *dllSurrogate*.

       Leave the Data column blank for this value. Because the data column is blank, this informs DCOM to run the default executable file, *dllhost.exe*, and load the COM object within its process space.

    9. Close the Registry Editor. Click **Start**, and then select **Run**. In the **Run** dialog box, type *DCOMCNFG*.

       Press the **ENTER** key to open the **Distributed COM Configuration Properties** dialog box. Click the **Default Properties** tab, and make sure that **Enable Distributed COM** on this computer is selected. If it is not, select it, and then select **Apply**.

    10. Make sure that the Windows NT user account that SQL Server is running under has **Full Control** permission on the registry keys for this object. If the permissions aren't sufficient or the registry keys are input incorrectly, the following errors may occur when you're creating the COM object:

        > OLE Automation Error Information  
        HRESULT: 0x80040154  
        Source: ODSOLE Extended Procedure  
        Description: Class not registered  
        >
        > OLE Automation Error Information  
        HRESULT: 0x80070005  
        Source: ODSOLE Extended Procedure  
        Description: Access is denied.
        >
        > OLE Automation Error Information  
        HRESULT: 0x80080005  
        Source: ODSOLE Extended Procedure  
        Description: Server execution failed

    11. Test and see if this is running the *dllhost.exe* file and loading the COM object in its process space. This requires that the Windows NT Resource Kit is on the Windows NT computer on which SQL Server is running. Open a command prompt and from the command prompt run the *tlist.exe* file, which shows all the processes and their associated process identifiers, or Process Identifiers (PIDs). In the Transact-SQL script where `sp_OACreate` is run and after that call is executed, but before the script ends, use the following to delay the script completion for an additional 20 seconds:

        ```sql
        WAITFOR DELAY '000:00:20'
        ```

        Run the script and immediately navigate to the command prompt and run the *tlist.exe* file. Note the *dllhost.exe* PID. Rerun *tlist.exe* and pass the PID as a parameter. This shows the DLLs that are loaded within the *dllhost.exe* process space. The DLL-based COM object should be listed as running within this process. After the script returns, running *tlist.exe* again reveals that the *dllhost.exe* process is no longer running.

        In the following sample output, the ADODB. Connection object is created outside of the SQL Server process space. This snapshot using *tlist.exe* was performed while the COM object existed in the *dllhost.exe* process space. Notice that the module *msado15.dll*, which is the module that contains the COM object, is loaded.

        ```console
        C:\>tlist dllhost
        275 dllhost.exe
        CWD: C:\NT40\system32\
        CmdLine: C:\NT40\System32\dllhost.exe {00000514-0000-0010-8000-00AA006D2EA4}
        -Embedding
        VirtualSize: 19180 KB PeakVirtualSize: 19180 KB WorkingSetSize: 1780 KB
        PeakWorkingSetSize: 1780 KB
        NumberOfThreads: 3
        278 Win32StartAddr:0x01001920 LastErr:0x00000000 State:Waiting
        215 Win32StartAddr:0x00001b5e LastErr:0x00000000 State:Waiting
        253 Win32StartAddr:0x00001b60 LastErr:0x000000cb State:Waiting
        4.0.1381.105 shp 0x01000000 dllhost.exe
        4.0.1381.130 shp 0x77f60000 ntdll.dll
        4.0.1381.121 shp 0x77dc0000 ADVAPI32.dll
        4.0.1381.133 shp 0x77f00000 KERNEL32.dll
        4.0.1381.133 shp 0x77e70000 USER32.dll
        4.0.1381.115 shp 0x77ed0000 GDI32.dll
        4.0.1381.131 shp 0x77e10000 RPCRT4.dll
        4.0.1381.117 shp 0x77b20000 ole32.dll
          6.0.8267.0 shp 0x78000000 MSVCRT.dll
                         0x1f310000 msado15.dll
         2.30.4265.1 shp 0x766f0000 OLEAUT32.dll
         4.0.1381.72 shp 0x77bf0000 rpcltc1.dll
        ```

## References

[OLE Automation Stored Procedures (Transact-SQL)](/sql/relational-databases/system-stored-procedures/ole-automation-stored-procedures-transact-sql)
