lazy val root = (project in file(".")).dependsOn(elmPlugin)

lazy val elmPlugin = ClasspathDependency(RootProject(file("../sbt-elm/")), None)

// The Play plugin
addSbtPlugin("com.typesafe.play" % "sbt-plugin" % "2.6.18")

// Adds dependencyUpdates task
addSbtPlugin("com.timushev.sbt" % "sbt-updates" % "0.3.4")
