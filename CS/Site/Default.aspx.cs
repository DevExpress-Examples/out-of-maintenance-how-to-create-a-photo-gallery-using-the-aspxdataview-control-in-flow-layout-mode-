using System;
using System.Xml;
using DevExpress.Web.ASPxClasses;
using System.Web.UI;
using System.IO;

public partial class PhotoGallerySample : Page {
    private static readonly char[] InvalidFileNameChars = Path.GetInvalidFileNameChars();

    protected void Page_Load(object sender, EventArgs e) {
        ASPxWebControl.RegisterUtilsScript(this);
    }
    protected void cpPhoto_Callback(object source, CallbackEventArgsBase e) {
        int imageId;
        if(!int.TryParse(e.Parameter, out imageId))
            return;

        XmlAttributeCollection imageInfo = GetImageInfo(imageId);
        if(imageInfo != null) {
            string fileName = imageInfo["FileName"].Value;
            ValidateFileName(fileName);
            string title = imageInfo["Title"].Value;
            
            imPhoto.ImageUrl = GetImageUrl(fileName);
            imPhoto.Width = int.Parse(imageInfo["Width"].Value);
            imPhoto.Height = int.Parse(imageInfo["Height"].Value);
            imPhoto.AlternateText = title;
            lbPhotoTitle.Text = title;
        }
    }

    // Utils
    protected string GetThumbnailImageUrl(string imageFileName) {
        return "Photos/Thumbnails/" + imageFileName;
    }
    protected string GetImageUrl(string imageFileName) {
        return "Photos/" + imageFileName;
    }
    private XmlAttributeCollection GetImageInfo(int imageId) {
        string xpath = string.Format("//photos/photo[@id='{0}']", imageId);
        XmlNode node = xmlImages.GetXmlDocument().SelectSingleNode(xpath);
        return node != null ? node.Attributes : null;
    }
    private static void ValidateFileName(string fileName) {
        for(int i = 0; i < InvalidFileNameChars.Length; i++)
            if(fileName.Contains(InvalidFileNameChars[i].ToString()))
                throw new IOException("Invalid file name.");
    }
}