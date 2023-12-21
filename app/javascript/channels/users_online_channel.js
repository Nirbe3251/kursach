import consumer from './consumer'

export function UserOnlineSubscriptions() {
  consumer.subscriptions.create('UsersOnlineChannel', {
    connected() {
      console.log('connected to UsersOnlineChannel')
    },

    ban(token, id){
      var url = `/rooms/${token}`
      var check_url = `/rooms/${token}/user_ban`
      $.ajax({
        url: check_url,
        method: 'GET',
        data: {
            
            user_id: id,
            token: token
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
    },

    disconnected() {
      console.log('disconnected to UsersOnlineChannel')
    },
    received(user) {
      console.log(`UserOnline Data::Room::${user['room']}, Banned::${user['banned']}`)
      if (user['banned'] == true) {

        console.log("Banned go")
        this.ban(user['room'], user['user'])

      }
    }
  })
}
