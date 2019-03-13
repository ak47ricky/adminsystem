<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="account_control.aspx.cs" Inherits="AdminSystem.account_control" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/default/easyui.css"/> 
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/icon.css"/> 
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/color.css"/> 
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/demo/demo.css"/> 
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.9.1.min.js"></script> 
    <script type="text/javascript" src="https://www.jeasyui.com/easyui/jquery.easyui.min.js"></script> 
    <script type="text/javascript" src="http://www.jeasyui.com/easyui/datagrid-detailview.js"></script> 
    <script type="text/javascript" src="http://www.jeasyui.com/easyui/datagrid-bufferview.js"></script> 
    <title>帳號管理</title>
    <style type="text/css">
		#fm{
			margin:0;
			padding:10px 30px;
		}
		.ftitle{
			font-size:14px;
			font-weight:bold;
			padding:5px 0;
			margin-bottom:10px;
			border-bottom:1px solid #ccc;
		}
		.fitem{
			margin-bottom:5px;
		}
		.fitem label{
			display:inline-block;
			width:80px;
		}
		.fitem input{
			width:160px;
		}
	</style>
</head>

<body>
     <div id="cc" class="easyui-layout" style="width:90%;height:600px;"> 
        <div id="west" region="west" split="true" title="功能列表" style="width:30%;padding:10px;"></div> 
        <div id="content" region="center" title="帳號資料" style="padding:0px 5px;">  
            <div id="tb">
                <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">New User</a>
            	<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">Edit User</a>
	            <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">Remove User</a>
                <button id="TestBtn"></button>
            </div>
            <table id="tb_online" class="easyui-datagrid" style="width:100%;height:90%" rownumbers="true" fitColumns="true" singleSelect="true""></table> 
        </div> 
    </div>

    <div id="dlg" class="easyui-dialog" style="width:400px;height:320px;padding:10px 20px" closed="true" buttons="#dlg-buttons">
	    <div class="ftitle">建立新資料</div>
	        <form id="fm" method="post">
                <div class="fitem">
			        <label>流水號:</label>
			        <input name="ID" readonly ="true" placeholder="系統自動帶入">
		        </div>
		        <div class="fitem">
			        <label>帳號:</label>
			        <input name="account" class="easyui-validatebox" required="true">
		        </div>
		        <div class="fitem">
			        <label>密碼:</label>
			        <input name="password" class="easyui-validatebox" required="true">
		        </div>
                <div class="fitem">
			        <label>暱稱:</label>
			        <input name="nickname" class="easyui-validatebox" required="true">
		        </div>
		        <div class="fitem">
			        <label>登入權限:</label>
			        <input type ="checkbox" name="loginkind" style ="width:20px;height:20px" id="checkboxlogin">
		        </div>
	        </form>
    </div>
        <div id="dlg-buttons">
	        <a href="#" class="easyui-linkbutton" iconCls="icon-ok" id="saveuser">Save</a>
	        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">Cancel</a>
        </div>

    <script>
        //新增人員資料
        function newUser() {
            $('#dlg').dialog('open').dialog('setTitle', '新增人員資料');
            $('#fm').form('clear');
            //url = 'model/m_account_control.aspx?kind=1';
            url = 'http://192.168.8.104/VS_Web/account_control.aspx?kind=1';
        }

        //修改人員資料
        function editUser() {
            var row = $('#tb_online').datagrid('getSelected');
            if (row) {
                $('#dlg').dialog('open').dialog('setTitle', '修改人員資料');
                $('#fm').form('load', row);
                if (row.loginkind == 0)
                    $('#checkboxlogin')[0].checked = false;
                else 
                    $('#checkboxlogin')[0].checked = true;

                //url = 'model/m_account_control.aspx?kind=2';
                url = 'http://192.168.8.104/VS_Web/account_control.aspx?kind=2';
            }
        }

        //移除此使用者
        function destroyUser() {
            var row = $('#tb_online').datagrid('getSelected');
            if (row) {
                $.messager.confirm('確定移除', '移除此使用者:' + row.account + ' 暱稱:' + row.nickname, function (r) {
                    if (r) {
                        $.post('http://192.168.8.104/VS_Web/account_control.aspx?kind=3&ID=' + row.ID, function (result) {
                        //$.post('model/m_account_control.aspx?kind=3&ID=' + row.ID, function (result) {
                            if (result == "0") {
                                $('#tb_online').datagrid('reload');
                            } else {
                                $.messager.alert('Error', result);
                            }
                        }, 'json');
                    }
                });
            }
        }

        //存檔
        function saveUser() {
        }

        $(document).ready(function () {
            $("#saveuser").click(function () {
                var str = $("#fm").serialize();
                $.ajax(
                    {
                        url: url,
                        data: str,
                        method: "POST",
                        error: function (result) {
                            $.messager.alert('失敗', result);
                        },
                        success: function (result) {
                            if (result == "0") {
                                $.messager.alert('succeed', '成功');
                                $('#dlg').dialog('close');		// close the dialog
                                $('#tb_online').datagrid('reload');	// reload the user data
                            } else if (result == "1") {
                                $.messager.alert('Error', '使用者帳號重複');
                            } else
                                $.messager.alert('Error', '解析錯誤');
                        }
                    });
            });
        });


        $("#TestBtn").on("click", function () {
            QueryOnline();
        })

        function QueryOnline() {
            $('#tb_online').datagrid({
                //url: 'model/m_account_control.aspx?kind=0',
                url: 'http://192.168.8.104/VS_Web/account_control.aspx?kind=0',
                columns: [[
                    { field: 'account', title: '帳號', width: 150 },
                    { field: 'password', title: '密碼', width: 150 },
                    { field: 'nickname', title: '暱稱', width: 150 },
                    { field: 'loginkind', title: '登入權限', width: 150 },
                ]],
                
                detailFormatter: function (index, row) {
                    return '<div style="padding:5px 0"></div>';
                }
            })
        }
    </script>
</body>
</html>
