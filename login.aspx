<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="AdminSystem.login" %>

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

    <title>登入畫面</title>
    <style type="text/css">
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="tp" class="easyui-panel" title="管理者登入" style="width:400px;height:auto;padding:10px;">
        <div style="margin-bottom: 20px">
		<input class="easyui-textbox" id="loginname" name="account"
               prompt="account" iconWidth="28"
               data-options="label:'管理者名稱:',required:true"
		       style="width: 300px; height: 34px; padding: 10px;"/>
		</div>
        <div style="margin-bottom: 20px">
	    <input class="easyui-passwordbox" id="password" name="password"
			   prompt="password" iconWidth="28"
			   data-options="label:'密碼:',required:true"
			   style="width: 300px; height: 34px; padding: 10px"/>
		</div>
        <div style="margin-bottom: 20px ; margin-left:50px">
				<a href="javascript:void(0)" id="loginbtn"
					class="easyui-linkbutton" style="width: 80px">登入</a>
				<a href="javascript:void(0)" class="easyui-linkbutton"
					onclick="clearForm()" style="width: 80px">取消</a>
			</div>
            </div>
    </form>

    <script>
        $("#loginbtn").on("click", function() {
					/** 校驗登入引數 ctrl+K */
					var loginname = $("#loginname").val();
					var password = $("#password").val();
					if($("#form1").form('validate')){
						var msg = ""; 
						if (!/^\w{1,20}$/.test(loginname)) {
							msg = "登入名長度必須是1~20之間";
						} else if (!/^\w{1,20}$/.test(password)) {
							msg = "密碼長度必須是1~20之間";
						}
						if (msg != "") {
							$.messager.alert('使用者名稱密碼錯誤',msg,'info');
							return;
						}
					}
					
					 $.ajax({
                         url:'http://192.168.8.104/VS_Web/login.aspx?kind=1',
                         //url: 'model/m_login.aspx?kind=1',
						data:{loginname:loginname,password:password},
						error:function(res){
                            $.messager.alert('Error', res)
						},
						success:function(res){
                            if (res == "1")
                                $.messager.alert('Error', '登錄代碼錯誤');
                            else if (res == "2")
                                $.messager.alert('Error', '帳號錯誤');
                            else if (res == "3")
                                $.messager.alert('Error', '密碼錯誤');
                            else if (res == "99")
                                $.messager.alert('Error', '資料解析錯誤');
                            else {
                                $.messager.alert('succeed', '登入成功');
                            }
                            
						}
					});
				});


        function clearForm() {
				$('#form1').form('clear');
			}
    </script>

</body>
</html>