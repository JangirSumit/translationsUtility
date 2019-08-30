<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ImportExport.aspx.cs" Inherits="TranslationsUtility.ImportExport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Import/Export Translations</h1>

    <div class="panel panel-info">
        <div class="panel-heading"><b>Export</b></div>
        <div class="panel-body">
            <div class="form-group">


                <div class="row">
                    <div class="col-sm-2" style="line-height: 2; font-size: 16px;">
                        Select Language
                    </div>
                    <div class="col-sm-8">
                        <select class="form-control lang-ddl" style="width: 100%;" id="ddlExport">
                            <option value="select" selected>Select language</option>
                        </select>
                    </div>
                    <div class="col-sm-2">
                        <button type="button" onclick="exportData('excel');" class="btn btn-primary">Excel</button>
                        <button type="button" onclick="exportData('csv');" class="btn btn-success">CSV</button>
                    </div>
                </div>

            </div>
        </div>
    </div>


    <div class="panel panel-success">
        <div class="panel-heading"><b>Import</b></div>
        <div class="panel-body">
            <div class="form-group">

                <div class="row">
                    <div class="col-sm-2" style="line-height: 2; font-size: 16px;">
                        Select Language
                    </div>
                    <div class="col-sm-4">
                        <select class="form-control lang-ddl" style="width: 100%;" id="ddlImport">
                            <option value="select" selected>Select language</option>
                        </select>
                    </div>
                    <div class="col-sm-4">
                        <input type="file" class="form-control" id="txtImportFile"
                            accept=".csv, .xlsx" />
                    </div>
                    <div class="col-sm-2">
                        <button id="btnUpload" type="button" class="btn btn-success">Update Translations</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
