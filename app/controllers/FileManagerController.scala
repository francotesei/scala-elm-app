package controllers

import java.nio.file.Files
import java.io.File

import javax.inject._
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
     /*
      val filename: Option[String] = for {
        parts <- request.body.dataParts.get(config.get("file.key"))
        first <- parts.headOption
      } yield first

*/
      val a = request.body.as
    request.body.file(config.get("file.key")).map(f => {
      fileManager.saveToHdfs(f.filename, Files.readAllBytes(f.ref))
      Future(Ok("File uploaded"))}).getOrElse(Future(Ok("NO File uploaded")))
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