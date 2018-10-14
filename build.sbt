name := "ofertador-webapp"

version := "1.0-SNAPSHOT"

lazy val root = (project in file(".")).enablePlugins(PlayScala)

scalaVersion := "2.11.11"

libraryDependencies ++= Seq(
  guice,
  "org.scalatestplus.play" %% "scalatestplus-play" % "3.1.2" % Test,
  "javax.xml.bind" % "jaxb-api" % "2.3.0",
  "org.apache.hadoop" % "hadoop-client" % "2.7.0"
)


//Build elm app: sbt elmMake

