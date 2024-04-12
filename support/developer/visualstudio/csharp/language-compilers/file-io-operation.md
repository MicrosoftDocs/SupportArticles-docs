---
title: Do basic file I/O in Visual C#
description: Describes how to do basic file I/O in Visual C#. This article also provides a code sample to illustrate how to perform this task.
ms.date: 04/13/2020
ms.topic: how-to
ms.custom: sap:Language or Compilers\C#
---
# Use Visual C# to do basic file I/O

This article describes how to do basic file I/O in Visual C#, and provides a code sample to illustrate how to perform this task.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 304430

## Summary

> [!NOTE]
>
> - For a Visual Basic .NET version of this article, see
[How to do basic file I/O in Visual Basic 2005 or in Visual Basic .NET](https://support.microsoft.com/help/304427/how-to-do-basic-file-i-o-in-visual-basic-2005-or-in-visual-basic-net).
> - For a Visual C++ .NET version of this article, see
[How to do basic file I/O in Visual C++ or in Visual C++ .NET](https://support.microsoft.com/help/307398/how-to-do-basic-file-i-o-in-visual-c-or-in-visual-c-net).  
> - This article refers to the Microsoft .NET Framework Class Library namespaces `System.IO` and `System.Collections`.

This step-by-step article shows you how to do six basic file input/output (I/O) operations in Visual C#. If you are new to the .NET Framework, you will find that the object model for file operations in .NET is similar to the `FileSystemObject` (FSO) that is popular with many Visual Studio 6.0 developers. To make the transition easier, the functionality that is demonstrated in [How To Use FileSystemObject with Visual Basic](https://support.microsoft.com/help/186118/how-to-use-filesystemobject-with-visual-basic).

You can still use the `FileSystemObject` in .NET. Because the `FileSystemObject` is a Component Object Model (COM) component, .NET requires that access to the object be through the Interop layer. Microsoft .NET generates a wrapper for the component for you if you want to use it. However, the `File`, `FileInfo`, `Directory`, `DirectoryInfo` classes, and other related classes in the .NET Framework, offer functionality that is not available with the FSO, without the overhead of the Interop layer.

## Demonstrated file I/O operations

The examples in this article describe basic file I/O operations. The [Step-by-step example](#step-by-step-example) section describes how to create a sample program that demonstrates the following file I/O operations:

- Read a text file
- Write a text file
- View file information
- List disk drives
- List folders
- List files

If you want to use the following code samples directly, be aware of the following:

- Include the `System.IO` namespace, as follows:

    ```csharp
    using System.IO;
    ```

- Declare the `winDir` variable as follows:

    ```csharp
    string winDir=System.Environment.GetEnvironmentVariable("windir");
    ```

- The `addListItem` function is declared as follows:

    ```csharp
    private void addListItem(string value)
    {
        this.listBox1.Items.Add(value);
    }
    ```

    Instead of declaring and using the `addListItem` function, you can use the following statement directly:

    ```csharp
    this.listBox1.Items.Add(value);
    ```

## Read a text file

The following sample code uses a `StreamReader` class to read the *System.ini* file. The contents of the file are added to a ListBox control. The `try...catch` block is used to alert the program if the file is empty. There are many ways to determine when the end of the file is reached; this sample uses the `Peek` method to examine the next line before reading it.

```csharp
StreamReader reader=new StreamReader(winDir + "\\system.ini");
try
{
    do
    {
        addListItem(reader.ReadLine());
    }
    while(reader.Peek()!= -1);
}
catch
{
    addListItem("File is empty");
}
finally
{
    reader.Close();
}
```

## Write a text file

This sample code uses a `StreamWriter` class to create and write to a file. If you have an existing file, you can open it in the same way.

```csharp
StreamWriter writer = new StreamWriter("c:\\KBTest.txt");
writer.WriteLine("File created using StreamWriter class.");
writer.Close();
this.listbox1.Items.Clear();
addListItem("File Written to C:\\KBTest.txt");
```

## View file information

This sample code uses a `FileInfo` object to access a file's properties. Notepad.exe is used in this sample. The properties appear in a ListBox control.

```csharp
FileInfo FileProps =new FileInfo(winDir + "\\notepad.exe");
addListItem("File Name = " + FileProps.FullName);
addListItem("Creation Time = " + FileProps.CreationTime);
addListItem("Last Access Time = " + FileProps.LastAccessTime);
addListItem("Last Write TIme = " + FileProps.LastWriteTime);
addListItem("Size = " + FileProps.Length);
FileProps = null;
```

## List disk drives

This sample code uses the `Directory` and `Drive` classes to list the logical drives on a system. For this sample, the results appear in a ListBox control.

```csharp
string[] drives = Directory.GetLogicalDrives();
foreach(string drive in drives)
{
    addListItem(drive);
}
```

## List sub folders

This sample code uses the `GetDirectories` method of the `Directory` class to get a list of folders.

```csharp
string[] dirs = Directory.GetDirectories(winDir);
foreach(string dir in dirs)
{
    addListItem(dir);
}
```

## List files

This sample code uses the `GetFiles` method of the `Directory` class to get a listing of files.

```csharp
string[] files= Directory.GetFiles(winDir);
foreach (string i in files)
{
    addListItem(i);
}
```

Many things can go wrong when a user gains access to files. The files may not exist, the files may be in use, or users may not have rights on the files or folders that they are trying to access. It is important to consider these possibilities when you write code and to handle the exceptions that may be generated.

## Step-by-step example

1. In Visual C#, create a new Windows Forms Application. By default, *Form1* is created.
2. Open the code window for *Form1* (*Form1.cs*).
3. Delete all of the code in the *Form1.cs*.
4. Paste the following code in the **Code-Behind Editor** window.

    ```csharp
    using System.Windows.Forms;
    using System.IO;

    namespace fso_cs
    {
        public partial class Form1 : Form
        {
            string winDir = System.Environment.GetEnvironmentVariable("windir");

            public Form1()
            {
                InitializeComponent();
            }

            private void button1_Click(object sender, System.EventArgs e)
            {
                //How to read a text file.
                //try...catch is to deal with a 0 byte file.
                this.listBox1.Items.Clear();
                StreamReader reader = new StreamReader(winDir + "\\system.ini");
                try
                {
                    do
                    {
                        addListItem(reader.ReadLine());
                    }
                    while (reader.Peek()!= -1);
                }
                catch
                {
                    addListItem("File is empty");
                }
                finally
                {
                    reader.Close();
                }
            }

            private void button2_Click(object sender, System.EventArgs e)
            {
                //Demonstrates how to create and write to a text file.
                StreamWriter writer = new StreamWriter("c:\\KBTest.txt");
                writer.WriteLine("File created using StreamWriter class.");
                writer.Close();
                this.listBox1.Items.Clear();
                addListItem("File Written to C:\\KBTest.txt");
            }

            private void button3_Click(object sender, System.EventArgs e)
            {
                //How to retrieve file properties (example uses Notepad.exe).
                this.listBox1.Items.Clear();
                FileInfo FileProps = new FileInfo(winDir + "\\notepad.exe");
                addListItem("File Name = " + FileProps.FullName);
                addListItem("Creation Time = " + FileProps.CreationTime);
                addListItem("Last Access Time = " + FileProps.LastAccessTime);
                addListItem("Last Write TIme = " + FileProps.LastWriteTime);
                addListItem("Size = " + FileProps.Length);
                FileProps = null;
            }

            private void button4_Click(object sender, System.EventArgs e)
            {
                //Demonstrates how to obtain a list of disk drives.
                this.listBox1.Items.Clear();
                string[] drives = Directory.GetLogicalDrives();
                foreach (string drive in drives)
                {
                    addListItem(drive);
                }
            }

            private void button5_Click(object sender, System.EventArgs e)
            {
                //How to get a list of folders (example uses Windows folder). 
                this.listBox1.Items.Clear();
                string[] dirs = Directory.GetDirectories(winDir);
                foreach (string dir in dirs)
                {
                    addListItem(dir);
                }
            }

            private void button6_Click(object sender, System.EventArgs e)
            {
                //How to obtain list of files (example uses Windows folder).
                this.listBox1.Items.Clear();
                string[] files = Directory.GetFiles(winDir);
                foreach (string i in files)
                {
                    addListItem(i);
                }
            }

            private void Form1_Load(object sender, System.EventArgs e)
            {
                this.button1.Text = "Read Text File";
                this.button2.Text = "Write Text File";
                this.button3.Text = "View File Information";
                this.button4.Text = "List Drives";
                this.button5.Text = "List Subfolders";
                this.button6.Text = "List Files";
            }

            private void addListItem(string value)
            {
                this.listBox1.Items.Add(value);
            }
        }
    }
    ```

5. Open the code window for *Form1.Designer.cs*.
6. Delete all of the code in *Form1.Designer.cs*.
7. Paste the following code in *Form1.Designer.cs*.

    ```csharp
    namespace fso_cs
    {
        partial class Form1
        {
            /// <summary>
            /// Required designer variable.
            /// </summary>
            private System.ComponentModel.IContainer components = null;

            /// <summary>
            /// Clean up any resources being used.
            /// </summary>
            /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
            protected override void Dispose(bool disposing)
            {
                if (disposing && (components != null))
                {
                    components.Dispose();
                }
                base.Dispose(disposing);
            }

            #region Windows Form Designer generated code
            /// <summary>
            /// Required method for Designer support - do not modify
            /// the contents of this method with the code editor.
            /// </summary>
            private void InitializeComponent()
            {
                this.button1 = new System.Windows.Forms.Button();
                this.button2 = new System.Windows.Forms.Button();
                this.button3 = new System.Windows.Forms.Button();
                this.button4 = new System.Windows.Forms.Button();
                this.button5 = new System.Windows.Forms.Button();
                this.button6 = new System.Windows.Forms.Button();
                this.listBox1 = new System.Windows.Forms.ListBox();
                this.SuspendLayout();

                // button1
                this.button1.Location = new System.Drawing.Point(53, 30);
                this.button1.Name = "button1";
                this.button1.Size = new System.Drawing.Size(112, 23);
                this.button1.TabIndex = 1;
                this.button1.Text = "button1";
                this.button1.Click += new System.EventHandler(this.button1_Click);

                // button2
                this.button2.Location = new System.Drawing.Point(53, 62);
                this.button2.Name = "button2";
                this.button2.Size = new System.Drawing.Size(112, 23);
                this.button2.TabIndex = 2;
                this.button2.Text = "button2";
                this.button2.Click += new System.EventHandler(this.button2_Click);

                // button3
                this.button3.Location = new System.Drawing.Point(53, 94);
                this.button3.Name = "button3";
                this.button3.Size = new System.Drawing.Size(112, 23);
                this.button3.TabIndex = 3;
                this.button3.Text = "button3";
                this.button3.Click += new System.EventHandler(this.button3_Click);

                // button4
                this.button4.Location = new System.Drawing.Point(53, 126);
                this.button4.Name = "button4";
                this.button4.Size = new System.Drawing.Size(112, 23);
                this.button4.TabIndex = 4;
                this.button4.Text = "button4";
                this.button4.Click += new System.EventHandler(this.button4_Click);

                // button5
                this.button5.Location = new System.Drawing.Point(53, 158);
                this.button5.Name = "button5";
                this.button5.Size = new System.Drawing.Size(112, 23);
                this.button5.TabIndex = 5;
                this.button5.Text = "button5";
                this.button5.Click += new System.EventHandler(this.button5_Click);

                // button6
                this.button6.Location = new System.Drawing.Point(53, 190);
                this.button6.Name = "button6";
                this.button6.Size = new System.Drawing.Size(112, 23);
                this.button6.TabIndex = 6;
                this.button6.Text = "button6";
                this.button6.Click += new System.EventHandler(this.button6_Click);

                // listBox1
                this.listBox1.FormattingEnabled = true;
                this.listBox1.Location = new System.Drawing.Point(204, 30);
                this.listBox1.Name = "listBox1";
                this.listBox1.Size = new System.Drawing.Size(270, 199);
                this.listBox1.TabIndex = 7;

                // Form1
                this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
                this.ClientSize = new System.Drawing.Size(525, 273);
                this.Controls.Add(this.button6);
                this.Controls.Add(this.button5);
                this.Controls.Add(this.button4);
                this.Controls.Add(this.button3);
                this.Controls.Add(this.button2);
                this.Controls.Add(this.button1);
                this.Controls.Add(this.listBox1);
                this.Name = "Form1";
                this.Text = "Form1";
                this.Load += new System.EventHandler(this.Form1_Load);
                this.ResumeLayout(false);
            }
            #endregion

            private System.Windows.Forms.Button button1;
            private System.Windows.Forms.Button button2;
            private System.Windows.Forms.Button button3;
            private System.Windows.Forms.Button button4;
            private System.Windows.Forms.Button button5;
            private System.Windows.Forms.Button button6;
            private System.Windows.Forms.ListBox listBox1;
        }
    }
    ```

8. By default, Visual C# adds one form to the project when you create a Windows Forms project. This form is named *Form1*. The two source code files that represent the form are named *Form1.cs* and *Form1.Designer.cs*. You write your code in the *Form1.cs* file. The Windows Forms Designer writes designer-generated code in the *Form1.Designer.cs* file. The code in the preceding steps reflects that organization.

9. Press F5 to build and then run the program. Click the buttons to view the different actions. When you view the sample code, you may want to collapse the area named *Windows Form Designer Generated Code* to hide this code.
