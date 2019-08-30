var Languages = {
    ar: "Arabic",
    bg: "Bulgarian",
    cs: "Cesky",
    zhCN: "Chinese - CN",
    zhTW: "Chinese - TW",
    da: "Danish",
    de: "Deutsch",
    en: "English",
    es: "Español",
    fr: "Français",
    el: "Greek",
    hr: "Hrvatski",
    it: "Italiano",
    ja: "Japanese",
    hu: "Magyar",
    nl: "Nederlands",
    no: "Norsk",
    pl: "Polski",
    pt: "Português",
    ptBR: "Português - BR",
    ro: "Română",
    ru: "Russian",
    sk: "Slovak",
    sl: "Slovenian",
    fi: "Suomi",
    sv: "Svenska",
    tr: "Türkçe"
}

var FilterLangs = [];

$(document).ready(() => {
    var isImportExportPage = window.location.href.indexOf("/ImportExport.aspx") > -1;
    if (isImportExportPage) {
        addLanguages();
    }

    $("#btnUpload").click((e) => {
        uploadAndTranslate();
        e.preventDefault();
    });

    $("#txtImportFile").change((e) => {
        e.preventDefault();
    });
});


function addLanguages() {
    var ddlExport = $("#ddlExport");
    var ddlImport = $("#ddlImport");
    var options = getOptionItems();

    ddlExport.append(options);
    ddlImport.append(options);
}


function addRows() {
    var langRows = $("#langRows");

    var options = getOptionItems();
    var ddl = '<div class="form-group"><div class="row"><div class="col-sm-2 padding-right-0"><select onChange="selectChanged(this);" class="form-control lang-ddl" style="width: 100%;"><option value="select" selected>Select language</option>' + options + '</select></div><div class="col-sm-9 padding-right-0"><input placeholder="Add language string" type="text" class="form-control"></div><div class="col-sm-1 padding-right-0"><button type="button" onClick="deleteRow(this);" class="btn btn-danger">Delete</button></div></div></div>';

    langRows.append(ddl);
}

function getOptionItems() {
    return Object.keys(Languages).
        //filter((key) =>FilterLangs.indexOf(key) === -1).
        map((key) => {
            return '<option value="' + key + '">' + Languages[key] + " - [" + key + ']</option>';
        });
}

function filterlanguages() {

}

function selectChanged(obj) {
    var count = 0;

    var rows = document.getElementsByClassName("row");

    for (var i = 0; i < rows.length; i++) {
        if (rows[i].querySelectorAll("select")[0].value === obj.value) {
            count++;
        }
    }

    if (count > 1) {
        alert("Language is already selected. Please re check.");
        obj.value = "select";
        return false;
    }
}

function deleteRow(obj) {
    obj.closest(".row").remove();
}

function updateTranslations() {
    var metaTag = document.getElementById("txtMetatag").value;
    var txtDesc = document.getElementById("txtDesc").value;

    if (!metaTag) {
        alert("Please enter correct data.");
        return false;
    }

    var result = confirm("It will update the translations. Are you sure you want to update?");

    if (result) {
        var langsWithValue = {
            MetaTag: metaTag,
            Description: txtDesc
        };

        var rows = document.getElementsByClassName("row");

        for (var i = 0; i < rows.length; i++) {
            if (rows[i].querySelectorAll("select")[0].value !== "select" && rows[i].querySelectorAll("input")[0].value.trim()) {
                langsWithValue[rows[i].querySelectorAll("select")[0].value.toUpperCase()] = rows[i].querySelectorAll("input")[0].value.trim();
            }
        }

        var updateTransBtn = document.getElementById("updateTransBtn");
        var addLangRow = document.getElementById("addLangRow");
        updateTransBtn.setAttribute("disabled", "disabled");
        addLangRow.setAttribute("disabled", "disabled");

        $.ajax({
            url: 'Default.aspx/UpdateTranslations',
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({ data: langsWithValue }),
            success: function (data) {
                if (data.d) {
                    updateTransBtn.removeAttribute("disabled");
                    addLangRow.removeAttribute("disabled");

                    alert("Records are updated  successfully.");
                    location.reload();
                }
            }
        });
    }
}

function exportData(type) {
    var lang = $("#ddlExport").val();

    if (lang === "select") {
        alert("Please select Export language.");
        return;
    } else {
        if (lang.toLocaleUpperCase() === "ZHCN") {
            lang = "[zh-cn]";
        } else if (lang.toLocaleUpperCase() === "ZHTW") {
            lang = "[zh-tw]";
        } else if (lang.toLocaleUpperCase() === "ptbr") {
            lang = "[pt-br]";
        }



        var data = { Type: type, Lang: lang };

        $.ajax({
            url: 'ImportExport.aspx/Export',
            type: "POST",
            contentType: 'application/json;charset=UTF-8',
            data: JSON.stringify({ data: data }),
            success: function (arrayBuffer) {
                var byteArray = new Uint8Array(arrayBuffer.d);
                var a = window.document.createElement('a');

                if (type === 'excel') {
                    a.href = window.URL.createObjectURL(new Blob([byteArray], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;base64," }));
                    a.download = $("#ddlExport").val() + '.xlsx';
                } else {
                    a.href = window.URL.createObjectURL(new Blob([byteArray], { type: "text/csv;charset=utf-8;" }));
                    a.download = $("#ddlExport").val() + '.csv';
                }

                document.body.appendChild(a);
                a.click();
                document.body.removeChild(a);

            }
        });
    }
}

function uploadAndTranslate() {
    var formData = new FormData();
    var ddlImport = $("#ddlImport");

    // add assoc key values, this will be posts values
    formData.append("file", $("#txtImportFile")[0].files[0]);

    $.ajax({
        url: 'ImportExport.aspx/UploadAndSave',
        type: "POST",
        contentType: false,
        processData: false,
        cache: false,
        enctype: 'multipart/form-data',
        data: formData,
        success: function (data) {
            console.log(data)
        }
    });
   
}