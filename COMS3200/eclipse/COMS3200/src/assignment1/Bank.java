package ass1;

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
					serverSocket = new ServerSocket(bankPort);
					System.err.print("Bank waiting for incoming connections\n");
				} catch (IOException e) {
					System.err.print("Bank unable to listen on given port\n");
					e.printStackTrace();
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
			e.printStackTrace();
		}

		// send register request to name server
		outName.println("r Bank " + bankPort + " 127.0.0.1");
		// Wait for a reply
		String reply = inName.readLine();
		if (reply != "registered") {
			System.err.print("Bank registration to NameServer failed\n");
			System.exit(1);
		}
		outName.close();
		inName.close();
		nameSocket.close();
		
		Socket connSocket = null;
		//start listening
		while(true) {
        	try {
				// block, waiting for a conn. request
				connSocket = serverSocket.accept();
				// At this point, we have a connection
				
		    } catch (IOException e) {
		    	e.printStackTrace();
		    }
		    // Now have a socket to use for communication
		    // Create a PrintWriter and BufferedReader for interaction with our stream "true" means we flush the stream on newline
		    PrintWriter outBank = new PrintWriter(connSocket.getOutputStream(), true);
		    BufferedReader inBank = new BufferedReader(new InputStreamReader(connSocket.getInputStream()));
		    String line;
		    // Read a line from the stream - until the stream closes
		    while ((line=inBank.readLine()) != null) {
		    	//accept odd refuse even
		    	String[] splitted = line.split("\\s+");
		    	int creditCard = Integer.parseInt(splitted[2]);
		    	if (creditCard % 2 == 0) {
		    		  // even
		    		outBank.println("0");
	    			System.out.print("NOT OK\n");
		    		} else {
		    		  // odd
		    			outBank.println("1");
		    			System.out.print("OK\n");
		    		}
		    }
		    

		    outBank.close();
		    inBank.close();
		    connSocket.close();
        }
		
		
		
		
		
		
		
	}
}
