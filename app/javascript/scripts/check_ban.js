export function CheckBan() {
    $("#user_ban").each(function() {
        $(this).on('click', function() {
            var url = `/rooms/${$(this).attr('data-token')}`
            var check_url = `/rooms/${$(this).attr('data-token')}/user_ban`
            $.ajax({
                url: check_url,
                method: 'GET',
                data: {
                    target: $(this).attr('data-target'),
                    user_id: $(this).attr('data-user-id'),
                    token: $(this).attr('data-token')
                },
                beforeSend: function(req) {
                    req.setRequestHeader("Accept", 'application/json')
                },
                success: function(data) {
                    console.log(data)
                    if (data == true) {
                        $(this).attr('data-target', false).text('разблокировать')
                        window.location.replace(url)
                    } else {
                        $(this).attr('data-target', true).text('заблокировать')
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