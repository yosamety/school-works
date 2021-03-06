package ass2;

import java.net.*;
import java.util.*;
import java.io.*;

public class NameServer {
	@SuppressWarnings("resource")
	public static void main(String[] args) throws IOException {

		int portNum = 0;
		DatagramSocket serverSocket = null;

		// check number of arguments
		if (args.length != 1) {
			System.err.print("Invalid command line arguments for NameServer\n");
			System.exit(1);
		}
		// check arguments type
		try {
			portNum = Integer.parseInt(args[0]);
		} catch (NumberFormatException e) {
			System.err
					.println("Invalid command line arguments for NameServer\n");
			System.exit(1);
		}

		// try to listen on portNum
		try {
			serverSocket = new DatagramSocket(portNum);

		} catch (IOException e) {
			System.err.printf("Cannot listen on given port number %d\n",
					portNum);
			e.printStackTrace();
		}

		// create map to store registers
		Map<String, List<String>> servers = new HashMap<String, List<String>>();

		System.err.print("Name Server waiting for incoming connections �\n");
		while (true) {
			byte[] receiveData = new byte[1024];
			byte[] sendData = new byte[1024];

			// recive data
			DatagramPacket receivePacket = new DatagramPacket(receiveData,
					receiveData.length);
			serverSocket.receive(receivePacket);
			// make data string
			String msg = new String(receivePacket.getData());
			msg = msg.substring(0, receivePacket.getLength());
			String[] message = msg.split("\\s+");
			List<String> serverDetails = new ArrayList<String>();
			String rep = "";
			// get sender port
			InetAddress IPAddress = receivePacket.getAddress();
			int port = receivePacket.getPort();

			if (message[0].equals("r") && message.length == 4) {
				// register request
				// check message[2] is ip address
				// check message[3] is number
				serverDetails.add(message[2]);
				serverDetails.add(message[3]);
				servers.put(message[1], serverDetails);
				rep = "registered";
				sendData = rep.getBytes();
			} else if (message[0].equals("l") && message.length == 2) {
				// lookup request
				if (servers.containsKey(message[1])) {
					rep = (servers.get(message[1]).get(0)) + " "
							+ (servers.get(message[1]).get(1));
					sendData = rep.getBytes();
				} else {
					rep = ("Error: Process has not registered with the Name Server");
					sendData = rep.getBytes();
					System.err
							.print("Error: Process has not registered with the Name Server\n");
				}

			} else {
				System.err.print("Invalid request\n");
				break;
			}
			// send the message back to the client
			DatagramPacket sendPacket = new DatagramPacket(sendData,
					sendData.length, IPAddress, port);
			serverSocket.send(sendPacket);

		}

	}

}
