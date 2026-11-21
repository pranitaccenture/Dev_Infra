from http.server import HTTPServer, BaseHTTPRequestHandler
class MyApp(BaseHTTPRequestHandler):
   def do_GET(self):
       self.send_response(200)
       self.send_header("Content-type", "text/html")
       self.end_headers()
       html = """
<html>
<body style="font-family:Arial;text-align:center;padding:80px">
<h1>Hello from Pranit!</h1>
<h2>Python application is running.</h2>
<p>Docker Container Deployment</p>
</body>
</html>
       """
       self.wfile.write(html.encode())
server = HTTPServer(("0.0.0.0", 5000), MyApp)
print("Python application running on port 5000")
server.serve_forever()