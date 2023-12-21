import consumer from './consumer'

export function UserOnlineSubscriptions() {
  consumer.subscriptions.create('UsersOnlineChannel', {
    connected() {
      console.log('connected to UsersOnlineChannel')
    },

    // ban(token, id){
    //   var url = `/rooms/${token}`
    //   var check_url = `/rooms/${token}/check_ban`
    //   $.ajax({
    //     url: check_url,
    //     method: 'GET',
    //     data: {
    //       user_id: id
    //     },
    //     beforeSend: function(req) {
    //         req.setRequestHeader("Accept", 'application/json')
    //     },
    //     success: function(data) {
    //       console.log(data)
    //       if (data == true) {
    //         window.location.replace('/')
    //       } else {
    //         window.location.replace(url)
    //       }
    //     },
    //     error: function(e) {
    //         console.log(e)
    //     }
    // })
    // },

    disconnected() {
      console.log('disconnected to UsersOnlineChannel')
    },
    received(user) {
      console.log(`UserOnline Data::Room::${user['room']}, Banned::${user['banned']}`)
      if (user['banned'] == true) {

        console.log("Banned go")
        window.location.replace('/')

      } else if (user['banned'] == false) {
        window.location.replace('/')
      }
    }
  })
}
