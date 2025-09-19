import { Application } from "@hotwired/stimulus"
import CommentController from "./controllers/comment_controller"
const application = Application.start()
application.register("comment", CommentController)
