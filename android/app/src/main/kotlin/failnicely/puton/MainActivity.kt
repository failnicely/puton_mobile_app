package failnicely.puton

import android.os.AsyncTask
import android.os.Bundle
import com.google.gson.JsonArray
import com.google.gson.JsonObject
import io.eosnova.wallet.android.sdk.NovaAuthCompat
import io.eosnova.wallet.android.sdk.OnNovaListener
import io.eosnova.wallet.android.sdk.model.NovaAction
import io.eosnova.wallet.android.sdk.model.NovaSignature
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugins.GeneratedPluginRegistrant
import org.json.JSONObject
import java.util.logging.Logger
import io.ipfs.api.IPFS
import io.ipfs.api.MerkleNode
import io.ipfs.api.NamedStreamable
import java.io.File
import com.google.gson.JsonParser




private const val NOVA_CHANNEL = "puton.failnicely.com/nova"
private const val TESTNET_BASE_URI = "http://192.168.31.182"

class MainActivity : FlutterActivity() {
  private lateinit var ipfs: IPFS

  private val callBack = object : OnNovaListener {
    override fun callback(map: HashMap<String, String>) {
      Logger.getLogger(this::class.java.name).warning(map.toString())
//      text.text = ""
//      for (key in map.keys) {
//        text.append("$key: ${map[key]}\n")
//      }
    }
  }


  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    initIpfs()
    initNova()
    initMethodChannel()
  }

  private fun initIpfs() {
    ipfs = InitIpfsTask().execute().get()
  }

  private fun initNova() {
    NovaAuthCompat.test = true
    NovaAuthCompat.register(this)
  }

  private fun initMethodChannel() {
    MethodChannel(flutterView, NOVA_CHANNEL).setMethodCallHandler(
        object : MethodCallHandler {
          @Override
          override fun onMethodCall(call: MethodCall, result: Result) {
            Logger.getLogger(this::class.java.name).info("onMethodCall")

            when {
              call.method == "requestAccount" -> requestAccountMethod(call, result)

              // sign
              call.method == "signature" -> signature(call, result)

              // cleos push action puton createuser '["tak"]' -p tak
              call.method == "createUser" -> createUser(call, result)

              // cleos push action puton addpost '["tak", "TAK_IPFS_ADDR_1"]' -p tak
              call.method == "savePostMethod" -> savePostMethod(call, result)

              call.method == "saveIpfsMethod" -> saveIpfsMethod(call, result)

              else -> result.notImplemented()
            }
          }

          private fun requestAccountMethod(recall: MethodCall, result: Result) {
            NovaAuthCompat.requestAccount(
                this@MainActivity,
                object : OnNovaListener {
                  override fun callback(map: HashMap<String, String>) {
                    Logger.getLogger(this::class.java.name).warning(map.toString())
                    result.success(JSONObject(map).toString())
                  }
                }
            )
          }

          private fun signature(call: MethodCall, result: Result) {
            Logger.getLogger(this::class.java.name).warning("signature ${call.arguments}")
            val signature = NovaSignature()
            signature.account = call.argument<String>("username")!!
//            signature.data = JsonParser().parse(call.argument<String>("json")!!).asJsonObject

            signature.data = JsonObject().apply {
              addProperty("key1", call.argument<String>("binargs")!!)
//              addProperty("key1", "{ \"code\": \"puton123serv\", \"action\": \"addpost\", \"args\": {\"author\":\"failnicely11\", \"ipfs_addr\":\"QFSDJklfjksdljflTEsT\"}}")
            }

            NovaAuthCompat.requestSignature(
                this@MainActivity,
                signature,
                object : OnNovaListener {
                  override fun callback(map: HashMap<String, String>) {
                    Logger.getLogger(this::class.java.name).warning("signature result $map")
                    result.success(map.toString())
                  }
                }
            )
          }

          private fun createUser(call: MethodCall, result: Result) {
            Logger.getLogger(this::class.java.name).warning("createUser ${call.arguments}")

            val transfer = NovaAction()
            transfer.account = call.argument<String>("username")!!
            transfer.contract = "asas123fdfsa"
            transfer.action = "createuser"
            transfer.args = JsonObject().apply {
              addProperty("account", call.argument<String>("username"))
            }.toString()

            NovaAuthCompat.requestTransaction(
                this@MainActivity,
                transfer,
                object : OnNovaListener {
                  override fun callback(map: HashMap<String, String>) {
                    Logger.getLogger(this::class.java.name).warning("createUser result $map")
                    result.success(map.toString())
                  }
                }
            )
          }

          private fun savePostMethod(call: MethodCall, result: Result) {
            Logger.getLogger(this::class.java.name).warning("savePostMethod ${call.arguments}")
            val transfer = NovaAction()
            transfer.account = call.argument<String>("username")!!
            transfer.contract = "asas123fdfsa"
            transfer.action = "addpost"
            transfer.args = JsonObject().apply {
              addProperty("author", call.argument<String>("username"))
              addProperty("ipfs_addr", call.argument<String>("ipfsHash"))
            }.toString()

            NovaAuthCompat.requestTransaction(
                this@MainActivity,
                transfer,
                object : OnNovaListener {
                  override fun callback(map: HashMap<String, String>) {
                    Logger.getLogger(this::class.java.name).warning("savePostMethod result $map")
                    result.success(map.toString())
                  }
                }
            )
          }

          private fun saveIpfsMethod(call: MethodCall, result: Result) {
            Logger.getLogger(this::class.java.name).info("saveIpfsMethod")
            Logger.getLogger(this::class.java.name).info(call.arguments.toString())
            Logger.getLogger(this::class.java.name).info((call.argument<String>("payload")))

            val payload = call.argument<String>("payload")
            result.success(AddIpfsTask().execute(ipfs, payload).get())
          }

        }
    )
  }

  override fun onDestroy() {
    super.onDestroy()
    NovaAuthCompat.unregister(this)
  }
}

class InitIpfsTask : AsyncTask<Void, Void, IPFS>() {
  override fun doInBackground(vararg params: Void?): IPFS? {
    println("${Thread.currentThread()} has run.")
    Logger.getLogger(this::class.java.name).info("test ipfs")
    val ipfs = IPFS("/ip4/52.79.151.139/tcp/5001")

    Logger.getLogger(this::class.java.name).info("test ipfs ${ipfs.host} ${ipfs.protocol} ${ipfs.port} ${ipfs.version()}")

//    val file = NamedStreamable.ByteArrayWrapper("hello.txt", "G'day world! IPFS rocks!".toByteArray())
//    Logger.getLogger(this::class.java.name).info("test file $file")
//
//    val addResult = ipfs.add(file)[0]
//    Logger.getLogger(this::class.java.name).info("test addResult $addResult")

    return ipfs
  }
}

class AddIpfsTask : AsyncTask<Any, Void, String>() {
  override fun doInBackground(vararg params: Any): String {
    println("${Thread.currentThread()} has run.")
    val ipfs = params[0] as IPFS
    val payload = params[1] as String

    val file = NamedStreamable.ByteArrayWrapper("post", payload.toByteArray())
    val addResult = ipfs.add(file)[0]

    Logger.getLogger(this::class.java.name).info("ipfs addResult ${addResult.hash}")

    return addResult.hash.toString()
  }
}