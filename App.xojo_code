#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Open()
		  // try to connect to SQLite database.  If not found, create one.
		  
		  Dim photoFile As FolderItem
		  Dim photoDB As New SQLiteDatabase
		  photoFile = GetFolderItem("photos.sqlite")
		  photoDB.DatabaseFile = photoFile
		  If photoDB.Connect Then
		    Viewer.show
		    Return
		  Else 
		    Dim photoF As FolderItem
		    photoF = New FolderItem("photos.sqlite")
		    Dim pF As New SQLiteDatabase
		    pF.DatabaseFile = photoF
		    If pF.CreateDatabaseFile Then
		      pF.SQLExecute("CREATE TABLE photos ( id_reference INTEGER PRIMARY KEY, file_name TEXT, photo_file BLOB );")
		      Viewer.show
		      Return
		    Else
		      MsgBox("Photo database not created. If problem persists, please contact developer.  Error: " + pF.ErrorMessage)
		      Quit
		    End If
		  End If
		  
		End Sub
	#tag EndEvent


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


End Class
#tag EndClass
