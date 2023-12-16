// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import Turbolinks from 'turbolinks'
import "bootstrap"
import '@popperjs/core'
import Rails from '@rails/ujs'
import 'bootstrap-icons/font/bootstrap-icons.css'
import "./channels"
import "./scripts"

Turbolinks.start()

// Rails.start()

function CheckPassword() {
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
                            window.location.replace(url)
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

        // $('a').each(function(){
        //     if(typeof $(this).attr('data-path') !== typeof undefined && $(this).attr('data-path') !== false)
        //     {
        //         $(this).on('click', function(e){
        //             window.location.replace($(this).attr('data-path'));
        //             location.reload(true);
        //         })
        //     }
        // })
};

import jQuery from 'jquery'
window.jQuery = jQuery
window.$ = jQuery
$(document).on('turbo:load load ready ajax:before', function() {
    CheckPassword();
})