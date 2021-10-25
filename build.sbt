import sbt.Keys._

lazy val root = (project in file("."))
  .settings(
    name := "metacall-scala-nodejs-python-example",
    scalaVersion := "2.13.4",
    githubOwner := "metacall",
    githubRepository := "scala-nodejs-python-example",
    resolvers += Resolver.githubPackages("metacall", "scala-port"),
    libraryDependencies += "io.metacall" %% "metacall" % "0.1.0",
    scalacOptions ++= Seq(
      "-feature",
      "-deprecation",
      "-Xfatal-warnings"
    )
  )
