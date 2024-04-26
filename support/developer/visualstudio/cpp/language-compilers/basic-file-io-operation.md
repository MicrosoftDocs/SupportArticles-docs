---
title: Use Visual C++ to do basic file I/O
description: Describes some sample steps about how to do basic file I/O in Visual C++ or Visual C++ .NET.
ms.date: 04/20/2020
ms.custom: sap:Language or Compilers\C++
ms.reviewer: bobbym
ms.topic: how-to
---
# Do basic file I/O in Visual C++

This article describes how to do basic file input/output (I/O) operations in Microsoft Visual C++ or in Visual C++ .NET.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 307398

## Summary

If you're new to the .NET Framework, you'll find that the object model for file operations in the .NET Framework is similar to the `FileSystemObject` that is popular with many Visual Studio developers.

- To make the transition easier, see [How To Use FileSystemObject with Visual Basic](https://support.microsoft.com/help/186118).

- For a Visual C# .NET version of this article, see
[How to do basic file I/O in Visual C#](https://support.microsoft.com/help/304430).  

This article refers to the following .NET Framework Class Library namespaces:

- `System::ComponentModel`  
- `System::Windows::Forms`  
- `System::Drawing`

You can still use the `FileSystemObject` in the .NET Framework. Because the `FileSystemObject` is a Component Object Model (COM) component, the .NET Framework requires that access to the object be through the Interop layer. The .NET Framework generates a wrapper for the component for you if you want to use it. However, the `File` class, the `FileInfo` class, the `Directory`, `DirectoryInfo` classes, and other related classes in the .NET Framework, offer functionality that isn't available with the `FileSystemObject`, without the overhead of the Interop layer.

## Demonstrated file I/O operations

The examples in this article describe basic file I/O operations. The [Step-by-step example](#step-by-step-example) section describes how to create a sample program that demonstrates the following six file I/O operations:

- [Read a text file](#read-a-text-file)
- [Write a text file](#write-a-text-file)
- [View file information](#view-file-information)
- [List disk drives](#list-disk-drives)
- [List sub folders](#list-sub-folders)
- [List files](#list-files)

## Read a text file

The following sample code uses a `StreamReader` class to read a text file. The contents of the file are added to a ListBox control. The `try...catch` block is used to alert the program if the file is empty. There are many ways to determine when the end of the file is reached; this sample uses the `Peek` method to examine the next line before reading it.

```cpp
listBox1->Items->Clear();
try
{
    String* textFile = String::Concat(windir, (S"\\mytest.txt"));
    StreamReader *reader=new  StreamReader(textFile);
    do
    {
        listBox1->Items->Add(reader->ReadLine());
    } while(reader->Peek() != -1);
}

catch (System::Exception *e)
{
    listBox1->Items->Add(e);
}
```

In Visual C++, you must add the common language runtime support compiler option (**/clr:oldSyntax**) to successfully compile the previous code sample as managed C++. To add the common language runtime support compiler option, follow these steps:

1. Click **Project**, and then click **\<ProjectName> Properties**.

    > [!NOTE]
    > \<ProjectName> is a placeholder for the name of the project.
1. Expand **Configuration Properties**, and then click **General**.

1. In the right pane, click to select **Common Language Runtime Support, Old Syntax (/clr:oldSyntax)** in the Common Language Runtime support project settings.
1. Click **Apply**, and then click **OK**.

## Write a text file

This sample code uses a `StreamWriter` class to create and write to a file. If you have an existing file, you can open it in the same way.

```cpp
StreamWriter* pwriter = new StreamWriter(S"c:\\KBTest.txt");
pwriter->WriteLine(S"File created using StreamWriter class.");
pwriter->Close();
listBox1->Items->Clear();
String *filew = new String(S"File Written to C:\\KBTest.txt");
listBox1->Items->Add(filew);
```

## View file information

This sample code uses a `FileInfo` class to access a file's properties. Notepad.exe is used in this sample. The properties appear in a ListBox control.

```cpp
listBox1->Items->Clear();
String* testfile = String::Concat(windir, (S"\\notepad.exe"));
FileInfo *pFileProps =new FileInfo(testfile);

listBox1->Items->Add(String::Concat(S"File Name = ", (pFileProps->get_FullName())));
listBox1->Items->Add(String::Concat(S"Creation Time = ", (pFileProps->get_CreationTime()).ToString()));
listBox1->Items->Add(String::Concat(S"Last Access Time = " ,(pFileProps->get_LastAccessTime()).ToString()));
listBox1->Items->Add(String::Concat(S"Last Write Time = ", (pFileProps->get_LastWriteTime()).ToString()));
listBox1->Items->Add(String::Concat(S"Size = ", (pFileProps->get_Length()).ToString()));
```

## List disk drives

This sample code uses the `Directory` and `Drive` classes to list the logical drives on a system. For this sample, the results appear in a ListBox control.

```csharp
listBox1->Items->Clear();
String* drives[] = Directory::GetLogicalDrives();
int numDrives = drives->get_Length();
for (int i=0; i<numDrives; i++)
{
    listBox1->Items->Add(drives[i]);
}
```

## List sub folders

This sample code uses the `GetDirectories` method of the `Directory` class to obtain a list of folders.

```cpp
listBox1->Items->Clear();
String* dirs[] = Directory::GetDirectories(windir);
int numDirs = dirs->get_Length();
for (int i=0; i<numDirs; i++)
{
    listBox1->Items->Add(dirs[i]);
}
```

## List files

This sample code uses the `GetFiles` method of the `Directory` class to obtain a listing of files.

```cpp
listBox1->Items->Clear();
String* files[]= Directory::GetFiles(this->windir);
int numFiles = files->get_Length();
for (int i=0; i<numFiles; i++)
{
    listBox1->Items->Add(files[i]);
}
```

Many things can go wrong when a user gains access to files. The files may not exist, the files may be in use, or users may not have rights on the files of folders that they're trying to access. Consider these possibilities when you write code to handle the exceptions that may be generated.

## Step-by-step example

1. Start Visual Studio .NET.
2. On the **File** menu, point to **New**, and then click **Project**.
3. Under **Project Types**, click **Visual C++ Projects**. Under **Templates** section, click **Windows Forms Application (.NET)**.
4. Type _KB307398_ in the **Name** box, type `C:\` in the **Location** box, and then click **OK**.
5. Open the _Form1_ form in the Design view, and then press F4 to open the **Properties** window.
6. In the **Properties** window, expand the **Size** folder. In the **Width** box, type _700_. In the **Height** box, type _320_.
7. Add one ListBox control and six Button controls to _Form1_.

    > [!NOTE]
    > To view the toolbox, click **Toolbox** on the **View** menu.

8. In the **Properties** window, change the **Location**, the **Name**, the **Size**, the **TabIndex**, and the **Text** properties of these controls as follows:

    |Control ID|Location|Name|Size|TabIndex|Text|
    |---|---|---|---|---|---|
    |button1|500, 32|button1|112, 23|1|Read Text File|
    |button2|500, 64|button2|112, 23|2|Write Text File|
    |button3|500, 96|button3|112, 23|3|View File Information|
    |button4|500, 128|button4|112, 23|4|List Drives|
    |button5|500, 160|button5|112, 23|5|List Subfolders|
    |button6|500, 192|button6|112, 23|6|List Files|
    |listBox1|24, 24|listBox1|450, 200|0|listBox1|

9. Open the _Form1.h_ file. In the `Form1` class declaration, declare one private `String` variable with the following code:

    ```cpp
    private:
    String *windir;
    ```

10. In the `Form1` class constructor, add the following code:

    ```cpp
    windir = System::Environment::GetEnvironmentVariable("windir");
    ```

11. To do file Input output operations, add the `System::IO` namespace.

12. Press SHIFT+F7 to open _Form1_ in Design view. Double-click the **Read Text File** button, and then paste the following code:

    ```cpp
    // How to read a text file:
    // Use try...catch to deal with a 0 byte file or a non-existant file.
    listBox1->Items->Clear();

    try
    {
        String* textFile = String::Concat(windir, (S"\\mytest.txt"));
        StreamReader *reader=new  StreamReader(textFile);
        do
        {
            listBox1->Items->Add(reader->ReadLine());
        } while(reader->Peek() != -1);
    }
    catch(FileNotFoundException *ex)
    {
        listBox1->Items->Add(ex);
    }  

    catch (System::Exception *e)
    {
        listBox1->Items->Add(e);
    }
    ```

13. In the Form1 Design view, double-click the **Write Text File** button, and then paste the following code:

    ```cpp
    // This demonstrates how to create and to write to a text file.
    StreamWriter* pwriter = new StreamWriter(S"c:\\KBTest.txt");
    pwriter->WriteLine(S"The file was created by using the StreamWriter class.");
    pwriter->Close();
    listBox1->Items->Clear();
    String *filew = new String(S"File written to C:\\KBTest.txt");
    listBox1->Items->Add(filew);
    ```

14. In the Form1 Design view, double-click the **View File Information** button, and then paste the following code in the method:

    ```cpp
    // This code retrieves file properties. The example uses Notepad.exe.
    listBox1->Items->Clear();
    String* testfile = String::Concat(windir, (S"\\notepad.exe"));
    FileInfo *pFileProps =new FileInfo(testfile);

    listBox1->Items->Add(String::Concat(S"File Name = ", (pFileProps->get_FullName())));
    listBox1->Items->Add(String::Concat(S"Creation Time = ", (pFileProps->get_CreationTime()).ToString()));
    listBox1->Items->Add(String::Concat(S"Last Access Time = " ,(pFileProps->get_LastAccessTime()).ToString()));
    listBox1->Items->Add(String::Concat(S"Last Write Time = ", (pFileProps->get_LastWriteTime()).ToString()));
    listBox1->Items->Add(String::Concat(S"Size = ", (pFileProps->get_Length()).ToString()));
    ```

15. In the Form1 Design view, double-click the List Drives button, and then paste the following code:

    ```cpp
    // This demonstrates how to obtain a list of disk drives.
    listBox1->Items->Clear();
    String* drives[] = Directory::GetLogicalDrives();
    int numDrives = drives->get_Length();
    for (int i=0; i<numDrives; i++)
    {
        listBox1->Items->Add(drives[i]);
    }
    ```

16. In the Form1 Design view, double-click the List Subfolders button, and then paste the following code:

    ```cpp
    // This code obtains a list of folders. This example uses the Windows folder.
    listBox1->Items->Clear();
    String* dirs[] = Directory::GetDirectories(windir);
    int numDirs = dirs->get_Length();
    for (int i=0; i<numDirs; i++)
    {
        listBox1->Items->Add(dirs[i]);
    }
    ```

17. In the Form1 Design view, double-click the List Files button, and then paste the following code:

    ```cpp
    // This code obtains a list of files. This example uses the Windows folder.
    listBox1->Items->Clear();
    String* files[]= Directory::GetFiles(this->windir);
    int numFiles = files->get_Length();
    for (int i=0; i<numFiles; i++)
    {
        listBox1->Items->Add(files[i]);
    }
    ```

18. To build and then run the program, press CTRL+F5.

## Complete code sample

```cpp
//Form1.h
#pragma once

namespace KB307398
{
    using namespace System;
    using namespace System::IO;
    using namespace System::ComponentModel;
    using namespace System::Collections;
    using namespace System::Windows::Forms;
    using namespace System::Data;
    using namespace System::Drawing;

    /// <summary>
    /// Summary for Form1
    /// WARNING: If you change the name of this class, you will need to change the
    ///          'Resource File Name' property for the managed resource compiler tool
    ///          associated with all .resx files this class depends on.  Otherwise,
    ///          the designers will not be able to interact properly with localized
    ///          resources associated with this form.
    /// </summary>
    public __gc class Form1 : public System::Windows::Forms::Form
    {
        private:
        String *windir;
        public:
        Form1(void)
        {
            windir = System::Environment::GetEnvironmentVariable("windir");
            InitializeComponent();
        }

        protected:
        void Dispose(Boolean disposing)
        {
            if (disposing && components)
            {
            components->Dispose();
            }
            __super::Dispose(disposing);
        }
        private: System::Windows::Forms::Button *  button1;
        private: System::Windows::Forms::Button *  button2;
        private: System::Windows::Forms::Button *  button3;
        private: System::Windows::Forms::Button *  button4;
        private: System::Windows::Forms::Button *  button5;
        private: System::Windows::Forms::Button *  button6;
        private: System::Windows::Forms::ListBox *  listBox1;

        private:
        /// <summary>
        /// Required designer variable.
        /// </summary>
        System::ComponentModel::Container * components;

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        void InitializeComponent(void)
        {
            this->button1 = new System::Windows::Forms::Button();
            this->button2 = new System::Windows::Forms::Button();
            this->button3 = new System::Windows::Forms::Button();
            this->button4 = new System::Windows::Forms::Button();
            this->button5 = new System::Windows::Forms::Button();
            this->button6 = new System::Windows::Forms::Button();
            this->listBox1 = new System::Windows::Forms::ListBox();
            this->SuspendLayout();
            // button1
            this->button1->Location = System::Drawing::Point(500, 32);
            this->button1->Name = S"button1";
            this->button1->Size = System::Drawing::Size(112, 23);
            this->button1->TabIndex = 1;
            this->button1->Text = S"Read Text File";
            this->button1->Click += new System::EventHandler(this, button1_Click);
            // button2
            this->button2->Location = System::Drawing::Point(500, 64);
            this->button2->Name = S"button2";
            this->button2->Size = System::Drawing::Size(112, 23);
            this->button2->TabIndex = 2;
            this->button2->Text = S"Write Text File";
            this->button2->Click += new System::EventHandler(this, button2_Click);
            // button3
            this->button3->Location = System::Drawing::Point(500, 96);
            this->button3->Name = S"button3";
            this->button3->Size = System::Drawing::Size(112, 23);
            this->button3->TabIndex = 3;
            this->button3->Text = S"View File Information";
            this->button3->Click += new System::EventHandler(this, button3_Click);
            // button4
            this->button4->Location = System::Drawing::Point(500, 128);
            this->button4->Name = S"button4";
            this->button4->Size = System::Drawing::Size(112, 23);
            this->button4->TabIndex = 4;
            this->button4->Text = S"List Drives";
            this->button4->Click += new System::EventHandler(this, button4_Click);
            // button5
            this->button5->Location = System::Drawing::Point(500, 160);
            this->button5->Name = S"button5";
            this->button5->Size = System::Drawing::Size(112, 23);
            this->button5->TabIndex = 5;
            this->button5->Text = S"List Subfolders";
            this->button5->Click += new System::EventHandler(this, button5_Click);
            // button6
            this->button6->Location = System::Drawing::Point(500, 188);
            this->button6->Name = S"button6";
            this->button6->Size = System::Drawing::Size(112, 23);
            this->button6->TabIndex = 6;
            this->button6->Text = S"List Files";
            this->button6->Click += new System::EventHandler(this, button6_Click);
            // listBox1
            this->listBox1->Location = System::Drawing::Point(24, 24);
            this->listBox1->Name = S"listBox1";
            this->listBox1->Size = System::Drawing::Size(450, 199);
            this->listBox1->TabIndex = 0;
            // Form1
            this->AutoScaleBaseSize = System::Drawing::Size(5, 13);
            this->ClientSize = System::Drawing::Size(692, 293);
            this->Controls->Add(this->listBox1);
            this->Controls->Add(this->button6);
            this->Controls->Add(this->button5);
            this->Controls->Add(this->button4);
            this->Controls->Add(this->button3);
            this->Controls->Add(this->button2);
            this->Controls->Add(this->button1);
            this->Name = S"Form1";
            this->Text = S"Form1";
            this->ResumeLayout(false);
        }
        private: System::Void button1_Click(System::Object *  sender, System::EventArgs *  e)
        {
            // This code shows how to read a text file.
            // The try...catch code is to deal with a 0 byte file or a non-existant file.
            listBox1->Items->Clear();

            try
            {
                String* textFile = String::Concat(windir, (S"\\mytest.txt"));
                StreamReader *reader=new  StreamReader(textFile);
                do
                {
                    listBox1->Items->Add(reader->ReadLine());
                }
                while(reader->Peek() != -1);
            }
            catch(FileNotFoundException *ex)
            {
                listBox1->Items->Add(ex);
            }

            catch (System::Exception *e)
            {
                listBox1->Items->Add(e);
            }
        }

        private: System::Void button2_Click(System::Object *  sender, System::EventArgs *  e)
        {
            // This code demonstrates how to create and to write to a text file.
            StreamWriter* pwriter = new StreamWriter(S"c:\\KBTest.txt");
            pwriter->WriteLine(S"The file was created by using the StreamWriter class.");
            pwriter->Close();
            listBox1->Items->Clear();
            String *filew = new String(S"The file was written to C:\\KBTest.txt");
            listBox1->Items->Add(filew);
        }

        private: System::Void button3_Click(System::Object *  sender, System::EventArgs *  e)
         {
            // This code retrieves file properties. This example uses Notepad.exe.
            listBox1->Items->Clear();
            String* testfile = String::Concat(windir, (S"\\notepad.exe"));
            FileInfo *pFileProps  =new FileInfo(testfile);

            listBox1->Items->Add(String::Concat(S"File Name = ", (pFileProps->get_FullName() )) );
            listBox1->Items->Add(String::Concat(S"Creation Time = ", (pFileProps->get_CreationTime() ).ToString()) );
            listBox1->Items->Add(String::Concat(S"Last Access Time = "  ,(pFileProps->get_LastAccessTime() ).ToString()) );
            listBox1->Items->Add(String::Concat(S"Last Write Time = ", (pFileProps->get_LastWriteTime() ).ToString()) );
            listBox1->Items->Add(String::Concat(S"Size = ", (pFileProps->get_Length() ).ToString()) );
        }

        private: System::Void button4_Click(System::Object *  sender, System::EventArgs *  e)
        {
            // The code demonstrates how to obtain a list of disk drives.
            listBox1->Items->Clear();
            String* drives[] = Directory::GetLogicalDrives();
            int numDrives = drives->get_Length();
            for (int i=0; i<numDrives; i++)
            {
                listBox1->Items->Add(drives[i]);
            }
        }

        private: System::Void button5_Click(System::Object *  sender, System::EventArgs *  e)
        {
            // This code obtains a list of folders. This example uses the Windows folder.
            listBox1->Items->Clear();
            String* dirs[] = Directory::GetDirectories(windir);
            int numDirs = dirs->get_Length();
            for (int i=0; i<numDirs; i++)
            {
                listBox1->Items->Add(dirs[i]);
            }
        }

        private: System::Void button6_Click(System::Object *  sender, System::EventArgs *  e)
        {
            // This code obtains a list of files. This example uses the Windows folder.
            listBox1->Items->Clear();
            String* files[]= Directory::GetFiles(this->windir);
            int numFiles = files->get_Length();
            for (int i=0; i<numFiles; i++)
            {
                listBox1->Items->Add(files[i]);
            }
        }
    };
}

//Form1.cpp
#include "stdafx.h"
#include "Form1.h"
#include <windows.h>

using namespace KB307398;

int APIENTRY _tWinMain(HINSTANCE hInstance,
                     HINSTANCE hPrevInstance,
                     LPTSTR    lpCmdLine,
                     int       nCmdShow)
{
    System::Threading::Thread::CurrentThread->ApartmentState = System::Threading::ApartmentState::STA;
    Application::Run(new Form1());
    return 0;
}
```

## References

For more information, visit [Microsoft Support](https://support.microsoft.com/). For more information about how to create Windows forms in managed extensions for C++, see the `ManagedCWinFormWiz` sample in Visual Studio .NET Help.
