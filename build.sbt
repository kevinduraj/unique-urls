name := "scala2cassandra"

version := "1.0"

scalaVersion := "2.11.6"

libraryDependencies ++= Seq(
  "com.datastax.cassandra" % "cassandra-driver-core" % "2.1.6"
  //,"org.slf4j" % "slf4j-api" % "1.7.12",
  //,"log4j" % "log4j" % "1.2.17"
  //,"org.apache.cassandra" % "cassandra-all" % "2.1.6"

)

/*
resolvers ++= Seq(
  "Typesafe repository snapshots" at "http://repo.typesafe.com/typesafe/snapshots/",
  "Typesafe repository releases"  at "http://repo.typesafe.com/typesafe/releases/",
  "Sonatype repo"                 at "https://oss.sonatype.org/content/groups/scala-tools/",
  "Sonatype releases"             at "https://oss.sonatype.org/content/repositories/releases",
  "Sonatype snapshots"            at "https://oss.sonatype.org/content/repositories/snapshots",
  "Sonatype staging"              at "http://oss.sonatype.org/content/repositories/staging",
  "Java.net Maven2 Repository"    at "http://download.java.net/maven/2/",
  "Twitter Repository"            at "http://maven.twttr.com",
  "Websudos releases"             at "http://maven.websudos.co.uk/ext-release-local"
)
*/