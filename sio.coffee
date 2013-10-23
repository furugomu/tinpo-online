answer = ['お', 'ち', 'ん', 'ぽ']
characters = []

match = ->
  n = characters.length - answer.length
  return false if n < 0
  for i in [0...answer.length]
    return false if characters[n+i] != answer[i]
  true

choice = (a) ->
  a[Math.floor(Math.random() * a.length)]

module.exports = (io) ->
  io.sockets.on 'connection', (socket) ->
    char = choice(answer)
    socket.emit 'set character', char
    socket.emit 'set string', characters.join('')
    socket.on 'add', ->
      characters.push(char)
      characters.splice(0, 1) if characters.length > 1024
      io.sockets.emit 'set string', characters.join('')
      if match()
        io.sockets.emit 'win'
        characters = []
