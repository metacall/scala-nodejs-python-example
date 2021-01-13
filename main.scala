import metacall._

object Main {
	def main(args: Array[String]) = {
        MetaCall.metacall_initialize()
		MetaCall.metacall_load_from_file("node", Array("sum.js"))
		MetaCall.metacall_load_from_file("py", Array("multiply.py"))
		MetaCall.metacall_destroy()
	}
}
