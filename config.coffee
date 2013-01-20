module.exports =

  # server
  server:
    domain: 'localhost'
    port:   '8081'

  # cookies
  secret: 'secret_for_cookies' # the server secret will not be this.

  # socket.io
  socket:
    level: 2 # 0:error, 1:warn, 2:info, 3:debug
