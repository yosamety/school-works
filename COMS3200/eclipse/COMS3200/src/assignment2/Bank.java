package ass2;

import java.net.*;
import java.util.*;
import java.io.*;

@SuppressWarnings("unused")
public class Bank {
	@SuppressWarnings("resource")
	public static void main(String[] args) throws IOException {

		int bankPort = 0;
		int namePort = 0;
		ServerSocket serverSocket = null;

		DatagramSocket bankSocket = null;
		DatagramSocket clientSocket = new DatagramSocket();

		// check number of arguments
		if (args.length != 2) {
			System.err.print("Invalid command line arguments for Bank\n");
			System.exit(1);
		}
		// check arguments type
		try {
			bankPort = Integer.parseInt(args[0]);
			namePort = Integer.parseInt(args[1]);
		} catch (NumberFormatException e) {
			System.err.println("Bank unable to listen on given port\n");
			System.exit(1);
		}

		// try to listen on portNum
		try {
			bankSocket = new DatagramSocket(bankPort);
			System.err.print("Bank waiting for incoming connections\n");
		} catch (IOException e) {
			System.err.print("Bank unable to listen on given port\n");
			e.printStackTrace();
		}

		// set server's ip address
		InetAddress IPAddress = InetAddress.getByName("127.0.0.1");
		byte[] sendData = new byte[1024];
		byte[] receiveData = new byte[1024];

		// send register request to name server
		String msg = "r Bank " + bankPort + " 127.0.0.1";
		sendData = msg.getBytes();
		// send the message to server
		DatagramPacket sendPacket = new DatagramPacket(sendData,
				sendData.length, IPAddress, namePort);
		clientSocket.send(sendPacket);
		// receive reply message from server
		DatagramPacket receivePacket = new DatagramPacket(receiveData,
				receiveData.length);
		clientSocket.receive(receivePacket);

		String reply = new String(receivePacket.getData());

		reply = reply.substring(0, receivePacket.getLength());

		if (!reply.equals("registered")) {

			System.err.print("Bank registration with NameServer failed\n");
			System.exit(1);
		}
		// start listening
		while (true) {

			byte[] sendData2 = new byte[1024];
			byte[] receiveData2 = new byte[1024];
			DatagramPacket receivePacket2 = new DatagramPacket(receiveData2,
					receiveData2.length);
			bankSocket.receive(receivePacket2);

			String msg2 = new String(receivePacket2.getData());
			msg2 = msg2.substring(0, receivePacket2.getLength());
			// get the port of the client
			InetAddress IPAddress2 = receivePacket2.getAddress();
			int port = receivePacket2.getPort();
			// accept odd refuse even
			String[] splitted = msg2.split("\\s+");
			long creditCard = Long.valueOf(splitted[2]).longValue();
			long item = Long.valueOf(splitted[0]).longValue();
			if (item % 2 == 0) {
				// even
				String bankReply = "0";
				sendData2 = bankReply.getBytes();
				// send the message back to the client
				DatagramPacket sendPacket2 = new DatagramPacket(sendData2,
						sendData2.length, IPAddress, port);
				bankSocket.send(sendPacket2);
				System.out.print("NOT OK\n");
			} else {
				// odd
				String bankReply = "1";
				sendData2 = bankReply.getBytes();
				// send the message back to the client
				DatagramPacket sendPacket2 = new DatagramPacket(sendData2,
						sendData2.length, IPAddress, port);
				bankSocket.send(sendPacket2);
				System.out.print("OK\n");
			}

		}

	}
}
