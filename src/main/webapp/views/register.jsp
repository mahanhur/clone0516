<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<script>
    let register_form = {
        init: function () {
            $('#register_button').addClass('disabled');
            $('#register_button').click(function () {
                register_form.send();
            });
            $('#name').keyup(function () {
                var id = $('#id').val();
                var pwd = $('#pwd').val();
                var name = $('#name').val();
                if (id != '' && pwd != '' && name != '') {
                    $('#register_button').removeClass();
                }
            })
            $('#id').keyup(function () {
                var txt_id = $(this).val();
                if (txt_id.length <= 3) {
                    return;
                }
                $.ajax({
                    url: '/checkid',
                    data: {id: txt_id},
                    success: function (result) {
                        if (result == 0) {
                            $('#check_id').text('��밡���մϴ�.');
                        } else {
                            $('#check_id').text('���Ұ����մϴ�.')

                        }
                    }
                })
            });
        },
        send: function () {
            var id = $('#id').val();
            var pwd = $('#pwd').val();
            var name = $('#name').val();
            if (id.length <= 3) {
                $('#check_id').text('4�ڸ� �̻��̾�� �մϴ�')
                $('#id').focus();
                return;
            }

            if (pwd == '') {
                $('#pwd').focus();
                return;
            }
            if (name == '') {
                $('#name').focus();
                return;
            }

            $('#register_form').attr({
                'action': '/registerimpl',
                'method': 'post'
            });
            $('#register_form').submit();
        }
    };

    $(function () {
        register_form.init();
    });
</script>

<div class="col-sm-8">
    <div class="container">
        <h1>ȸ������</h1><br/>

        <form id="register_form" class="form-horizontal text-left well">
            <div class="form-group">
                <label class="control-label col-sm-2" for="id">���̵�:</label>
                <div class="col-sm-8">
                    <input type="text" name="id" class="form-control" id="id" placeholder="���̵� �Է��ϼ���.">
                    <div class="col-sm-10">
                        <span id="check_id" class="bg-danger"></span>
                    </div>
                </div>

            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="pwd">��й�ȣ:</label>
                <div class="col-sm-8">
                    <input type="password" name="pwd" class="form-control" id="pwd" placeholder="��й�ȣ�� �Է��ϼ���">
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-2" for="pwd">�̸�:</label>
                <div class="col-sm-8">
                    <input type="text" name="name" class="form-control" id="name" placeholder="�̸��� �Է��ϼ���">
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-2" for="age">����:</label>
                <div class="col-sm-8">
                    <input type="text" name="age" class="form-control" id="age" placeholder="���̸� �Է��ϼ���">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="gender">����:</label>
                <div class="col-sm-8">
                    <input type="text" name="gender" class="form-control" id="gender" placeholder="������ �Է��ϼ���">
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button id="register_button" class="btn btn-default">ȸ������ �ϱ�</button>
                </div>
            </div>

        </form>

    </div>
</div>

<style>
    .container {
        width: 100%
    }
    #register_btn {
        float: right;
    }
    #register_btn {
        width: 150px;
        height: 30px;
        border-radius: 0;
        font-size: 12px;
        background-color: white;
        vertical-align: middle;
        margin-right: 20px;
    }
    #register_btn:hover {
        color: white;
        background-color: #222222;
    }

</style>
