/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db;

import config.EnvironmentConfiguration;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DB {
     /* Database connection settings, change dbName, dbusername, dbpassword */
	private final String dbServer = EnvironmentConfiguration.DB_SERVER;
	private final String dbServerPort = EnvironmentConfiguration.DB_PORT;
	private final String dbName = EnvironmentConfiguration.DB_NAME;
	private final String dbusername = EnvironmentConfiguration.DB_USERNAME;
	private final String dbpassword = EnvironmentConfiguration.DB_PASSWORD;

	private Connection con = null;

	/**
	 * Establishes a connection with the database, initializes and returns
	 * the Connection object.
	 *
	 * @return Connection, the Connection object
	 * @throws Exception
	 */
	public Connection getConnection() throws Exception {

		/* Step 1 -> Dynamically load the driver's class file into memory */

		try {

			// Dynamically load the driver's class file into memory
			Class.forName("com.mysql.jdbc.Driver").newInstance();

		} catch (Exception e) {

			throw new Exception("MySQL Driver error: " + e.getMessage());
		}

		/*
		 * Step 2 -> Establish a connection with the database and initializes
		 * the Connection object (con)
		 */

		try {

			con = DriverManager.getConnection("jdbc:mysql://"
				+ dbServer + ":" + dbServerPort + "/" + dbName, dbusername, dbpassword);

			// Step 3 -> returns the connection object
			return con;

		} catch (Exception e) {

			// throw Exception if any error occurs
			throw new Exception("Could not establish connection with the Database Server: "
				+ e.getMessage());
		}

	} // End of getConnection

	/**
	 * Close database connection. It is
	 * very important to close the database connection after it is used.
	 *
	 * @throws SQLException
	 */
	public void close() throws SQLException {

		try {

			// if connection is (still) open
			if (con != null)
				con.close(); // close the connection to the database to end database session

		} catch (SQLException e) {

			throw new SQLException("Could not close connection with the Database Server: "
				+ e.getMessage());
		}

	}// end of close

}
