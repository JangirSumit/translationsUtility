<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TranslationsUtility._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Add-Update MyAccount Translations</h1>

    <div class="form-group">
        <label for="txtMetatag">Translation meta tag or Key</label>
        <input required type="text" class="form-control" id="txtMetatag">
    </div>
    <div class="form-group">
        <label for="txtDesc">Description</label>
        <input type="text" class="form-control" id="txtDesc">
    </div>
    <hr />
    <p><b>Add Languages</b></p>
    <div id="langRows">
    </div>
    <hr />

    <button type="button" id="addLangRow" class="btn btn-success" onclick="addRows();">Add Translation Row</button>
    <button type="button" class="btn btn-primary" id="updateTransBtn" onclick="uploadAndTranslate();">Update Translations</button>
</asp:Content>

