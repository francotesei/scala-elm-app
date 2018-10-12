package controllers

import java.nio.file.Files
import java.io.File
import javax.inject._
import play.api.mvc.{AnyContent, _}
import services.{ FileManagerService}


@Singleton
class FileManagerController @Inject()(fileManager:FileManagerService)   extends InjectedController {

  def health(): Action[AnyContent] = Action {
    Ok("ok")
  }
  def saveLoca  = Action(parse.multipartFormData) { request =>
    request.body.file("file1").map { picture =>
      val filename = picture.filename
      val contentType = picture.contentType
      picture.ref.moveTo(new File("/tmp/picture.txt"))
      Ok("File uploaded")
    }.getOrElse {
      Ok("NO File uploaded")
    }
  }


  def uploadFile = Action(parse.multipartFormData) { request =>
    request.body.file("file1").map { picture =>
      fileManager.upload(picture.filename,Files.readAllBytes(picture.ref))
      Ok("File uploaded")
    }.getOrElse {
      Ok("NO File uploaded")
    }
  }


  def downloadFile :Action[AnyContent] = Action {

    fileManager.download()
    Ok("ok")

  }


}