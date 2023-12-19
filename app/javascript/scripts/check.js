export function Check() {
    const check_buttons = `
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
            Отмена
        </button>
        <button type="submit" class="btn btn-primary" id='confirmRoom'>
            Принять
        </button>
        `
    const check_footer = $('#check-modal-footer').html(check_buttons);
    const password_form = `
    <form>
        <div class="form-group row">
            <div class='input-group col-12'>
                <label for='passwd' class='col-sm-2 col-form-label'>Password:</label>
                <div class="col-sm-10">
                    <input type='password' id='passwd' class='form-control' required/>
                </div>
            </div>
        </div>
    </form>
    `
    const public_text = '<div>Вы хотите войти в эту комнату?</div>'
    const modal_body = $('#check-room-modal');
    const confirm = $('#confirmRoom');
    $('.check-password').each(function() {
        var status = $(this).attr('data-status');
        var token = $(this).attr('data-token');
        var url = `/rooms/${token}` 
        var check_url = `/rooms/${token}/check_password`;
        var banned = $(this).attr('data-banned');
        if (banned == 'true'){
            $(this).attr('data-bs-target', '#ban-modal')
        } else {            
        if ($(this).attr('data-include') == 'true') {
            console.log('ok')
            $(this).removeAttr('data-bs-toggle')
            $(this).removeAttr('data-bs-target')
            console.log(url)
            $(this).on('click', function() {window.location.replace(url)})
        } else {
            $(this).on('click', function() {
                console.log('not_ok')
                if (status == 'pub') {
                    modal_body.html(public_text)
                    confirm.on('click', function(){
                        $.ajax({
                            url: `/rooms/${token}/add_user`,
                            method: 'GET',
                            data: {user_id: $('body').attr('data-user')},
                            beforeSend: function(req) {
                                req.setRequestHeader("Accept", 'application/json')
                            },
                            success: function(data) {
                                console.log(data)
                                window.location.replace(url)
                            },
                            error: function(e) {
                                console.log(e)
                            }
                        })
                    })
                } else {
                    modal_body.html(password_form)
                    confirm.on('click', function() {
                        let password = $('#passwd').val();
                        console.log(`Password:::: ${password}`);
                        $.ajax({
                            url: check_url,
                            method: 'GET',
                            beforeSend: function(req) {
                                req.setRequestHeader("Accept", 'application/json')
                            },
                            data: {password: password, user_id: $('body').attr('data-user')},
                            success: function(res) {
                                console.log('success')
                                console.log(res)
                                if (res == true) {
                                    console.log('good password')
                                    window.location.replace(url)
                                } else {
                                    console.log('bad password')
                                }
                            },
                            error: function(e) {
                                console.log('error')
                                console.log(e.responseText)
                            }
                        })
                    })
                };
            })
        }}
    })
};