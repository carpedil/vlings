module main 

import term
import net.websocket



fn slog(message string) {
	eprintln(term.colorize(term.bright_yellow, message))
}

fn clog(message string) {
	eprintln(term.colorize(term.cyan, message))
}

fn wlog(message string) {
	eprintln(term.colorize(term.bright_blue, message))
}

// start_server starts the websocket server, it receives messages
// and send it back to the client that sent it
pub fn start_server() ! {
	mut s := websocket.new_server(.ip6, 30000, '')
	defer {
		unsafe {
			s.free()
		}
	}
	// Make that in execution test time give time to execute at least one time
	s.set_ping_interval(100)
	s.on_connect(fn (mut s websocket.ServerClient) !bool {
		slog('ws.on_connect, s.client_key: ${s.client_key}')
		// Here you can look att the client info and accept or not accept
		// just returning a true/false
		if s.resource_name != '/' {
			return false
		}
		return true
	})!
	s.on_message(fn (mut ws websocket.Client, msg &websocket.Message) ! {
		slog('s.on_message msg.opcode: ${msg.opcode} | msg.payload: ${msg.payload.bytestr()}')
		ws.write(msg.payload, msg.opcode) or {
			eprintln('ws.write err: ${err}')
			return err
		}
	})
	s.on_close(fn (mut ws websocket.Client, code int, reason string) ! {
		slog('s.on_close code: ${code}, reason: ${reason}')
		// println('client ($ws.id) closed connection')
	})
	s.listen() or {
		slog('s.listen err: ${err}')
		return err
	}
	slog('s.listen finished')
}
