/**
 * Created by xhuang on 4/12/15.
 */

import akka.actor.ActorSystem
import akka.http.Http
import akka.stream.FlowMaterializer
object SimpleServer extends App {
  implicit val system = ActorSystem()
  implicit val materializer = FlowMaterializer()
  val serverBinding = Http(system).bind(interface = "localhost", port = 8080)
  serverBinding.connections.foreach { connection => // foreach materializes the source
    println("Accepted new connection from " + connection.remoteAddress)
  }
}