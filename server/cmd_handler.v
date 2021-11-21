module server

import os
import io
import net
import server
import skrillec_cp

pub struct Current{
	pub mut:	
		fullcmd		string
		cmd			string
		cmd_args	[]string
}

pub fn (mut c Current) handle_cmd(data string) {
	c.fullcmd = data
	if data.contains(" ") {
		c.cmd_args = data.split(" ")
		c.cmd = c.cmd_args[1]
	} else {
		c.cmd_args = data.split(" ")
		c.cmd = data
	}
	println(c.fullcmd)
	println(c.cmd)
	println(c.cmd_args)
}

pub fn (mut c Current) reset_cmd_data() {
	c.fullcmd = ""
	c.cmd = ""
	c.cmd_args = ["", ""]
}

pub fn cmd_handler(mut socket net.TcpConn, mut svr server.Server, mut c Current) {
	mut reader := io.new_buffered_reader(reader: socket)

	for {
		socket.write_string("[Skrillec@NET]# ") or { 0 }
		mut data := reader.read_line() or { "" }
		if data.len > 0 {
			c.handle_cmd(data)
			// Parse command here with a match statement
			match c.cmd {
				"cls" {
             		socket.write_string("\x1b[2K\r") or { 0 }
				}
				"attack" {
             		println("TEST STRESS")
				}
				"help" {
            		println("TEST HELP")
				}
				"methods" {
             		println("TEST METHODS")
				}
				"passwd" {
            		println("TEST PASSWD")
				} else {
					socket.write_string("Command not found!\r\n") or { 0 }
				}
			}
			println(data)
		}
	}
}