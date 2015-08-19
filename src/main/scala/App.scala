/**
 * Querying Cassandra from Scala
 */
import scala.io.Source
import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.Session;


object App {
    
  //--------------------------------------------------------------------------//
  val clusterBuilder = Cluster.builder()
  clusterBuilder.addContactPoint("127.0.0.1")
  clusterBuilder.withPort(9042)
  val cluster = clusterBuilder.build()
  val session = cluster.connect("engine35")
  println(session.getCluster().getClusterName + " connection successful\n")

  
  //--------------------------------------------------------------------------//
  def main(args: Array[String]) {

    var IP = "127.0.0.1"

    if (args.size > 0) {
      println("args: " + args(0))
      IP = args(0).toString
    }


    val filename = "/home/temp/sort3DCAVs"

    for (line <- Source.fromFile(filename).getLines()) {
       println(line)
       putQueryInsert(line)
    }

    disconnect("engine35");

  } // end of main
  //--------------------------------------------------------------------------//
  def putQueryInsert(url: String): Unit = {

      val SQL =
          "INSERT INTO engine35.bigtable (url)" +
          " VALUES ('" + url + "')"

      session.execute(SQL)
  }
  //--------------------------------------------------------------------------//

  def disconnect(str: String) {
    cluster.close()
    session.close()
    println("\n" + str + " successfully closed")
  }
  //--------------------------------------------------------------------------//

}
