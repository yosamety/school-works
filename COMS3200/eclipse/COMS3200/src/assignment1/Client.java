package ass1;

import java.net.*;
import java.util.*;
import java.io.*;

public class Client {
	public static void main(String[] args) throws IOException {

		int request = 0;
		int namePort = 0;

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

		// open socket to contact name server
		Socket nameSocket = null;
		PrintWriter outName = null;
		BufferedReader inName = null;

		try {
			// Connect to the process listening on namePort on this host
			// (localhost)
			nameSocket = new Socket("127.0.0.1", namePort);
			outName = new PrintWriter(nameSocket.getOutputStream(), true);
			// "true" means flush at end of line
			inName = new BufferedReader(new InputStreamReader(
					nameSocket.getInputStream()));
		} catch (Exception e) {
			System.err.print("Client unable to connect with NameServer\n");
			e.printStackTrace();

		}
		// send lookup request to name server for store
		outName.println("l Store");
		// Wait for a reply
		String reply = inName.readLine();
		int storePort = 0;
		String ipStore = null;
		List<String> StoreData = new ArrayList<String>();
		if (reply != "Error: Process has not registered with the Name Server\n") {
			String[] splitted = reply.split("\\s+");
			storePort = Integer.parseInt(splitted[0]);
			ipStore = splitted[1];

		} else {
			System.err.print("Client unable to connect with NameServer\n");
			System.exit(1);
		}
		outName.close();
		inName.close();
		nameSocket.close();

		Socket storeSocket = null;
		PrintWriter outStore = null;
		BufferedReader inStore = null;
		try {
			// Connect to the process listening on namePort on this host
			// (localhost)
			storeSocket = new Socket(ipStore, storePort);
			outStore = new PrintWriter(storeSocket.getOutputStream(), true);
			// "true" means flush at end of line
			inStore = new BufferedReader(new InputStreamReader(
					nameSocket.getInputStream()));
		} catch (Exception e) {
			System.err.print("Client unable to connect with Store\n");
			e.printStackTrace();

		}
		String creditcard = "1234567890123456";
		if (request == 0) {
			outStore.println(args[0]);
		} else {
			outStore.println(args[0] + " " + creditcard);
		}
		// Wait for a reply
		String storeReply;
		while ((storeReply = inStore.readLine()) != null) {
			System.out.println(storeReply);
		}

		outStore.close();
		inStore.close();
		storeSocket.close();
		System.exit(1);
	}

}
