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


	#tag Method, Flags = &h0
		Sub populatePhotoLB()
		  // populate lb with list of photos, sort name asc
		  
		  Dim dbFile As FolderItem
		  Dim db As New SQLiteDatabase
		  dbFile = GetFolderItem("photos.sqlite")
		  db.DatabaseFile = dbFile
		  If db.Connect Then
		    // Check for database records.  If none, dialog notifiying user of new test instance
		    Dim rs As RecordSet
		    rs = db.SQLSelect("SELECT id_reference, file_name FROM photos ORDER BY file_name")
		    
		    If db.Error Then
		      MsgBox("Error: " + db.ErrorMessage)
		      Return
		    End If
		    
		    If rs.RecordCount > 0 Then
		      Viewer.photos.DeleteAllRows
		      While Not rs.EOF
		        Viewer.photos.AddRow(rs.IdxField(2).StringValue)
		        Viewer.photos.RowTag(viewer.photos.LastIndex) = rs.IdxField(1).StringValue
		        rs.MoveNext
		      Wend
		      
		    Else
		      Viewer.photos.DeleteAllRows
		      Return
		    End If
		    
		  Else
		    MsgBox("The database couldn't be opened. If this continues, please contact the developer.  Error: " + db.ErrorMessage)
		    Return
		  End If
		  
		  
		  
		  
		End Sub
	#tag EndMethod


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


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
