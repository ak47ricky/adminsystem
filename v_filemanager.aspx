<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="v_filemanager.aspx.cs" Inherits="adminsystem.v_filemanager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
<link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/color.css"/>
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/demo/demo.css"/>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="https://www.jeasyui.com/easyui/jquery.easyui.min.js"></script>
        <script type="text/javascript" src="http://www.jeasyui.com/easyui/datagrid-detailview.js"></script>
    <script type="text/javascript" src="http://www.jeasyui.com/easyui/datagrid-bufferview.js"></script>
</head>
<body>
           <div id="cc" class="easyui-layout" style="width:90%;height:600px;">
        <div id="west" region="west" split="true" title="功能列表" style="width:30%;padding:10px;">
        </div>
        <div id="content" region="center" title="內容" style="padding:0px 5px;">
            <div style="margin:20px 0;"></div>
            <table id="tb_online" class="easyui-datagrid" style="width:100%;height:90%"
            data-options="url:'datagrid_data.json',fitColumns:true,singleSelect:true"">
            </table>
        </div>
    </div>
</body>
</html>
<script>
    function init() {
        getData();
    }

    $(document).ready(function () {
        init();
    });

    function getData() {
        $("#content").datagrid({
            url: "t1est.aspx",
            columns: [[
                { field: 'studentNumber', title: '學號', width: 100, halign: 'center' },
                { field: 'ENname', title: '英文名', width: 100, halign: 'center' },
                { field: 'CHname', title: '中文名', width: 100, halign: 'center' },
                { field: 'draft1Upload', title: 'Draft1上傳', width: 100, halign: 'center' },
                { field: 'tf1Upload', title: 'TF1上傳', width: 100, halign: 'center' },
                { field: 'draft2Upload', title: 'Draft2上傳', width: 100, halign: 'center' },
                { field: 'tf2Upload', title: 'TF2上傳', width: 100, halign: 'center' },
            ]],
            showFooter: true,
            //view: detailview,
        });


    }

</script>

<script type="text/javascript" src="js/buttonjs.js"></script>