package ass1;

import java.net.*;
import java.util.*;
import java.io.*;

public class NameServer {
	@SuppressWarnings("resource")
	public static void main(String[] args) throws IOException {

		int portNum = 0;
		ServerSocket serverSocket = null;

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
			serverSocket = new ServerSocket(portNum);

		} catch (IOException e) {
			System.err.printf("Cannot listen on given port number %d\n",
					portNum);
			e.printStackTrace();
		}

		System.err.print("Name Server waiting for incoming connections …\n");

		// create map to store registers
		Map<String, List<String>> servers = new HashMap<String, List<String>>();
		Socket connSocket = null;
		while (true) {
			try {
				// block, waiting for a conn. request
				connSocket = serverSocket.accept();
				// At this point, we have a connection

			} catch (IOException e) {
				e.printStackTrace();
			}
			// Now have a socket to use for communication
			// Create a PrintWriter and BufferedReader for interaction with our
			// stream "true" means we flush the stream on newline
			PrintWriter out = new PrintWriter(connSocket.getOutputStream(),
					true);
			BufferedReader in = new BufferedReader(new InputStreamReader(
					connSocket.getInputStream()));
			String line;
			// Read a line from the stream - until the stream closes
			while ((line = in.readLine()) != null) {

				// Perform the job of the server - split strign to an array
				String[] message = line.split("\\s+");
				List<String> serverDetails = new ArrayList<String>();

				if (message[0] == "r" && message.length == 4) {
					// register request
					// check message[2] is ip address
					// check message[3] is number
					serverDetails.add(message[2]);
					serverDetails.add(message[3]);
					servers.put(message[1], serverDetails);
					System.out.println("registered");
				} else if (message[0] == "l" && message.length == 2) {
					// lookup request
					if (servers.containsKey(message[1])) {
						System.out.println(servers.get(message[1]).toString());
					} else {
						System.err
								.print("Error: Process has not registered with the Name Server\n");
					}

				} else {
					System.err.print("Invalid request\n");
					break;
				}
			}

			out.close();
			in.close();
			connSocket.close();
		}

	}

}
