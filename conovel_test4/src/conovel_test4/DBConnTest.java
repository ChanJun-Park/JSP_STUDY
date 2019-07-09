package conovel_test4;

import java.sql.*;
public class DBConnTest {

 public static void main(String[] args) {

  Connection conn=null;

  try {
	  while(true) {
		  Class.forName("oracle.jdbc.driver.OracleDriver");

	        System.out.println("JDBC Driver Loading Success");

	        long start = System.currentTimeMillis();

	        conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "scott", "tiger");

	        System.out.println("Connected..");

	        long stop = System.currentTimeMillis();

	        System.out.println("connected Time" + (stop - start) + " ms.");

	        conn.close(); 
	        try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	  }
        

  } catch (ClassNotFoundException cnfe) {

        System.out.println("Not Found Class.."+cnfe.getMessage());

  } catch(SQLException se){

        System.out.println(se.getMessage());

  } finally {

        if(conn != null)   try {conn.close();} catch (SQLException e) { e.printStackTrace();}

   }

 }

}