import metacall._, instances._
import java.nio.file.Paths
import scala.concurrent.{Future, Await, ExecutionContext}
import scala.concurrent.duration._
import ExecutionContext.Implicits.global

object Main extends App {
	Caller.start(ExecutionContext.global)

	private def await[A](f: Future[A]): A =
		Await.result(f, 2.seconds)

	await(Caller.loadFile(Runtime.Node, Paths.get("./scripts/sum.js").toAbsolutePath.toString))
	await(Caller.loadFile(Runtime.Python, Paths.get("./scripts/multiply.py").toAbsolutePath.toString))

	println(await(Caller.call("sum", (3, 6)))) // 9
	println(await(Caller.callV("multiply", List(LongValue(3), LongValue(6))))) // 18

	Caller.destroy()
}
