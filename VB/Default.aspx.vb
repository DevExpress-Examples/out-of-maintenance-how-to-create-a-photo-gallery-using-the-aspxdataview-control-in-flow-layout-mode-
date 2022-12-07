Imports System
Imports System.Xml
Imports DevExpress.Web
Imports System.Web.UI
Imports System.IO

Partial Public Class PhotoGallerySample
    Inherits Page

    Private Shared ReadOnly InvalidFileNameChars() As Char = Path.GetInvalidFileNameChars()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
    End Sub
    Protected Sub cpPhoto_Callback(ByVal source As Object, ByVal e As CallbackEventArgsBase)
        Dim imageId As Integer = Nothing
        If Not Integer.TryParse(e.Parameter, imageId) Then
            Return
        End If

        Dim imageInfo As XmlAttributeCollection = GetImageInfo(imageId)
        If imageInfo IsNot Nothing Then
            Dim fileName As String = imageInfo("FileName").Value
            ValidateFileName(fileName)

            Dim title_Renamed As String = imageInfo("Title").Value

            imPhoto.ImageUrl = GetImageUrl(fileName)
            imPhoto.Width = Integer.Parse(imageInfo("Width").Value)
            imPhoto.Height = Integer.Parse(imageInfo("Height").Value)
            imPhoto.AlternateText = title_Renamed
            lbPhotoTitle.Text = title_Renamed
        End If
    End Sub

    ' Utils
    Protected Function GetThumbnailImageUrl(ByVal imageFileName As String) As String
        Return "Photos/Thumbnails/" & imageFileName
    End Function
    Protected Function GetImageUrl(ByVal imageFileName As String) As String
        Return "Photos/" & imageFileName
    End Function
    Private Function GetImageInfo(ByVal imageId As Integer) As XmlAttributeCollection

        Dim xpath_Renamed As String = String.Format("//photos/photo[@id='{0}']", imageId)
        Dim node As XmlNode = xmlImages.GetXmlDocument().SelectSingleNode(xpath_Renamed)
        Return If(node IsNot Nothing, node.Attributes, Nothing)
    End Function
    Private Shared Sub ValidateFileName(ByVal fileName As String)
        For i As Integer = 0 To InvalidFileNameChars.Length - 1
            If fileName.Contains(InvalidFileNameChars(i).ToString()) Then
                Throw New IOException("Invalid file name.")
            End If
        Next i
    End Sub
End Class