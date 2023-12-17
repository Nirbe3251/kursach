import consumer from './consumer'

export function UserOnlineSubscriptions() {
  consumer.subscriptions.create('UsersOnlineChannel', {
    connected() {
      console.log('connected to UsersOnlineChannel')
    },

    disconnected() {
      console.log('disconnected to UsersOnlineChannel')
    },
    received(user) {
      console.log(`User Online::${user['online']}`)
    }
  })
}
