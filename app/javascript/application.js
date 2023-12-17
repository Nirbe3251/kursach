// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import Turbolinks from 'turbolinks'
import "bootstrap"
import '@popperjs/core'
import Rails from '@rails/ujs'
// import 'bootstrap-icons/font/bootstrap-icons.css'
import "./channels"

Turbolinks.start()
Rails.start()

function Check() {
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
        if ($(this).attr('data-include') == 'true') {
            $(this).removeAttr('data-bs-toggle')
            $(this).removeAttr('data-bs-target')
            $(this).on('click', function() {window.location.href = url})
        } else {
            $(this).on('click', function() {
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
                            data: {password: password},
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
        }
    })
};
function CheckBan() {
    $("#user_ban").each(function() {
        $(this).on('click', function() {
            var url = `/rooms/${$(this).attr('token')}`
            var check_url = `/rooms/${$(this).attr('token')}/user_ban`
            $.ajax({
                url: check_url,
                method: 'GET',
                data: {
                    target: $(this).attr('target'),
                    user_id: $(this).attr('user_id'),
                    token: $(this).attr('token')
                },
                beforeSend: function(req) {
                    req.setRequestHeader("Accept", 'application/json')
                },
                success: function(data) {
                    console.log(data)
                    if (data == true) {
                        $(this).attr('target', false).text('разблокировать')
                        window.location.replace(url)
                    } else {
                        $(this).attr('target', true).text('заблокировать')
                        window.location.replace(url)
                    }
                },
                error: function(e) {
                    console.log(e)
                }
            })
        })
    });
};
import jQuery from 'jquery'
window.jQuery = jQuery
window.$ = jQuery
$(document).on('turbo:load load ready', function() {
    Check();
    CheckBan();
})