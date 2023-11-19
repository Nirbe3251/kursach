import consumer from './consumer'

function findOrAppendTag(user) {
  let li = document.getElementById(`user_online_${user['id']}`)

  if (li) {
    return
  }

  const ul = document.getElementById('users')

  li = document.createElement('li')
  li.id = `user_online_${user['id']}`

  li.append(user['nickname'])
  ul.append(li)
}

function removeTag(user) {
  const li = document.getElementById(`user_online_${user['id']}`)

  li.remove()
}

consumer.subscriptions.create('UsersOnlineChannel', {
  connected() {
  },

  disconnected() {
  },

  received(user) {
    user['online'] ? findOrAppendTag(user) : removeTag(user)
  }
})
