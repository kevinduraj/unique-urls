/**
 * Object for DataStax Driver To Query Cassandra
 */

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.Session;

object ObjCassandra {

  val clusterBuilder = Cluster.builder()
  clusterBuilder.addContactPoint("127.0.0.1")
  clusterBuilder.withPort(9042)
  // clusterBuilder.withCredentials("admin", "password") // optional
  val cluster = clusterBuilder.build()
  val session = cluster.connect("kevin")


  def putQueryInsert(loop: Int): ObjCassandra.type = {

    val rand = scala.util.Random
    var cnt=0
    println(session.getCluster().getClusterName + " connection successful\n")

    for (a <- 1 to loop) {
      val SQL =
        "INSERT INTO kevin.test (id, first_name, last_name)" +
        " VALUES ('" + rand.nextInt(1000000) + "', '" +
          randomAlphaNumericString(10) + "', '" +
          randomAlphaNumericString(5) + "')"

      if((cnt % 10)==0) println(cnt + " " + SQL)
      session.execute(SQL)
      cnt+=1
    }

    return this
  }

  def getQueryResult(): ObjCassandra.type = {

    println(session.getCluster().getClusterName + " connection successful\n")
    System.out.println("system.local: " + session.execute("select now() from system.local").one().getUUID(0) + "\n");

    val list = session.execute("SELECT * FROM kevin.test").all()

    val size = list.size()
    var counter=0;
    for (x <- 0 to size-1) {
      println(counter + ":\t"
        + list.get(x).getString("id") + "\t"
        + list.get(x).getString("name") + "\t"
        + list.get(x).getString("title"))
      counter+=1;
    }

    return this
  }

  def disconnect(str: String) {
    cluster.close()
    session.close()
    println("\n" + str + " successfully closed")
  }

  private def randomAlphaNumericString(length: Int): String = {
    val chars = ('a' to 'z') ++ ('A' to 'Z') ++ ('0' to '9')
    randomStringFromCharList(length, chars)
  }

  private def randomStringFromCharList(length: Int, chars: Seq[Char]): String = {
    val sb = new StringBuilder
    for (i <- 1 to length) {
      val randomNum = util.Random.nextInt(chars.length)
      sb.append(chars(randomNum))
    }
    sb.toString
  }
}
