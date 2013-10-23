socket = io.connect()
button = document.getElementById('button')
string = document.getElementById('string')

socket.on 'set string', (s) ->
  string.textContent = s
socket.on 'set character', (c) ->
  button.textContent = c

socket.on 'win', ->
  result = document.getElementById('result')
  result.innerHTML =
    '<p>'+string.textContent+'<p>'+
    '<p>おぉぉおﾞおﾞ～っ！！イグゥウ！！イッグゥウウ！！</p>'+
    '<p>'+string.textContent.length+'回目で果てました...</p>'
  string.textContent = ''

button.addEventListener 'click', (e)->
  socket.emit 'add'
,false
