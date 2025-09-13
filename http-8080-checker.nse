-- http-8080-checker.nse
-- A simple script to check the root page on port 8080

local http = require "http"
local shortport = require "shortport"
local stdnse = require "stdnse"

-- Script metadata
description = [[
Sends a basic HTTP GET request to the root directory ("/") on port 8080
and displays the first 100 characters of the response body.
]]

author = "Gemini"
license = "Same as Nmap--See https://nmap.org/book/man-legal.html"
categories = {"discovery", "safe"}

-- Rule to determine when the script should run
portrule = shortport.port_or_service(8080, "http-proxy", "http")

-- The main action of the script
action = function(host, port)
  stdnse.log(1, "Running http-8080-checker on %s:%d", host.ip, port.number)

  -- Send an HTTP GET request to the root path "/"
  local response = http.get(host, port, "/")

  -- Check if a response was received
  if not response then
    return stdnse.format_output(false, "No response received from the server.")
  end

  -- Check for a valid response body
  if response.body then
    -- Return the first 100 characters of the body
    return string.sub(response.body, 1, 100)
  end
end