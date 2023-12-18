export function CheckBan() {
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