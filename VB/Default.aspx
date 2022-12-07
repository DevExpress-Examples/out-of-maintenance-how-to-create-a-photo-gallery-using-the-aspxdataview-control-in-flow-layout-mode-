<%@ Page Language="vb" AutoEventWireup="true" CodeFile="Default.aspx.vb"
    Inherits="PhotoGallerySample" %>

<%@ Register Assembly="DevExpress.XtraCharts.v15.1.Web, Version=15.1.15.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>

<%@ Register Assembly="DevExpress.Xpo.v15.1, Version=15.1.15.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Xpo" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v15.1" Namespace="DevExpress.Web"
    TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.v15.1" Namespace="DevExpress.Web"
    TagPrefix="dxcp" %>
<%@ Register Assembly="DevExpress.Web.v15.1" Namespace="DevExpress.Web"
    TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v15.1" Namespace="DevExpress.Web"
    TagPrefix="dxpc" %>
<%@ Register Assembly="DevExpress.Web.v15.1" Namespace="DevExpress.Web"
    TagPrefix="dxdv" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ASPxDataView - Flow mode - Photo Gallery Sample</title>
    <link runat="server" href="PhotoGallerySample.css" rel="Stylesheet" />

    <script type="text/javascript">
    var EscKeyCode = 27;

    function ShowImage(id) {
       cpPhoto.PerformCallback(id);
       popup.Show();
       popup.UpdatePosition();
    }
    function ClosePopup() {
        popup.Hide();
    }    
    function cpImage_EndCallback(s, e) {
        popup.UpdatePosition();
    }
    function OnBodyKeyDown(e) {
        if(ASPxClientUtils.GetKeyCode(e) == EscKeyCode)
            ClosePopup();
        return true;
    }
    </script>
</head>
<body onkeydown="return OnBodyKeyDown(event);">
    <form id="form1" runat="server">

        <dxpc:ASPxPopupControl ClientInstanceName="popup" PopupHorizontalAlign="WindowCenter"
            PopupVerticalAlign="WindowCenter" ID="pcImage" runat="server" ShowHeader="False"
            Modal="True" CssPostfix="1" EnableAnimation="false" AutoUpdatePosition="true">
            <ContentCollection>
                <dxpc:PopupControlContentControl runat="server">
                    <dxcp:ASPxCallbackPanel ClientInstanceName="cpPhoto" ID="cpImage" runat="server"
                        OnCallback="cpPhoto_Callback" CssPostfix="1">
                        <PanelCollection>
                            <dxp:PanelContent runat="server">
                                <dxe:ASPxImage ID="imPhoto" runat="server" ClientInstanceName="imPhoto" CssClass="Image">
                                    <ClientSideEvents Click="function(s, e) { ClosePopup(); }" />
                                </dxe:ASPxImage>
                                <table width="100%">
                                    <tr>
                                        <td class="popupInfo">
                                            <dxe:ASPxLabel ID="lbPhotoTitle" ClientInstanceName="lbPhotoTitle" runat="server" />
                                        </td>
                                        <td class="closeBtnCell">
                                            <a href="#" onclick="ClosePopup(); return false;">
                                                <img src="Images/closelabel.gif" alt="Close" /></a>
                                        </td>
                                    </tr>
                                </table>
                            </dxp:PanelContent>
                        </PanelCollection>
                        <ClientSideEvents EndCallback="cpImage_EndCallback" />
                     </dxcp:ASPxCallbackPanel>
                </dxpc:PopupControlContentControl>
            </ContentCollection>
            <ContentStyle VerticalAlign="Middle" HorizontalAlign="Center" />
            <ModalBackgroundStyle BackColor="Black" />
        </dxpc:ASPxPopupControl>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>&nbsp;</td>
                <td>
                    <h1>Photo Gallery Sample</h1>
                </td>
            </tr>
            <tr>
                <td class="info">
The ASPxDataView provides an ability to show items in <b>Flow</b> mode. This layout (Layout="Flow") allows you to fill page area by items in the best possible way. This approach is very useful for implementing stretchable site designs.<br /><br />
Note: these images have been made in Red Sea (Sinai) in 2008 by Digital Camera. Click an image to enlarge its size.</td>
                <td class="gallery">
                    <dxdv:ASPxDataView ID="dv" runat="server" AllowPaging="False" DataSourceID="xmlImages"
                        Layout="Flow" CssPostfix="1">
                        <ItemTemplate>
                            <div align="center" style="height: 100%">
                                <table>
                                    <tr>
                                        <td onclick="ShowImage(<%#Eval("id")%>)"
                                            class="thumbnailImageCell">
                                            <dxe:ASPxImage ID="imgPhoto" ImageUrl='<%#GetThumbnailImageUrl(Eval("ThumbnailFileName").ToString())%>'
                                                AlternateText='<%#Eval("Title")%>' Height='<%#Integer.Parse(Eval("ThumbnailHeight").ToString())%>'
                                                Width='<%#Integer.Parse(Eval("ThumbnailWidth").ToString())%>' runat="server" /></td>
                                    </tr>
                                </table>
                                <asp:Label Text='<%#Eval("Title")%>' runat="server" ID="lbTitle" />
                            </div>
                        </ItemTemplate>
                    </dxdv:ASPxDataView>
                </td>
            </tr>
        </table>
        <asp:XmlDataSource ID="xmlImages" runat="server" DataFile="~/App_Data/Photos.xml" XPath="//photos/*" />
    </form>
</body>
</html>