package controllers

import java.nio.file.Files
import java.io.File

import javax.inject._
import org.apache.commons.codec.binary.Base64
import play.api.mvc.{Action, AnyContent, InjectedController}
import play.mvc.BodyParser
import services.{Config, FileManagerService}

import scala.concurrent.{ExecutionContext, Future}

@Singleton
class FileManagerController @Inject()(fileManager: FileManagerService,config: Config)
                                     (implicit ec: ExecutionContext)   extends InjectedController {

  def health(): Action[AnyContent] = Action {
    Ok(s"""{ "counter": "1" }""")
  }



  def health2(): Action[AnyContent] = Action { request =>

    val b = request.body
    Ok(s"""{ "counter": "1" }""")
  }



  private def saveToHdfs =
    Action.async(parse.multipartFormData) { request =>

      val filecontent: Option[String] = for {
        parts <- request.body.dataParts.get("content")
        first <- parts.headOption
      } yield first

      val filename: Option[String] = for {
        parts <- request.body.dataParts.get("filename")
        first <- parts.headOption
      } yield first

      filecontent.map(f =>{
     val b = f.split(",").tail.head
      fileManager.saveToHdfs(filename.head, Base64.decodeBase64(b))
      Future(Ok(s"""{ "response": "Archivo Enviado" }"""))}).getOrElse(Future(Ok("NO File uploaded")))
  }


  private def saveToLocal  =
    Action.async(parse.multipartFormData) { request =>
      request.body.file(config.get("file.key")).map(f => {
        f.ref.moveTo(new File(config.get("local.path") + f.filename))
        Future(Ok("File uploaded"))
      }).getOrElse(Future(Ok("NO File uploaded")))
    }



  def uploadFile() = saveToHdfs



  def downloadFile :Action[AnyContent] = Action {

    fileManager.download()
    Ok("ok")

  }


}