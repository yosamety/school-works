package ass2;

import java.net.*;
import java.util.*;
import java.io.*;

public class Client {
	public static void main(String[] args) throws IOException {

		int request = 0;
		int namePort = 0;
		DatagramSocket clientSocket = new DatagramSocket();

		// check number of arguments
		if (args.length != 2) {
			System.err.print("Invalid command line arguments\n");
			System.exit(1);
		}
		// check arguments type
		try {
			request = Integer.parseInt(args[0]);
			namePort = Integer.parseInt(args[1]);
		} catch (NumberFormatException e) {
			System.err.println("Invalid command line arguments\n");
			System.exit(1);
		}

		InetAddress IPAddress = InetAddress.getByName("127.0.0.1");
		// send look up for store
		byte[] sendDatals = new byte[1024];
		byte[] receiveDatals = new byte[1024];
		// send lookup request to name server for bank

		String ls = "l Store";
		sendDatals = ls.getBytes();
		DatagramPacket sendPacketls = new DatagramPacket(sendDatals,
				sendDatals.length, IPAddress, namePort);
		clientSocket.send(sendPacketls);
		// Wait for a reply
		DatagramPacket receivePacketls = new DatagramPacket(receiveDatals,
				receiveDatals.length);
		clientSocket.receive(receivePacketls);

		String replyls = new String(receivePacketls.getData());

		replyls = replyls.substring(0, receivePacketls.getLength());
		int storePort = 0;
		String ipStore = null;

		if (replyls != "Error: Process has not registered with the Name Server") {
			String[] splitted = replyls.split("\\s+");
			storePort = Integer.parseInt(splitted[0]);
			ipStore = splitted[1];

		} else {
			System.err.print("Client unable to connect with NameServer\n");
			System.exit(1);
		}

		byte[] sendDatacs = new byte[1024];
		byte[] receiveDatacs = new byte[1024];
		String creditcard = "1234567890123456";
		if (request == 0) {
			String cs = args[0];
			sendDatacs = cs.getBytes();
			DatagramPacket sendPacketcs = new DatagramPacket(sendDatacs,
					sendDatacs.length, IPAddress, storePort);
			// -----------------------PACKET LOSS
			// SIMULATION-----------------------------
			double rnd = Math.random();
			if (rnd > 0.5) {
				clientSocket.send(sendPacketcs);
			}
		} else {
			String cs = args[0] + " " + creditcard;
			sendDatacs = cs.getBytes();
			DatagramPacket sendPacketcs = new DatagramPacket(sendDatacs,
					sendDatacs.length, IPAddress, storePort);
			// -----------------------PACKET LOSS
			// SIMULATION-----------------------------
			double rnd = Math.random();
			if (rnd > 0.5) {
				clientSocket.send(sendPacketcs);
			}

		}

		// ----------RELIABILTY FUNCTION-----------------------
		clientSocket.setSoTimeout(2000); //wait 2 seconds for response
		int countSends = 0;
		// Wait for a reply
		while (true) {
			//Attempt sending message 4 times then quits
			countSends += 1;
			if (countSends == 4){
				System.err.print("Client unable to connect with Store\n");
				break;
			}
			try {
				DatagramPacket receivePacketcs = new DatagramPacket(
						receiveDatacs, receiveDatacs.length);
				clientSocket.receive(receivePacketcs);

				String replycs = new String(receivePacketcs.getData());

				replycs = replycs.substring(0, receivePacketcs.getLength());
				System.out.println(replycs);
				break;
			} catch (SocketTimeoutException e) {
				clientSocket.setSoTimeout(2000);

				if (request == 0) {
					String cs = args[0];
					sendDatacs = cs.getBytes();
					DatagramPacket sendPacketcs = new DatagramPacket(
							sendDatacs, sendDatacs.length, IPAddress, storePort);
					// -----------------------PACKET LOSS
					// SIMULATION-----------------------------
					double rnd = Math.random();
					if (rnd > 0.5) {
						clientSocket.send(sendPacketcs);
					}
				} else {
					String cs = args[0] + " " + creditcard;
					sendDatacs = cs.getBytes();
					DatagramPacket sendPacketcs = new DatagramPacket(
							sendDatacs, sendDatacs.length, IPAddress, storePort);
					// -----------------------PACKET LOSS
					// SIMULATION-----------------------------
					double rnd = Math.random();
					if (rnd > 0.5) {
						clientSocket.send(sendPacketcs);
					}
				}
				continue;

			} catch (IOException e) {
				e.printStackTrace();
			}
			DatagramPacket receivePacketcs = new DatagramPacket(receiveDatacs,
					receiveDatacs.length);
			clientSocket.receive(receivePacketcs);

			String replycs = new String(receivePacketcs.getData());

			replycs = replycs.substring(0, receivePacketcs.getLength());
			System.out.println(replycs);
			System.exit(1);
		}

	}

}
