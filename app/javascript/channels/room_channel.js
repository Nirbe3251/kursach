import consumer from './consumer'

export function createRoom() {
  document.addEventListener('turbo:load', () => {
    let messages

    messages = document.getElementById('messages')

    if (messages) {
      createRoomChannel(messages.dataset.roomId)
    }

    const message = document.getElementById('message_body')

    if (message) {
      messages.scrollTop = messages.scrollHeight

      message.addEventListener('keydown', (event) => {
        if (event.key === 'Enter') {
          if (message.value.length > 0) {
            room.speak(message.value)
            message.value = ''
          }

          event.preventDefault()
        }
      })
    }
  })

  let room

  const createRoomChannel = (roomId) => {
    room = consumer.subscriptions.create({
      channel: 'RoomChannel',
      roomId: roomId
    }, {
      connected() {
        console.log('Connected to RoomChannel')
      },

      disconnected() {
        console.log('Disonnected from RoomChannel')
      },

      received(data) {
        console.log(data)
        messages.innerHTML += data['message']
        messages.scrollTop = messages.scrollHeight
      },

      speak: function(message) {
        return this.perform('speak', {
          message: message
        })
      }
    })
  }
}