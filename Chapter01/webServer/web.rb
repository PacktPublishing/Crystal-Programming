require 'socket'

server_thread = Thread.start do
  server = TCPServer.new('localhost', 8080)
  loop do
    Thread.start(server.accept) do |socket|
        request = socket.gets
        response = "Hello World!\n"

        socket.print "HTTP/1.1 200 OK\r\n" +
                      "Content-Type: text/plain\r\n" +
                      "Content-Length: #{response.bytesize}\r\n" +
                      "Connection: close\r\n"

        socket.print "\r\n"
        socket.print response
        socket.close
    end
  end
end

server_thread.join
