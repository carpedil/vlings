module main 

import vweb
import net
import log
import time
import json

struct MessageBody {
	msg string
	srv_ip_list []string
}

['/api/message/send'; post]
pub fn (mut app App) message_send() !vweb.Result {
	message_body := json.decode(MessageBody,app.req.data)!
	mut loger := log.Log{}
	handle_connect_and_send(message_body.srv_ip_list,mut loger)
	return app.json('message has been sent')
}

fn handle_connect_and_send(addrs []string, mut l log.Log) {
	l.info('Remote Tcp Server List : ${addrs}...')
	for addr in addrs {
		l.info('try to connect Remote Tcp Server @${addr}...')
		mut conn := connect_to_server(addr, mut l) or { return }
		defer {
			conn.close() or { l.error('Failed to close connection: ${err}') }
		}
		l.info('connected server @${conn.addr()}')

		// GETLOTINFO HDR=QUERY_SRV,FANET,WIN10-OSF2,JOBIN,3.0.0.204,5 DATETIME=20230727114155 LOT=WQB05596.1 OPERATOR=OSFPQ02068
		message := r'CHGLOTCMT HDR=CLOT_SRV,FANET,WIN10-OSF2,CLOTCMT,3.0.0.151,130 DATETIME=20230613113534 OPERATOR=OSFPQ02068 LOT=WQB05215.1 CMT="new cc comment"'

		ms := parse_message(message)
		l.info('[Send Message]:${ms}')

		send_message(mut conn, ms, mut l)
		time.sleep(800 * time.millisecond)
	}
}

fn connect_to_server(address string, mut l log.Log) !&net.TcpConn {
	return net.dial_tcp(address) or {
		l.error('Failed to connect to server: ${err}')
		return err
	}
}

fn send_message(mut conn net.TcpConn, message string, mut l log.Log) {
	conn.write_string(message) or { l.error('Failed to send message: ${err}') }
}

fn parse_message(msg string) string {
	msg_len := msg.len
	msg_len_self := msg_len.str().len
	return '${msg_len_self}${msg_len}${msg}'
}